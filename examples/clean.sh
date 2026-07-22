#!/bin/bash
# Git Clean Practice Script
# This script helps you practice git clean commands

echo "=== Git Clean Practice ==="
echo ""

# Create a practice directory
PRACTICE_DIR="git-clean-practice"
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

# Create various files (tracked and untracked)
echo "=== Creating Files ==="
echo "tracked file" > tracked.txt
git add tracked.txt
git commit -m "feat: add tracked file"
echo "Created tracked file"
echo ""

echo "untracked file" > untracked.txt
echo "another untracked" > another.txt
mkdir -p temp_dir
echo "temp file" > temp_dir/temp.txt
echo "Created untracked files"
echo ""

# Show status
echo "=== File Status ==="
git status
echo ""

# Practice 1: Dry run (see what would be deleted)
echo "=== Practice 1: Dry Run (git clean -n) ==="
git clean -n
echo ""

# Practice 2: Clean untracked files
echo "=== Practice 2: Clean Untracked Files (git clean -f) ==="
git clean -f
echo ""

# Verify
echo "=== After Clean ==="
ls -la
echo ""

# Create more files for practice
echo "=== Creating More Files ==="
echo "file1" > file1.txt
echo "file2" > file2.txt
mkdir -p dir1
echo "file in dir" > dir1/file.txt
git status
echo ""

# Practice 3: Clean directories too
echo "=== Practice 3: Clean Directories (git clean -fd) ==="
git clean -fd
echo ""

# Verify
echo "=== After Clean ==="
ls -la
echo ""

# Create ignored files
echo "=== Creating Ignored Files ==="
echo "*.log" > .gitignore
git add .
git commit -m "chore: add gitignore"
echo ""

echo "log entry" > debug.log
echo "another log" > error.log
mkdir -p node_modules
echo "package" > node_modules/package.js
git status
echo ""

# Practice 4: Clean ignored files
echo "=== Practice 4: Dry Run for Ignored Files (git clean -Xn) ==="
git clean -Xn
echo ""

# Practice 5: Clean ignored files
echo "=== Practice 5: Clean Ignored Files (git clean -Xf) ==="
git clean -Xf
echo ""

# Verify
echo "=== After Clean ==="
ls -la
echo ""

# Common clean commands
echo "=== Common Git Clean Commands ==="
echo ""
echo "Dry run (see what would be deleted):"
echo "  git clean -n              # Untracked files"
echo "  git clean -Xn             # Ignored files"
echo "  git clean -xn             # Both"
echo ""
echo "Force delete:"
echo "  git clean -f              # Untracked files"
echo "  git clean -Xf             # Ignored files"
echo "  git clean -xf             # Both"
echo ""
echo "Delete directories too:"
echo "  git clean -fd             # Untracked dirs"
echo "  git clean -Xfd            # Ignored dirs"
echo "  git clean -xfd            # Both"
echo ""
echo "Interactive clean:"
echo "  git clean -fi             # Interactive mode"
echo ""

# Show final state
echo "=== Final State ==="
git log --oneline
ls -la
echo ""

# Clean up
echo "=== Cleaning Up ==="
cd ..
rm -rf $PRACTICE_DIR
echo "Practice directory cleaned up."
echo ""

echo "=== Clean Practice Complete ==="
echo "You've learned:"
echo "  - How to preview what git clean will delete"
echo "  - How to delete untracked files"
echo "  - How to delete ignored files"
echo "  - How to delete directories"
echo "  - The difference between -f, -X, and -x flags"
echo ""
echo "WARNING: git clean deletes files permanently!"
echo "Always use -n (dry run) first to see what will be deleted."
