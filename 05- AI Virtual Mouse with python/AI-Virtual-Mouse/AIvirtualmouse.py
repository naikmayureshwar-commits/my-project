import cv2
import numpy as np
import HandTrackingModule as htm
import time
import autopy
import pyautogui

# Brightness control (cross-platform) via screen_brightness_control
try:
    import screen_brightness_control as sbc
    sbc.get_brightness()  # quick check that it actually works on this machine
    BRIGHTNESS_AVAILABLE = True
except Exception as e:
    print(f"Brightness control unavailable: {e}")
    BRIGHTNESS_AVAILABLE = False

# Volume control (Windows) via pycaw
try:
    from ctypes import cast, POINTER
    from comtypes import CLSCTX_ALL
    from pycaw.pycaw import AudioUtilities, IAudioEndpointVolume
    devices = AudioUtilities.GetSpeakers()
    interface = devices.Activate(IAudioEndpointVolume._iid_, CLSCTX_ALL, None)
    volume = cast(interface, POINTER(IAudioEndpointVolume))
    minVol, maxVol = volume.GetVolumeRange()[:2]
    VOLUME_AVAILABLE = True
except Exception as e:
    print(f"Volume control unavailable: {e}")
    VOLUME_AVAILABLE = False

##########################
wCam, hCam = 640, 480
frameR = 100
smoothening = 7
volStep = 0.05          # volume change per Volume Up/Down gesture (5%)
brightStep = 10         # brightness change per gesture, in percent (0-100 scale)
CONFIRM_FRAMES = 5      # consecutive frames a gesture must hold before it fires
RELEASE_FRAMES = 5      # consecutive frames gesture must be absent before it can re-fire
##########################

pTime = 0
plocX, plocY = 0, 0
clocX, clocY = 0, 0

# Debounce state
armedGesture = ""       # gesture that is allowed to fire next ("" = none armed yet needed)
candidateGesture = ""   # gesture currently being observed
candidateCount = 0      # how many consecutive frames candidateGesture has been seen
firedGesture = ""       # gesture that has already fired and is waiting to be released
noMatchCount = 0        # consecutive frames with no recognized gesture (for release)

cap = cv2.VideoCapture(0)
cap.set(3, wCam)
cap.set(4, hCam)

if not cap.isOpened():
    print("Error: Could not open camera.")
    exit()

detector = htm.handDetector(maxHands=1)
wScr, hScr = autopy.screen.size()


def takeScreenshot():
    timestamp = int(time.time() * 1000)  # milliseconds avoids same-second overwrite
    filename = f"screenshot_{timestamp}.png"
    screenshot = pyautogui.screenshot()
    screenshot.save(filename)
    print(f"Screenshot saved as {filename}")


def changeVolume(direction):
    """direction: 'up' or 'down'"""
    if not VOLUME_AVAILABLE:
        print(f"Volume {direction} requested, but pycaw is unavailable on this OS.")
        return
    currentVol = volume.GetMasterVolumeLevelScalar()
    if direction == "up":
        newVol = min(1.0, currentVol + volStep)
    else:
        newVol = max(0.0, currentVol - volStep)
    volume.SetMasterVolumeLevelScalar(newVol, None)
    print(f"Volume {direction}: {int(newVol * 100)}%")


def changeBrightness(direction):
    """direction: 'up' or 'down'"""
    if not BRIGHTNESS_AVAILABLE:
        print(f"Brightness {direction} requested, but screen_brightness_control is unavailable.")
        return
    try:
        currentBright = sbc.get_brightness()[0]
        if direction == "up":
            newBright = min(100, currentBright + brightStep)
        else:
            newBright = max(0, currentBright - brightStep)
        sbc.set_brightness(newBright)
        print(f"Brightness {direction}: {newBright}%")
    except Exception as e:
        print(f"Brightness {direction} failed: {e}")


def classifyGesture(fingers):
    """Return a gesture name for special poses, or '' if none matches.
    Thumb state is ignored because thumb detection (based on x-position)
    is unreliable at many hand angles."""
    thumb, index, middle, ring, pinky = fingers

    # Pinky only up, others down (thumb ignored) -> screenshot
    if index == 0 and middle == 0 and ring == 0 and pinky == 1:
        return "screenshot"

    # Index + middle + ring up, pinky down (thumb ignored) -> volume up
    if index == 1 and middle == 1 and ring == 1 and pinky == 0:
        return "vol_up"

    # Index + middle + ring + pinky all up (thumb ignored) -> volume down
    if index == 1 and middle == 1 and ring == 1 and pinky == 1:
        return "vol_down"

    # Middle + ring + pinky up, index down (thumb ignored) -> brightness up
    if index == 0 and middle == 1 and ring == 1 and pinky == 1:
        return "bright_up"

    # Ring + pinky up only, index and middle down (thumb ignored) -> brightness down
    if index == 0 and middle == 0 and ring == 1 and pinky == 1:
        return "bright_down"

    return ""


while True:
    success, img = cap.read()
    if not success:
        print("Error: Failed to capture image")
        continue

    img = detector.findHands(img)
    lmList, bbox = detector.findPosition(img)

    if len(lmList) != 0:
        x1, y1 = lmList[8][1:]
        x2, y2 = lmList[12][1:]

        fingers = detector.fingersUp()  # [thumb, index, middle, ring, pinky]
        cv2.rectangle(img, (frameR, frameR), (wCam - frameR, hCam - frameR), (255, 0, 255), 2)

        # DEBUG: show live finger state on screen (remove once gestures feel reliable)
        cv2.putText(img, f'Fingers: {fingers}', (20, hCam - 20),
                    cv2.FONT_HERSHEY_PLAIN, 1.5, (0, 255, 255), 2)

        # ---- Move mouse (index finger only up; thumb ignored, unreliable) ----
        if fingers[1] == 1 and fingers[2] == 0 and fingers[3] == 0 and fingers[4] == 0:
            x3 = np.interp(x1, (frameR, wCam - frameR), (0, wScr))
            y3 = np.interp(y1, (frameR, hCam - frameR), (0, hScr))

            clocX = plocX + (x3 - plocX) / smoothening
            clocY = plocY + (y3 - plocY) / smoothening

            autopy.mouse.move(wScr - clocX, clocY)
            cv2.circle(img, (x1, y1), 15, (255, 0, 255), cv2.FILLED)
            plocX, plocY = clocX, clocY

        # ---- Click (index + middle fingers close together; thumb ignored) ----
        if fingers[1] == 1 and fingers[2] == 1 and fingers[3] == 0 and fingers[4] == 0:
            length, img, lineInfo = detector.findDistance(8, 12, img)
            if length < 40:
                cv2.circle(img, (lineInfo[4], lineInfo[5]), 15, (0, 255, 0), cv2.FILLED)
                autopy.mouse.click()

        # ---- Debounced special gestures: screenshot / volume up / volume down ----
        gesture = classifyGesture(fingers)

        if gesture == "":
            # No special pose right now
            candidateGesture = ""
            candidateCount = 0
            noMatchCount += 1
            if noMatchCount >= RELEASE_FRAMES:
                firedGesture = ""  # fully released, ready to fire again next time
        else:
            noMatchCount = 0
            if gesture == candidateGesture:
                candidateCount += 1
            else:
                candidateGesture = gesture
                candidateCount = 1

            # Only fire once the pose has been stable for CONFIRM_FRAMES,
            # and only if this exact gesture hasn't already fired (still held)
            if candidateCount >= CONFIRM_FRAMES and firedGesture != gesture:
                if gesture == "screenshot":
                    takeScreenshot()
                elif gesture == "vol_up":
                    changeVolume("up")
                elif gesture == "vol_down":
                    changeVolume("down")
                elif gesture == "bright_up":
                    changeBrightness("up")
                elif gesture == "bright_down":
                    changeBrightness("down")
                firedGesture = gesture

            # Show label while holding a confirmed pose
            if firedGesture == "screenshot" and gesture == "screenshot":
                cv2.putText(img, "Screenshot Taken!", (180, 40),
                            cv2.FONT_HERSHEY_PLAIN, 2, (0, 255, 255), 3)
            elif firedGesture == "vol_up" and gesture == "vol_up":
                cv2.putText(img, "Volume Up", (180, 40),
                            cv2.FONT_HERSHEY_PLAIN, 2, (0, 255, 0), 3)
            elif firedGesture == "vol_down" and gesture == "vol_down":
                cv2.putText(img, "Volume Down", (180, 40),
                            cv2.FONT_HERSHEY_PLAIN, 2, (0, 0, 255), 3)
            elif firedGesture == "bright_up" and gesture == "bright_up":
                cv2.putText(img, "Brightness Up", (180, 40),
                            cv2.FONT_HERSHEY_PLAIN, 2, (255, 255, 0), 3)
            elif firedGesture == "bright_down" and gesture == "bright_down":
                cv2.putText(img, "Brightness Down", (180, 40),
                            cv2.FONT_HERSHEY_PLAIN, 2, (255, 128, 0), 3)
    else:
        # Hand left the frame -> count toward release so next entry can fire fresh
        noMatchCount += 1
        if noMatchCount >= RELEASE_FRAMES:
            firedGesture = ""
            candidateGesture = ""
            candidateCount = 0

    cTime = time.time()
    fps = 1 / (cTime - pTime)
    pTime = cTime
    cv2.putText(img, f'FPS: {int(fps)}', (20, 50), cv2.FONT_HERSHEY_PLAIN, 3, (255, 0, 0), 3)

    cv2.imshow("AI Virtual Mouse", img)

    if cv2.waitKey(1) & 0xFF in [ord('q'), 27]:
        print("Closing webcam...")
        break

cap.release()
cv2.destroyAllWindows()
