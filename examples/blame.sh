#!/bin/bash
# Git Blame Practice Script
# This script helps you practice git blame

echo "=== Git Blame Practice ==="
echo ""

# Create a practice directory
PRACTICE_DIR="git-blame-practice"
rm -rf $PRACTICE_DIR
mkdir -p $PRACTICE_DIR
cd $PRACTICE_DIR

# Initialize a new repository
git init
echo "Created a new Git repository"
echo ""

# Create initial commit
cat > README.md << 'EOF'
# Project README

This project was started by Alice.

## Features
- Feature 1
- Feature 2
EOF
git add .
git commit -m "feat: initial commit by Alice"
echo "Alice made initial commit"
echo ""

# Make changes as different "authors"
echo "=== Making Changes as Different Authors ==="

# Simulate Bob's changes
GIT_AUTHOR_NAME="Bob" GIT_AUTHOR_EMAIL="bob@example.com" \
GIT_COMMITTER_NAME="Bob" GIT_COMMITTER_EMAIL="bob@example.com" \
git commit --amend --no-edit --date="$(date)"

cat >> README.md << 'EOF'

## Installation
Run npm install
EOF
git add README.md
GIT_AUTHOR_NAME="Bob" GIT_AUTHOR_EMAIL="bob@example.com" \
GIT_COMMITTER_NAME="Bob" GIT_COMMITTER_EMAIL="bob@example.com" \
git commit -m "docs: add installation instructions by Bob"
echo "Bob added installation instructions"
echo ""

# Simulate Charlie's changes
cat >> README.md << 'EOF'

## Usage
Run npm start
EOF
git add README.md
GIT_AUTHOR_NAME="Charlie" GIT_AUTHOR_EMAIL="charlie@example.com" \
GIT_COMMITTER_NAME="Charlie" GIT_COMMITTER_EMAIL="charlie@example.com" \
git commit -m "docs: add usage instructions by Charlie"
echo "Charlie added usage instructions"
echo ""

# Show commit history
echo "=== Commit History ==="
git log --oneline
echo ""

# Practice 1: Basic blame
echo "=== Practice 1: Basic Git Blame ==="
git blame README.md
echo ""

# Practice 2: Blame with line numbers
echo "=== Practice 2: Blame with Line Numbers ==="
git blame -n README.md
echo ""

# Practice 3: Blame with author email
echo "=== Practice 3: Blame with Author Email ==="
git blame -e README.md
echo ""

# Practice 4: Blame a specific line range
echo "=== Practice 4: Blame Line Range (lines 1-5) ==="
git blame -L 1,5 README.md
echo ""

# Practice 5: Show commit details
echo "=== Practice 5: Blame with Commit Details ==="
git blame -c README.md
echo ""

# Practice 6: Find who changed a specific line
echo "=== Practice 6: Find Who Changed 'Installation' ==="
git blame -L /Installation/,+3 README.md
echo ""

# Practice 7: Blame with summary
echo "=== Practice 7: Blame Summary ==="
git blame --summary README.md
echo ""

# Practice 8: Blame previous version
echo "=== Practice 8: Blame Previous Version ==="
echo "To see who last changed a line before a specific commit:"
git log --oneline README.md
echo ""
LAST_COMMIT=$(git log --oneline README.md | head -n 2 | tail -n 1 | cut -d' ' -f1)
echo "Blaming from commit $LAST_COMMIT:"
git blame $LAST_COMMIT -- README.md
echo ""

# Common blame commands
echo "=== Common Blame Commands ==="
echo ""
echo "Basic blame:"
echo "  git blame <file>"
echo ""
echo "With line numbers:"
echo "  git blame -n <file>"
echo ""
echo "With emails:"
echo "  git blame -e <file>"
echo ""
echo "Line range:"
echo "  git blame -L 1,10 <file>"
echo ""
echo "Pattern search:"
echo "  git blame -L /pattern/,+5 <file>"
echo ""
echo "Previous version:"
echo "  git blame <commit> -- <file>"
echo ""
echo "Porcelain format (for parsing):"
echo "  git blame --porcelain <file>"
echo ""

# Show final state
echo "=== Final State ==="
git log --oneline
echo ""

# Clean up
echo "=== Cleaning Up ==="
cd ..
rm -rf $PRACTICE_DIR
echo "Practice directory cleaned up."
echo ""

echo "=== Blame Practice Complete ==="
echo "You've learned:"
echo "  - How to use git blame"
echo "  - How to find who changed specific lines"
echo "  - How to blame specific line ranges"
echo "  - How to blame previous versions"
