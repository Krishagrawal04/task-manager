Create a complete Task Manager web app (HTML, CSS, JavaScript) with the following:

1. Features:
   - Add, delete, and mark tasks complete
   - Store data in localStorage

2. Project structure:
   - index.html
   - style.css
   - script.js

3. CI/CD:
   - Include a GitHub Actions workflow to deploy to GitHub Pages on push to main

4. Automation script:
   - Create a bash script called setup.sh that:
     a. Initializes a git repository
     b. Adds all files and commits
     c. Uses GitHub CLI (gh) to create a new public repository
     d. Pushes the code to the main branch
     e. Enables GitHub Pages automatically using gh commands

5. README:
   - Explain that running `bash setup.sh` will fully deploy the project

6. Code quality:
   - Clean, commented code
