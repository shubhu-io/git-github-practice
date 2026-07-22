#!/bin/bash
# Git Undo Operations Practice Script
# This script helps you practice various undo operations in Git

echo "=== Git Undo Operations Practice ==="
echo ""

# Create a practice directory
PRACTICE_DIR="git-undo-practice"
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

# Practice 1: Discard unstaged changes
echo "=== Practice 1: Discard Unstaged Changes ==="
echo "new line" >> README.md
git status
echo ""
echo "Discarding changes with git restore..."
git restore README.md
git status
echo ""

# Practice 2: Unstage a file
echo "=== Practice 2: Unstage a File ==="
echo "change 1" >> README.md
git add README.md
git status
echo ""
echo "Unstaging with git restore --staged..."
git restore --staged README.md
git status
echo ""

# Practice 3: Undo last commit (keep changes)
echo "=== Practice 3: Undo Last Commit (Keep Changes) ==="
echo "feature code" > feature.js
git add feature.js
git commit -m "feat: add feature"
echo "Made a commit"
echo ""
git log --oneline
echo ""
echo "Undoing commit with git reset HEAD~1..."
git reset HEAD~1
git log --oneline
echo ""
git status
echo ""

# Practice 4: Amend last commit message
echo "=== Practice 4: Amend Last Commit Message ==="
echo "more changes" >> feature.js
git add feature.js
git commit -m "feat: add feature"
echo "Created commit with wrong message"
echo ""
git log --oneline
echo ""
echo "Amending commit message..."
git commit --amend -m "feat: add new feature with more changes"
git log --oneline
echo ""

# Practice 5: Add forgotten file to last commit
echo "=== Practice 5: Add Forgotten File to Last Commit ==="
echo "forgotten file" > forgotten.txt
git status
echo ""
echo "Adding forgotten file to last commit..."
git add forgotten.txt
git commit --amend --no-edit
git log --oneline
echo ""

# Practice 6: Revert a commit (safe for shared repos)
echo "=== Practice 6: Revert a Commit (Safe Undo) ==="
echo "bad code" > buggy.js
git add buggy.js
git commit -m "feat: add buggy code"
echo "Created a commit with buggy code"
echo ""
git log --oneline
echo ""
echo "Reverting commit..."
git revert HEAD --no-edit
git log --oneline
echo ""

# Practice 7: View specific commit
echo "=== Practice 7: View Specific Commit ==="
echo "Checking second commit..."
git log --oneline
echo ""
COMMIT_HASH=$(git log --oneline --reverse | head -n 2 | tail -n 1 | cut -d' ' -f1)
echo "Showing commit $COMMIT_HASH..."
git show $COMMIT_HASH
echo ""

# Practice 8: View diff between commits
echo "=== Practice 8: View Diff Between Commits ==="
echo "Comparing first two commits..."
git log --oneline
echo ""
FIRST=$(git log --oneline --reverse | head -n 1 | cut -d' ' -f1)
SECOND=$(git log --oneline --reverse | head -n 2 | tail -n 1 | cut -d' ' -f1)
echo "Diff between $FIRST and $SECOND:"
git diff $FIRST $SECOND
echo ""

# Show final state
echo "=== Final Git Log ==="
git log --oneline --graph
echo ""

# Clean up
echo "=== Cleaning Up ==="
cd ..
rm -rf $PRACTICE_DIR
echo "Practice directory cleaned up."
echo ""

echo "=== Undo Operations Practice Complete ==="
echo "You've practiced:"
echo "  - Discarding unstaged changes (git restore)"
echo "  - Unstaging files (git restore --staged)"
echo "  - Undoing commits (git reset HEAD~1)"
echo "  - Amending commit messages (git commit --amend)"
echo "  - Adding forgotten files to commits"
echo "  - Reverting commits (git revert)"
echo "  - Viewing specific commits (git show)"
echo "  - Comparing commits (git diff)"
