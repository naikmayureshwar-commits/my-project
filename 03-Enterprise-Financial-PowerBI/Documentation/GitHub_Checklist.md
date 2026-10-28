# GitHub Publishing Checklist

## Files and structure

- [ ] Put this project's `README.md` at the root of `Enterprise-Financial-PowerBI/` so it appears prominently on GitHub.
- [ ] Keep the CSV source tables in `Data/` and retain descriptive file names.
- [ ] Keep `Enterprise_Financial_Analytics.pbix` in `Dashboard/`.
- [ ] Add genuine screenshots of the Executive Overview and Business Insights pages to `Dashboard/screenshots/`.
- [ ] Keep `Data_Dictionary.md`, `DAX_Measures.md`, `Business_Insights.md`, and this checklist under `Documentation/`.
- [ ] Confirm any local CSV paths are documented and make it clear if users need to update data source paths in Power BI.

## Quality checks

- [ ] Open the saved PBIX and refresh the data successfully.
- [ ] Clear slicers and verify KPI totals against the README.
- [ ] Test Year, Region, and Department slicers.
- [ ] Verify month charts sort chronologically from Jan 2024 through Dec 2025.
- [ ] Check all visuals and text at normal report-page zoom.
- [ ] Confirm the business insights describe observations, while recommendations are clearly presented as proposed actions.
- [ ] State that the dataset is a portfolio/demo dataset, not real-company financial data.

## GitHub size guidance

Check the file size of the PBIX before uploading. GitHub's browser upload is limited to 25 MiB per file; command-line Git can push files larger than that, but regular Git repositories block individual files above 100 MiB. For files above the regular Git limit, use Git LFS or a suitable external download location. See the official [GitHub guidance on file sizes](https://docs.github.com/en/repositories/working-with-files/managing-files/adding-a-file-to-a-repository) and [large files](https://docs.github.com/en/repositories/working-with-files/managing-large-files/about-large-files-on-github).

## Before sharing publicly

- [ ] Review all files for personal data, credentials, local absolute paths, or unrelated files.
- [ ] Make sure all screenshots are your own report captures and do not contain personal information.
- [ ] Save the PBIX after the final checks.
- [ ] Use a clear commit message, such as `Add financial analytics Power BI project documentation`.
