#!/bin/bash
# Git Merge Conflict Practice Script
# This script helps you understand and resolve merge conflicts

echo "=== Git Merge Conflict Practice ==="
echo ""

# Create a practice directory
PRACTICE_DIR="git-merge-conflict-practice"
rm -rf $PRACTICE_DIR
mkdir -p $PRACTICE_DIR
cd $PRACTICE_DIR

# Initialize a new repository
git init
echo "Created a new Git repository"
echo ""

# Create initial file
echo "# Configuration" > config.txt
echo "color=blue" >> config.txt
echo "theme=dark" >> config.txt
git add .
git commit -m "feat: initial config file"
echo "Created initial config.txt with color=blue"
echo ""

# Create a feature branch
git checkout -b feature/change-color
echo "Created and switched to feature/change-color"
echo ""

# Make changes on feature branch
sed -i 's/color=blue/color=red/' config.txt
git add .
git commit -m "feat: change color to red"
echo "Changed color to red on feature branch"
echo ""

# Switch back to main and make conflicting changes
git checkout main
echo "Switched back to main"
echo ""

# Make different changes on main
sed -i 's/color=blue/color=green/' config.txt
git add .
git commit -m "feat: change color to green"
echo "Changed color to green on main branch"
echo ""

# Try to merge (will cause conflict)
echo "=== Attempting to Merge (expecting conflict) ==="
git merge feature/change-color || true
echo ""

# Show the conflict
echo "=== Conflict in config.txt ==="
cat config.txt
echo ""

# Explain the conflict markers
echo "=== Conflict Markers Explained ==="
echo "<<<<<<< HEAD"
echo "This is the version from the current branch (main)"
echo "======="
echo "This is the version from the branch being merged (feature/change-color)"
echo ">>>>>>> feature/change-color"
echo ""

# Resolve the conflict manually
echo "=== Resolving the Conflict ==="
echo "# Configuration" > config.txt
echo "color=purple" >> config.txt
echo "theme=dark" >> config.txt
echo "Resolved conflict: chose purple as compromise"
echo ""

# Stage the resolved file
git add config.txt
git commit -m "fix: resolve merge conflict, use purple as compromise"
echo "Committed the resolved conflict"
echo ""

# Show the result
echo "=== Final config.txt ==="
cat config.txt
echo ""

# Merge the feature branch (should work now)
echo "=== Merging feature/change-color (should succeed) ==="
git merge feature/change-color || true
echo ""

# Show git log
echo "=== Git Log ==="
git log --oneline --graph
echo ""

# Clean up
echo "=== Cleaning Up ==="
cd ..
rm -rf $PRACTICE_DIR
echo "Practice directory cleaned up."
echo ""

echo "=== Merge Conflict Practice Complete ==="
echo "You've learned:"
echo "  - How merge conflicts happen"
echo "  - How to identify conflict markers"
echo "  - How to resolve conflicts manually"
echo "  - How to commit resolved conflicts"
