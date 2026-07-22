#!/bin/bash
# Git Branching Practice Script
# This script helps you practice Git branching commands

echo "=== Git Branching Practice ==="
echo ""

# Create a practice directory
PRACTICE_DIR="git-branching-practice"
rm -rf $PRACTICE_DIR
mkdir -p $PRACTICE_DIR
cd $PRACTICE_DIR

# Initialize a new repository
git init
echo "Created a new Git repository"
echo ""

# Create initial commit
echo "# My Project" > README.md
echo "This is a practice repository for learning Git branching." >> README.md
git add .
git commit -m "feat: initial commit with README"
echo "Created initial commit"
echo ""

# List branches
echo "=== Current Branches ==="
git branch
echo ""

# Create a new branch
echo "=== Creating feature/login Branch ==="
git branch feature/login
git branch
echo ""

# Switch to the new branch
echo "=== Switching to feature/login ==="
git checkout feature/login
echo "Now on branch: $(git branch --show-current)"
echo ""

# Make changes on the feature branch
echo "# Login Feature" > LOGIN.md
echo "This branch adds login functionality." >> LOGIN.md
git add .
git commit -m "feat: add login feature documentation"
echo "Made changes on feature/login branch"
echo ""

# Switch back to main
echo "=== Switching back to main ==="
git checkout main
echo "Now on branch: $(git branch --show-current)"
echo ""

# Merge the feature branch
echo "=== Merging feature/login into main ==="
git merge feature/login
echo "Merge completed"
echo ""

# Delete the feature branch
echo "=== Cleaning up: deleting feature/login ==="
git branch -d feature/login
git branch
echo ""

# Practice: Create multiple branches
echo "=== Creating Multiple Branches ==="
git branch feature/signup
git branch bugfix/header
git branch docs/update-readme
git branch
echo ""

# Switch between branches
echo "=== Switching Between Branches ==="
git checkout feature/signup
echo "Now on: $(git branch --show-current)"
git checkout bugfix/header
echo "Now on: $(git branch --show-current)"
git checkout main
echo "Now on: $(git branch --show-current)"
echo ""

# Clean up
echo "=== Cleaning Up ==="
git branch -D feature/signup
git branch -D bugfix/header
git branch -D docs/update-readme
git branch
echo ""

echo "=== Branching Practice Complete ==="
echo "You've practiced:"
echo "  - Creating branches"
echo "  - Switching between branches"
echo "  - Merging branches"
echo "  - Deleting branches"
echo ""

# Clean up practice directory
cd ..
rm -rf $PRACTICE_DIR
echo "Practice directory cleaned up."
