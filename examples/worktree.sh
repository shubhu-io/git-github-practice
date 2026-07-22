#!/bin/bash
# Git Worktree Practice Script
# This script helps you practice Git worktrees

echo "=== Git Worktree Practice ==="
echo ""

# Create a practice directory
PRACTICE_DIR="git-worktree-practice"
rm -rf $PRACTICE_DIR
mkdir -p $PRACTICE_DIR
cd $PRACTICE_DIR

# Initialize a new repository
git init
echo "Created a new Git repository"
echo ""

# Create initial commit
echo "# My Project" > README.md
echo "main content" >> README.md
git add .
git commit -m "feat: initial commit"
echo "Created initial commit"
echo ""

# Create multiple commits
echo "commit 1 on main" >> README.md
git add README.md
git commit -m "feat: main change 1"

echo "commit 2 on main" >> README.md
git add README.md
git commit -m "feat: main change 2"
echo "Created commits on main"
echo ""

# Show current state
echo "=== Current State ==="
git log --oneline
echo ""

# Practice 1: Add a worktree
echo "=== Practice 1: Add Worktree for Feature Branch ==="
git branch feature/branch-a
git worktree add ../feature-a-work feature/branch-a
echo "Created worktree at ../feature-a-work"
echo ""

# Work in the worktree
echo "=== Working in Worktree ==="
cd ../feature-a-work
echo "# Feature A" > feature-a.md
echo "Work done in worktree" >> feature-a.md
git add feature-a.md
git commit -m "feat: add feature A in worktree"
echo "Made changes in worktree"
echo ""

# Show worktree status
echo "=== Worktree Status ==="
git worktree list
echo ""

# Go back to main worktree
cd ../git-worktree-practice

# Practice 2: Create another worktree
echo "=== Practice 2: Add Worktree for Hotfix ==="
git worktree add -b hotfix/urgent ../hotfix-work HEAD~1
echo "Created hotfix worktree from previous commit"
echo ""

# Work in hotfix worktree
cd ../hotfix-work
echo "# Hotfix" > HOTFIX.md
echo "Urgent fix" >> HOTFIX.md
git add HOTFIX.md
git commit -m "hotfix: urgent fix"
echo "Made hotfix changes"
echo ""

# Show all worktrees
echo "=== All Worktrees ==="
git worktree list
echo ""

# Go back to main
cd ../git-worktree-practice

# Common worktree commands
echo "=== Common Worktree Commands ==="
echo ""
echo "Create worktree:"
echo "  git worktree add <path> <branch>"
echo ""
echo "Create worktree for new branch:"
echo "  git worktree add -b <branch> <path>"
echo ""
echo "Create worktree from specific commit:"
echo "  git worktree add <path> <commit>"
echo ""
echo "List worktrees:"
echo "  git worktree list"
echo ""
echo "Remove worktree:"
echo "  git worktree remove <path>"
echo ""
echo "Prune stale worktrees:"
echo "  git worktree prune"
echo ""

# Clean up worktrees
echo "=== Cleaning Up Worktrees ==="
cd ../hotfix-work
git worktree remove .
cd ../git-worktree-practice
cd ../feature-a-work
git worktree remove .
cd ../git-worktree-practice

echo "Remaining worktrees:"
git worktree list
echo ""

# Clean up
echo "=== Cleaning Up ==="
cd ..
rm -rf $PRACTICE_DIR
echo "Practice directory cleaned up."
echo ""

echo "=== Worktree Practice Complete ==="
echo "You've learned:"
echo "  - How to create worktrees"
echo "  - How to work in multiple worktrees"
echo "  - How to remove worktrees"
echo "  - Use cases for worktrees"
echo ""
echo "Use cases:"
echo "  - Work on multiple branches simultaneously"
echo  "  - Hotfix without stashing"
echo "  - Test builds from different branches"
