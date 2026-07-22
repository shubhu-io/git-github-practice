#!/bin/bash
# Git Stash Practice Script
# This script helps you practice Git stashing commands

echo "=== Git Stash Practice ==="
echo ""

# Create a practice directory
PRACTICE_DIR="git-stash-practice"
rm -rf $PRACTICE_DIR
mkdir -p $PRACTICE_DIR
cd $PRACTICE_DIR

# Initialize a new repository
git init
echo "Created a new Git repository"
echo ""

# Create initial commit
echo "# My Project" > README.md
echo "feature-a=enabled" > config.txt
git add .
git commit -m "feat: initial commit"
echo "Created initial commit"
echo ""

# Simulate being in the middle of work
echo "=== Starting Work on Feature A ==="
echo "feature-b=enabled" >> config.txt
echo "Modified config.txt (but not staged)"
echo ""

# Stash the changes
echo "=== Stashing Changes ==="
git stash save "WIP: working on feature-b"
echo "Changes stashed"
echo ""

# Show clean working directory
echo "=== Working Directory After Stash ==="
git status
echo ""

# Work on something else (hotfix)
echo "=== Working on Hotfix ==="
git checkout -b hotfix/urgent-fix
echo "# Hotfix" > HOTFIX.md
echo "This is an urgent fix." >> HOTFIX.md
git add .
git commit -m "hotfix: urgent fix"
echo "Created hotfix"
echo ""

# Merge hotfix and go back to main
git checkout main
git merge hotfix/urgent-fix
git branch -d hotfix/urgent-fix
echo "Merged hotfix and cleaned up branch"
echo ""

# Return to original work
echo "=== Returning to Original Work ==="
echo "Now on branch: $(git branch --show-current)"
echo ""

# Apply the stash
echo "=== Applying Stash ==="
git stash list
echo ""
git stash pop
echo ""

# Show the result
echo "=== File After Applying Stash ==="
cat config.txt
echo ""

# Practice: Multiple stashes
echo "=== Creating Multiple Stashes ==="
echo "work-in-progress-1" > WIP1.txt
git add WIP1.txt
git stash save "WIP: first task"
echo "Stashed first task"
echo ""

echo "work-in-progress-2" > WIP2.txt
git add WIP2.txt
git stash save "WIP: second task"
echo "Stashed second task"
echo ""

echo "work-in-progress-3" > WIP3.txt
git add WIP3.txt
git stash save "WIP: third task"
echo "Stashed third task"
echo ""

# List all stashes
echo "=== All Stashes ==="
git stash list
echo ""

# Apply specific stash
echo "=== Applying Stash@{1} (second task) ==="
git stash apply stash@{1}
echo "Applied second task stash"
echo ""

# Drop the stash
echo "=== Dropping Stash@{1} ==="
git stash drop stash@{1}
git stash list
echo ""

# Clear all remaining stashes
echo "=== Clearing All Stashes ==="
git stash clear
git stash list
echo "(should be empty)"
echo ""

# Clean up
echo "=== Cleaning Up ==="
cd ..
rm -rf $PRACTICE_DIR
echo "Practice directory cleaned up."
echo ""

echo "=== Stash Practice Complete ==="
echo "You've practiced:"
echo "  - Stashing changes"
echo "  - Listing stashes"
echo "  - Applying stashes"
echo "  - Popping stashes"
echo "  - Dropping stashes"
echo "  - Clearing all stashes"
echo "  - Working with multiple stashes"
