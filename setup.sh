#!/bin/bash

set -e

echo "=== Task Manager Setup Script ==="
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Error: git is not installed"
    exit 1
fi

# Check if gh is installed
if ! command -v gh &> /dev/null; then
    echo "Error: GitHub CLI (gh) is not installed"
    echo "Install it from: https://github.com/cli/cli#installation"
    exit 1
fi

# Check if user is logged in
if ! gh auth status &> /dev/null; then
    echo "Error: Not logged in to GitHub"
    echo "Run 'gh auth login' first"
    exit 1
fi

# Initialize git repository
echo "Initializing git repository..."
git init

# Configure git (use gh user config if available)
GH_USER=$(gh api user --jq .login 2>/dev/null || echo "user")
git config user.name "$GH_USER" 2>/dev/null || true
git config user.email "${GH_USER}@users.noreply.github.com" 2>/dev/null || true

# Add all files
echo "Adding files..."
git add .

# Create initial commit
echo "Creating initial commit..."
git commit -m "Initial commit: Task Manager app"

# Get repository name
REPO_NAME="task-manager"

# Create repository on GitHub
echo "Creating GitHub repository: $REPO_NAME"
gh repo create "$REPO_NAME" --public --source=. --push --description "Task Manager web app deployed to GitHub Pages"

# Enable GitHub Pages
echo "Enabling GitHub Pages..."
gh api "repos/$GH_USER/$REPO_NAME" --method PATCH -F page_build_version=3 -F source=branch -F branch=main 2>/dev/null || \
gh api "repos/$GH_USER/$REPO_NAME/pages" --method PUT -F source=branch=main 2>/dev/null || true

# Wait a moment for settings to propagate
sleep 2

echo ""
echo "=== Setup Complete! ==="
echo ""
echo "Your app will be available at:"
echo "  https://${GH_USER}.github.io/${REPO_NAME}/"
echo ""
echo "It may take 1-2 minutes for GitHub Pages to deploy."
echo ""
echo "To make changes and deploy:"
echo "  1. Edit the files"
echo "  2. git add ."
echo "  3. git commit -m 'Your message'"
echo "  4. git push origin main"
echo ""