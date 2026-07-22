#!/bin/bash
# Git Submodule Practice Script
# This script helps you practice Git submodules

echo "=== Git Submodule Practice ==="
echo ""

# Create a practice directory
PRACTICE_DIR="git-submodule-practice"
rm -rf $PRACTICE_DIR
mkdir -p $PRACTICE_DIR
cd $PRACTICE_DIR

# Create the "external" library repository
echo "=== Creating External Library Repository ==="
mkdir external-lib
cd external-lib
git init
echo "# External Library" > README.md
echo "function helper() { return 'I am a helper'; }" > lib.js
git add .
git commit -m "feat: initial library release"
echo "Created external library repository"
cd ..
echo ""

# Create the main project
echo "=== Creating Main Project ==="
mkdir main-project
cd main-project
git init
echo "# Main Project" > README.md
git add .
git commit -m "feat: initial commit"
echo "Created main project"
echo ""

# Add external library as submodule
echo "=== Adding Submodule ==="
git submodule add ../external-lib libs/external-lib
echo ""

# Show submodule status
echo "=== Submodule Status ==="
git submodule status
echo ""

# Show directory structure
echo "=== Directory Structure ==="
ls -la
ls -la libs/
echo ""

# Make changes in main project
echo "=== Making Changes in Main Project ==="
echo "const lib = require('./libs/external-lib/lib');" > app.js
echo "console.log(lib.helper());" >> app.js
git add .
git commit -m "feat: add app using external library"
echo ""

# Make changes in submodule
echo "=== Making Changes in Submodule ==="
cd libs/external-lib
echo "function newHelper() { return 'I am new'; }" >> lib.js
git add .
git commit -m "feat: add new helper function"
cd ../..
echo ""

# Update submodule reference
echo "=== Updating Submodule Reference ==="
cd libs/external-lib
git pull origin main
cd ../..
git add libs/external-lib
git commit -m "chore: update external-lib submodule"
echo ""

# Show final state
echo "=== Final State ==="
git log --oneline
echo ""

echo "Submodule status:"
git submodule status
echo ""

# Common submodule commands
echo "=== Common Submodule Commands ==="
echo ""
echo "Add a submodule:"
echo "  git submodule add <url> <path>"
echo ""
echo "Clone with submodules:"
echo "  git clone --recursive <url>"
echo "  OR"
echo "  git submodule init"
echo "  git submodule update"
echo ""
echo "Update submodules:"
echo "  git submodule update --remote"
echo ""
echo "Remove a submodule:"
echo "  git submodule deinit <path>"
echo "  git rm <path>"
echo "  rm -rf .git/modules/<path>"
echo ""

# Clean up
echo "=== Cleaning Up ==="
cd ..
rm -rf $PRACTICE_DIR
echo "Practice directory cleaned up."
echo ""

echo "=== Submodule Practice Complete ==="
echo "You've learned:"
echo "  - How to add a submodule"
echo "  - How to make changes in a submodule"
echo "  - How to update submodule references"
echo "  - Common submodule commands"
