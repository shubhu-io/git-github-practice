#!/bin/bash
# Git Squash Merge Practice Script
# This script helps you practice squash merging

echo "=== Git Squash Merge Practice ==="
echo ""

# Create a practice directory
PRACTICE_DIR="git-squash-merge-practice"
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

# Create feature branch with multiple commits
git checkout -b feature/my-feature
echo "Created feature/my-feature branch"
echo ""

# Make multiple small commits
echo "step 1" > feature.txt
git add feature.txt
git commit -m "feat: start feature"

echo "step 2" >> feature.txt
git add feature.txt
git commit -m "feat: continue feature"

echo "step 3" >> feature.txt
git add feature.txt
git commit -m "feat: finish feature"

echo "step 4 - fix typo" >> feature.txt
git add feature.txt
git commit -m "fix: correct typo"

echo "step 5 - final touches" >> feature.txt
git add feature.txt
git commit -m "chore: final touches"
echo "Made 5 commits on feature branch"
echo ""

# Show commit history
echo "=== Feature Branch History ==="
git log --oneline
echo ""

# Switch to main for squash merge
git checkout main
echo "Switched to main"
echo ""

# Perform squash merge
echo "=== Performing Squash Merge ==="
git merge --squash feature/my-feature
echo ""

# Show status after squash
echo "=== Status After Squash ==="
git status
echo ""

# Commit the squashed changes
git commit -m "feat: add complete feature

Squashed commit of the following:

- Start feature
- Continue feature
- Finish feature
- Fix typo
- Final touches"
echo "Committed squashed changes"
echo ""

# Show result
echo "=== Main Branch History After Squash ==="
git log --oneline
echo ""

# Compare with regular merge
echo "=== Comparing Merge Types ==="
echo ""
echo "Squash Merge (what we did):"
echo "  - Combines all commits into one"
echo "  - Cleaner history"
echo "  - Loses individual commit history"
echo ""
echo "Regular Merge:"
echo "  - Preserves all commits"
echo "  - Creates merge commit"
echo "  - Full history preserved"
echo ""
echo "Rebase and Merge:"
echo "  - Replays commits on top"
echo "  - Linear history"
echo "  - Preserves individual commits"
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

echo "=== Squash Merge Practice Complete ==="
echo "You've practiced:"
echo "  - Squash merging a feature branch"
echo "  - Understanding the difference between merge types"
echo "  - Writing a good squashed commit message"
echo ""
echo "When to use squash merge:"
echo "  - When you have many small commits that represent one feature"
echo "  - When you want a clean, linear history"
echo "  - When the individual commits aren't meaningful on their own"
