#!/bin/bash
# Git Tagging Practice Script
# This script helps you practice Git tagging commands

echo "=== Git Tagging Practice ==="
echo ""

# Create a practice directory
PRACTICE_DIR="git-tagging-practice"
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

# Practice 1: Lightweight Tags
echo "=== Practice 1: Lightweight Tags ==="
git tag v0.1.0
echo "Created lightweight tag v0.1.0"
echo ""

# List tags
echo "=== Listing Tags ==="
git tag
echo ""

# Show tag details
echo "=== Tag Details ==="
git show v0.1.0
echo ""

# Practice 2: Annotated Tags
echo "=== Practice 2: Annotated Tags ==="
echo "# Version 0.2.0" >> README.md
echo "Added new features" >> README.md
git add .
git commit -m "feat: add new features for v0.2.0"
echo ""

git tag -a v0.2.0 -m "Release version 0.2.0 with new features"
echo "Created annotated tag v0.2.0"
echo ""

# Show annotated tag details
echo "=== Annotated Tag Details ==="
git show v0.2.0
echo ""

# Practice 3: Semantic Versioning
echo "=== Practice 3: Semantic Versioning ==="
echo "Following semantic versioning (MAJOR.MINOR.PATCH):"
echo "  - MAJOR: Incompatible API changes"
echo "  - MINOR: New functionality (backwards compatible)"
echo "  - PATCH: Bug fixes (backwards compatible)"
echo ""

# Simulate version releases
echo "# Version 1.0.0" > VERSION.md
echo "First stable release" >> VERSION.md
git add .
git commit -m "feat: prepare for v1.0.0 release"
git tag -a v1.0.0 -m "First stable release"
echo "Created v1.0.0"
echo ""

echo "# Version 1.0.1" >> VERSION.md
echo "Bug fixes" >> VERSION.md
git add .
git commit -m "fix: critical bug fix"
git tag -a v1.0.1 -m "Bug fix release"
echo "Created v1.0.1"
echo ""

echo "# Version 1.1.0" >> VERSION.md
echo "New feature added" >> VERSION.md
git add .
git commit -m "feat: add new feature"
git tag -a v1.1.0 -m "New feature release"
echo "Created v1.1.0"
echo ""

# List all tags
echo "=== All Tags ==="
git tag -l
echo ""

# Sort tags
echo "=== Sorted Tags ==="
git tag -l --sort=-version:refname
echo ""

# Practice 4: Pushing Tags
echo "=== Practice 4: Pushing Tags ==="
echo "To push tags to remote:"
echo "  git push origin v1.0.0      # Push specific tag"
echo "  git push origin --tags      # Push all tags"
echo "  git push origin --delete v0.1.0  # Delete remote tag"
echo ""

# Practice 5: Deleting Tags
echo "=== Practice 5: Deleting Tags ==="
echo "To delete tags:"
echo "  git tag -d v0.1.0           # Delete local tag"
echo "  git push origin --delete v0.1.0  # Delete remote tag"
echo ""

# Delete a local tag
git tag -d v0.1.0
echo "Deleted local tag v0.1.0"
echo ""

# Show remaining tags
echo "=== Remaining Tags ==="
git tag -l
echo ""

# Practice 6: Checkout Tag
echo "=== Practice 6: Checkout Tag ==="
echo "To checkout a specific tag:"
echo "  git checkout v1.0.0        # Detach HEAD at tag"
echo "  git checkout -b hotfix v1.0.0  # Create branch from tag"
echo ""

# Create a hotfix branch from tag
git checkout -b hotfix/fix-critical v1.0.0
echo "Created hotfix/fix-critical branch from v1.0.0"
echo ""

# Make a fix
echo "# Hotfix" > HOTFIX.md
echo "Critical fix applied" >> HOTFIX.md
git add .
git commit -m "hotfix: critical security fix"
echo "Made hotfix commit"
echo ""

# Tag the hotfix
git tag -a v1.0.2 -m "Critical hotfix"
echo "Tagged hotfix as v1.0.2"
echo ""

# Show final state
echo "=== Final Git Log ==="
git log --oneline --graph --all
echo ""

echo "=== Final Tags ==="
git tag -l --sort=-version:refname
echo ""

# Clean up
echo "=== Cleaning Up ==="
cd ..
rm -rf $PRACTICE_DIR
echo "Practice directory cleaned up."
echo ""

echo "=== Tagging Practice Complete ==="
echo "You've practiced:"
echo "  - Creating lightweight tags"
echo "  - Creating annotated tags"
echo "  - Semantic versioning"
echo "  - Listing and sorting tags"
echo "  - Pushing and deleting tags"
echo "  - Checking out tags"
echo "  - Creating branches from tags"
