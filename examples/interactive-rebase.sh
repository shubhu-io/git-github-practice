#!/bin/bash
# Git Interactive Rebase Practice Script
# This script helps you practice interactive rebase commands

echo "=== Git Interactive Rebase Practice ==="
echo ""

# Create a practice directory
PRACTICE_DIR="git-interactive-rebase-practice"
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

# Create a feature branch with multiple commits
git checkout -b feature/my-feature
echo "Created feature/my-feature branch"
echo ""

# Make multiple commits
echo "commit 1" > file1.txt
git add file1.txt
git commit -m "feat: add file1"

echo "commit 2" > file2.txt
git add file2.txt
git commit -m "feat: add file2"

echo "commit 3" > file3.txt
git add file3.txt
git commit -m "feat: add file3"

echo "commit 4 - typo" > file4.txt
git add file4.txt
git commit -m "fxi: fix typo"

echo "commit 5" > file5.txt
git add file5.txt
git commit -m "feat: add file5"
echo "Made 5 commits"
echo ""

# Show commit history
echo "=== Commit History Before Rebase ==="
git log --oneline
echo ""

# Practice 1: Squash Commits (non-interactive for automation)
echo "=== Practice 1: Squash Commits ==="
echo "Squashing last 3 commits into one..."
git reset --soft HEAD~3
git commit -m "feat: add files 3, 4, and 5"
echo ""

echo "=== After Squash ==="
git log --oneline
echo ""

# Practice 2: Edit Commit Message
echo "=== Practice 2: Edit Commit Message ==="
echo "Amending last commit message..."
git commit --amend -m "feat: add files 3, 4, and 5 (improved)"
echo ""

echo "=== After Amend ==="
git log --oneline
echo ""

# Practice 3: Drop a Commit
echo "=== Practice 3: Drop a Commit ==="
echo "To drop a commit during interactive rebase:"
echo "  git rebase -i HEAD~3"
echo "  Change 'pick' to 'drop' for the commit to remove"
echo ""

# Simulate dropping by resetting
echo "Simulating commit drop..."
git reset --hard HEAD~1
echo ""

echo "=== After Drop ==="
git log --oneline
echo ""

# Practice 4: Reorder Commits
echo "=== Practice 4: Reorder Commits ==="
echo "To reorder commits during interactive rebase:"
echo "  git rebase -i HEAD~3"
echo "  Move the lines up or down in the editor"
echo ""

# Practice 5: Fixup Commits
echo "=== Practice 5: Fixup Commits ==="
echo "To fixup a commit (combine without keeping message):"
echo "  git rebase -i HEAD~3"
echo "  Change 'pick' to 'fixup' for commits to combine"
echo ""

# Show final history
echo "=== Final History ==="
git log --oneline --graph
echo ""

# Clean up
echo "=== Cleaning Up ==="
cd ..
rm -rf $PRACTICE_DIR
echo "Practice directory cleaned up."
echo ""

echo "=== Interactive Rebase Practice Complete ==="
echo "You've practiced:"
echo "  - Squashing commits"
echo "  - Editing commit messages"
echo "  - Dropping commits"
echo "  - Reordering commits"
echo "  - Fixup commits"
echo ""
echo "For interactive rebase, use: git rebase -i HEAD~N"
echo "Where N is the number of commits to edit"
