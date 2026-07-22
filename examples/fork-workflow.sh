#!/bin/bash
# Git Fork Workflow Practice Script
# This script simulates the fork and pull request workflow

echo "=== Git Fork Workflow Practice ==="
echo ""

# Create a practice directory
PRACTICE_DIR="git-fork-workflow-practice"
rm -rf $PRACTICE_DIR
mkdir -p $PRACTICE_DIR
cd $PRACTICE_DIR

# Simulate original repository
echo "=== Setting Up Original Repository ==="
mkdir original-repo
cd original-repo
git init
echo "# Original Project" > README.md
echo "Welcome to the original project!" >> README.md
git add .
git commit -m "feat: initial commit"
echo "Created original repository"
echo ""

# Simulate fork (clone the original)
echo "=== Simulating Fork ==="
cd ..
git clone original-repo my-fork
cd my-fork
echo "Forked repository (cloned original)"
echo ""

# Add upstream remote
echo "=== Adding Upstream Remote ==="
git remote add upstream ../original-repo
git remote -v
echo ""

# Make changes on fork
echo "=== Making Changes on Fork ==="
echo "fork contribution" > fork-feature.txt
git add fork-feature.txt
git commit -m "feat: add fork feature"
echo "Made changes on fork"
echo ""

# Push to fork (simulated)
echo "=== Pushing to Fork ==="
git push origin main
echo "Pushed to fork"
echo ""

# Simulate creating PR
echo "=== Simulating Pull Request ==="
echo "To create a PR on GitHub:"
echo "  1. Go to your fork on GitHub"
echo "  2. Click 'New pull request'"
echo "  3. Select base: original-repo/main"
echo "  4. Select compare: your-fork/main"
echo "  5. Add title and description"
echo "  6. Click 'Create pull request'"
echo ""

# Simulate upstream changes
echo "=== Simulating Upstream Changes ==="
cd ../original-repo
echo "upstream change" > upstream-feature.txt
git add upstream-feature.txt
git commit -m "feat: add upstream feature"
echo "Made changes to original repository"
echo ""

# Sync fork with upstream
echo "=== Syncing Fork with Upstream ==="
cd ../my-fork
git fetch upstream
git checkout main
git merge upstream/main
echo "Merged upstream changes into fork"
echo ""

# Show final state
echo "=== Final State ==="
echo "Files in fork:"
ls -la
echo ""

echo "Git log:"
git log --oneline --graph --all
echo ""

# Clean up
echo "=== Cleaning Up ==="
cd ..
rm -rf $PRACTICE_DIR
echo "Practice directory cleaned up."
echo ""

echo "=== Fork Workflow Practice Complete ==="
echo "You've learned:"
echo "  - How to fork a repository"
echo "  - How to add upstream remote"
echo "  - How to make changes on your fork"
echo "  - How to sync with upstream"
echo "  - The pull request workflow"
