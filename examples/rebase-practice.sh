#!/bin/bash
# Git Rebase Practice Script
# This script helps you practice Git rebase commands

echo "=== Git Rebase Practice ==="
echo ""

# Create a practice directory
PRACTICE_DIR="git-rebase-practice"
rm -rf $PRACTICE_DIR
mkdir -p $PRACTICE_DIR
cd $PRACTICE_DIR

# Initialize a new repository
git init
echo "Created a new Git repository"
echo ""

# Create initial commit
echo "# My Project" > README.md
git add .
git commit -m "feat: initial commit"
echo "Created initial commit"
echo ""

# Create feature branch
git checkout -b feature/my-feature
echo "Created feature/my-feature branch"
echo ""

# Make commits on feature branch
echo "feature line 1" >> README.md
git add .
git commit -m "feat: add first feature"

echo "feature line 2" >> README.md
git add .
git commit -m "feat: add second feature"

echo "feature line 3" >> README.md
git add .
git commit -m "feat: add third feature"
echo "Made 3 commits on feature branch"
echo ""

# Switch to main and make more commits
git checkout main
echo "Switched to main"
echo ""

echo "main change 1" >> README.md
git add .
git commit -m "feat: main change 1"

echo "main change 2" >> README.md
git add .
git commit -m "feat: main change 2"
echo "Made 2 commits on main"
echo ""

# Show commit history before rebase
echo "=== History Before Rebase ==="
git log --oneline --graph --all
echo ""

# Rebase feature branch onto main
echo "=== Rebasing feature/my-feature onto main ==="
git checkout feature/my-feature
git rebase main
echo ""

# Show commit history after rebase
echo "=== History After Rebase ==="
git log --oneline --graph --all
echo ""

# Now merge (should be fast-forward)
echo "=== Merging rebased branch ==="
git checkout main
git merge feature/my-feature
echo ""

# Show final history
echo "=== Final History ==="
git log --oneline --graph
echo ""

# Practice: Interactive Rebase
echo "=== Practice: Interactive Rebase (Squash Commits) ==="
git checkout -b feature/squash-demo
echo "Created feature/squash-demo branch"
echo ""

echo "commit 1" > file1.txt
git add file1.txt
git commit -m "feat: add file1"

echo "commit 2" > file2.txt
git add file2.txt
git commit -m "feat: add file2"

echo "commit 3" > file3.txt
git add file3.txt
git commit -m "feat: add file3"
echo "Made 3 commits to squash"
echo ""

echo "History before squash:"
git log --oneline
echo ""

# Squash last 3 commits (non-interactive for demo)
echo "Squashing last 3 commits..."
git reset --soft HEAD~3
git commit -m "feat: add files 1, 2, and 3"
echo ""

echo "History after squash:"
git log --oneline
echo ""

# Clean up
echo "=== Cleaning Up ==="
cd ..
rm -rf $PRACTICE_DIR
echo "Practice directory cleaned up."
echo ""

echo "=== Rebase Practice Complete ==="
echo "You've practiced:"
echo "  - Basic rebase (git rebase main)"
echo "  - Interactive rebase (squashing commits)"
echo "  - Fast-forward merge after rebase"
echo "  - Understanding rebase vs merge"
