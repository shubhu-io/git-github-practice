#!/bin/bash
# Git Cherry-Pick Practice Script
# This script helps you practice Git cherry-pick commands

echo "=== Git Cherry-Pick Practice ==="
echo ""

# Create a practice directory
PRACTICE_DIR="git-cherry-pick-practice"
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
git checkout -b feature/feature-a
echo "Created feature/feature-a branch"
echo ""

echo "feature A - step 1" > feature-a.md
git add feature-a.md
git commit -m "feat(a): add feature A step 1"

echo "feature A - step 2" >> feature-a.md
git add feature-a.md
git commit -m "feat(a): add feature A step 2"

echo "feature A - step 3" >> feature-a.md
git add feature-a.md
git commit -m "feat(a): add feature A step 3"
echo "Made 3 commits on feature/feature-a"
echo ""

# Switch to main and create another branch
git checkout main
echo "Switched to main"
echo ""

git checkout -b feature/feature-b
echo "Created feature/feature-b branch"
echo ""

echo "feature B - important fix" > feature-b.md
git add feature-b.md
git commit -m "fix(b): important bug fix"

echo "feature B - enhancement" >> feature-b.md
git add feature-b.md
git commit -m "feat(b): add enhancement"
echo "Made 2 commits on feature/feature-b"
echo ""

# Show commit history
echo "=== Commit History ==="
git log --oneline --graph --all
echo ""

# Cherry-pick a specific commit from feature-a
echo "=== Cherry-Picking a Specific Commit ==="
FEATURE_A_HASH=$(git log feature/feature-a --oneline | head -n 2 | tail -n 1 | cut -d' ' -f1)
echo "Cherry-picking commit $FEATURE_A_HASH from feature/feature-a..."
git cherry-pick $FEATURE_A_HASH
echo ""

# Show result
echo "=== After Cherry-Pick ==="
git log --oneline --graph --all
echo ""

# Cherry-pick range of commits
echo "=== Cherry-Picking a Range of Commits ==="
FIRST_HASH=$(git log feature/feature-a --oneline | tail -n 1 | cut -d' ' -f1)
LAST_HASH=$(git log feature/feature-a --oneline | head -n 1 | cut -d' ' -f1)
echo "Cherry-picking range from $FIRST_HASH to $LAST_HASH..."
git cherry-pick $FIRST_HASH^..$LAST_HASH
echo ""

# Show final history
echo "=== Final History ==="
git log --oneline --graph --all
echo ""

# Show files on each branch
echo "=== Files on Each Branch ==="
echo "On main:"
git ls-files
echo ""

echo "On feature/feature-a:"
git ls-tree --name-only feature/feature-a
echo ""

echo "On feature/feature-b:"
git ls-tree --name-only feature/feature-b
echo ""

# Clean up
echo "=== Cleaning Up ==="
cd ..
rm -rf $PRACTICE_DIR
echo "Practice directory cleaned up."
echo ""

echo "=== Cherry-Pick Practice Complete ==="
echo "You've practiced:"
echo "  - Cherry-picking a specific commit"
echo "  - Cherry-picking a range of commits"
echo "  - Understanding commit hashes"
echo "  - Working with multiple branches"
