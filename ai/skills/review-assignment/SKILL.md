---
name: review-assignment
description: Reviews assignment submissions by extracting validation accuracy and precision from code, reports, or result files. Use when evaluating multiple student submissions or grading ML assignments in bulk.
---

When reviewing an assignment, always follow these steps:

1. **Scan the working directory**
   - Look at *all files and folders* in the current directory
   - Identify archives such as `.zip`, `.tar`, `.tar.gz`, `.tgz`, etc.

2. **Uncompress archives**
   - Extract each archive into its own folder
   - Preserve original names so each submission can be traced back to a person

3. **Identify the submission owner**
   - Infer the name from:
     - Folder name
     - Archive name
     - Student name inside README, report, or metadata
   - If no name can be inferred, use the folder or file name as-is

4. **Search for results**
   - Look through:
     - README files
     - Assignment reports (PDF, Markdown, TXT)
     - Jupyter notebooks
     - Python scripts
     - Result logs
     - CSV or JSON output files
   - Specifically try to find:
     - Validation accuracy (`val_acc`, `val_accuracy`, etc.)
     - Validation precision (`val_precision`, `precision`, etc.)

5. **Extract metrics**
   - Normalize values into percentages where possible
   - If multiple values exist, use the *final* or *best validation* result
   - If a metric cannot be found, leave it blank

6. **Track missing or incomplete results**
   - Include *every* identified submission in the output
   - Do **not** drop entries that are missing metrics

7. **Produce a final CSV-style summary**
   - There must be two outputs
   - Output1 must be in the following format:
     ```
     name, val_acc, val_precision
     DariusSingh, 80%, 85%
     PersonB, 71%, 76%
     PersonC, , 82%
     PersonD, ,
     ```
   - Output2 must be in the following format:
     ```
     name, val_precision above 85
     DariusSingh, yes
     PersonB, no
     PersonC, 
     ```

8. **Be explicit about uncertainty**
   - If assumptions were made (e.g., inferred name, guessed metric source), note them clearly
   - Do not fabricate metrics under any circumstances

Keep the review systematic and neutral. Favor correctness and traceability over completeness.
