#!/bin/bash
# Git Reflog Rescue Practice Script
# This script helps you practice using git reflog to recover lost commits

echo "=== Git Reflog Rescue Practice ==="
echo ""

# Create a practice directory
PRACTICE_DIR="git-reflog-practice"
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

# Create more commits
echo "commit 1" > file1.txt
git add file1.txt
git commit -m "feat: add file1"

echo "commit 2" > file2.txt
git add file2.txt
git commit -m "feat: add file2"

echo "commit 3" > file3.txt
git add file3.txt
git commit -m "feat: add file3"
echo "Created 3 commits"
echo ""

# Show current history
echo "=== Current History ==="
git log --oneline
echo ""

# Simulate accidental reset
echo "=== Simulating Accidental Reset ==="
echo "Oh no! Accidentally ran git reset --hard HEAD~2"
git reset --hard HEAD~2
echo ""

# Show current state
echo "=== Current State After Reset ==="
git log --oneline
echo ""
echo "Files in directory:"
ls -la
echo ""

# Use reflog to find lost commits
echo "=== Using Reflog to Find Lost Commits ==="
git reflog
echo ""

# Find the lost commit hash
LOST_COMMIT=$(git reflog | head -n 4 | tail -n 1 | cut -d' ' -f1)
echo "Found lost commit: $LOST_COMMIT"
echo ""

# Recover the commit
echo "=== Recovering Lost Commit ==="
git cherry-pick $LOST_COMMIT
echo ""

# Show recovered state
echo "=== Recovered State ==="
git log --oneline
echo ""

# Practice 2: Recover after deleting a branch
echo "=== Practice 2: Recover Deleted Branch ==="
git checkout -b feature/to-delete
echo "feature work" > feature.txt
git add feature.txt
git commit -m "feat: add feature"
echo "Created feature branch with commit"
echo ""

# Delete the branch
git checkout main
git branch -D feature/to-delete
echo "Deleted feature branch"
echo ""

# Use reflog to recover
echo "=== Recovering Deleted Branch ==="
git reflog
echo ""

# Find the commit from the deleted branch
DELETED_COMMIT=$(git reflog | grep "checkout:" | head -n 1 | cut -d' ' -f1)
echo "Recovering commit: $DELETED_COMMIT"
git checkout -b feature/recovered $DELETED_COMMIT
echo ""

# Show recovered branch
echo "=== Recovered Branch ==="
git log --oneline
ls -la
echo ""

# Practice 3: View reflog for specific branch
echo "=== Practice 3: View Reflog for Specific Branch ==="
echo "Viewing reflog for main branch:"
git reflog show main
echo ""

# Show final state
echo "=== Final State ==="
git log --oneline --graph --all
echo ""

# Clean up
echo "=== Cleaning Up ==="
cd ..
rm -rf $PRACTICE_DIR
echo "Practice directory cleaned up."
echo ""

echo "=== Reflog Rescue Practice Complete ==="
echo "You've learned:"
echo "  - How to use git reflog"
echo "  - How to recover lost commits"
echo "  - How to recover deleted branches"
echo "  - The importance of reflog for disaster recovery"
echo ""
echo "Key commands:"
echo "  git reflog              # View all ref changes"
echo "  git reflog show branch  # View specific branch reflog"
echo "  git cherry-pick <hash>  # Recover a commit"
echo "  git checkout -b <branch> <hash>  # Recover a branch"
