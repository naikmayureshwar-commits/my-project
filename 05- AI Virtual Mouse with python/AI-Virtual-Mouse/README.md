AI Virtual Mouse Using Hand Gestures
Project Overview
AI Virtual Mouse is a Python-based computer vision project that allows users to control mouse movements and perform mouse actions using hand gestures.

The project uses a webcam to detect and track hand movements in real time, enabling touchless computer interaction.

Features
Real-time hand detection and tracking.
Control mouse cursor using hand movements.
Perform mouse clicks using hand gestures.
Touchless computer interaction.
Webcam-based gesture recognition.
Technologies Used
Python
OpenCV
MediaPipe
NumPy
AutoPy
PyAutoGUI
Project Structure
AI-Virtual-Mouse/
│
├── AIvirtualmouse.py
├── HandTrackingModule.py
├── requirements.txt
├── README.md
└── .gitignore
Installation and Setup
1. Clone the repository
git clone https://github.com/naikmayureshwar-commits/my-project.git
2. Navigate to the project directory
cd my-project
3. Create a virtual environment
python -m venv .venv
4. Activate the virtual environment
Windows:

.venv\Scripts\activate
5. Install dependencies
pip install -r requirements.txt
6. Run the application
python AIvirtualmouse.py
How It Works
The webcam captures real-time video.
MediaPipe detects and tracks hand landmarks.
OpenCV processes the video frames.
Hand movements are translated into mouse cursor movements.
Gesture recognition triggers mouse actions.
Author
Mayureshwar Naik

License
This project is available for educational and portfolio purposes.
