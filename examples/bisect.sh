#!/bin/bash
# Git Bisect Practice Script
# This script helps you practice using git bisect to find bugs

echo "=== Git Bisect Practice ==="
echo ""

# Create a practice directory
PRACTICE_DIR="git-bisect-practice"
rm -rf $PRACTICE_DIR
mkdir -p $PRACTICE_DIR
cd $PRACTICE_DIR

# Initialize a new repository
git init
echo "Created a new Git repository"
echo ""

# Create initial commit
echo "# Calculator App" > calculator.js
echo "function add(a, b) { return a + b; }" >> calculator.js
echo "function subtract(a, b) { return a - b; }" >> calculator.js
git add .
git commit -m "feat: basic calculator functions"
echo "Created initial commit"
echo ""

# Create multiple commits, one with a "bug"
echo "=== Creating Commit History ==="

echo "function multiply(a, b) { return a * b; }" >> calculator.js
git add calculator.js
git commit -m "feat: add multiply function"

echo "function divide(a, b) { return a / b; }" >> calculator.js
git add calculator.js
git commit -m "feat: add divide function"

# Introduce the bug
echo "# BUG: This function returns wrong value" >> calculator.js
echo "function modulo(a, b) { return a + b; }  // BUG: should be a % b" >> calculator.js
git add calculator.js
git commit -m "feat: add modulo function"

echo "function power(a, b) { return Math.pow(a, b); }" >> calculator.js
git add calculator.js
git commit -m "feat: add power function"

echo "function sqrt(a) { return Math.sqrt(a); }" >> calculator.js
git add calculator.js
git commit -m "feat: add sqrt function"

echo "function abs(a) { return Math.abs(a); }" >> calculator.js
git add calculator.js
git commit -m "feat: add abs function"

echo "function max(a, b) { return Math.max(a, b); }" >> calculator.js
git add calculator.js
git commit -m "feat: add max function"

echo "function min(a, b) { return Math.min(a, b); }" >> calculator.js
git add calculator.js
git commit -m "feat: add min function"

echo "function round(a) { return Math.round(a); }" >> calculator.js
git add calculator.js
git commit -m "feat: add round function"

echo "function floor(a) { return Math.floor(a); }" >> calculator.js
git add calculator.js
git commit -m "feat: add floor function"
echo "Created 10 commits"
echo ""

# Show commit history
echo "=== Commit History ==="
git log --oneline
echo ""

# Create a test script
echo "=== Creating Test Script ==="
cat > test.sh << 'EOF'
#!/bin/bash
# Test script - returns 0 if good, 1 if bad
# The bug is in modulo function: it returns a + b instead of a % b

node -e "
const calc = require('./calculator.js');
const result = calc.modulo(10, 3);
if (result === 1) {
  process.exit(0);  // Good
} else {
  process.exit(1);  // Bad
}
" 2>/dev/null

# If node fails, use grep to check
if [ $? -ne 0 ]; then
  grep -q "return a % b" calculator.js
  if [ $? -eq 0 ]; then
    exit 0  # Good - correct implementation
  else
    exit 1  # Bad - still has bug
  fi
fi
EOF
chmod +x test.sh
echo "Created test.sh"
echo ""

# Manual bisect demonstration
echo "=== Manual Bisect Demo ==="
echo "Finding the buggy commit..."
echo ""

# Simulate bisect
GOOD_COMMIT=$(git log --oneline | tail -n 1 | cut -d' ' -f1)
BAD_COMMIT=$(git log --oneline | head -n 1 | cut -d' ' -f1)

echo "Good commit: $GOOD_COMMIT (before bug)"
echo "Bad commit: $BAD_COMMIT (after bug)"
echo ""

# Show the buggy commit
echo "=== The Buggy Commit ==="
git log --oneline | grep "modulo"
echo ""

# Show the bug
echo "=== The Bug ==="
git show HEAD~6:calculator.js | grep -A1 "modulo"
echo ""

# Explain bisect process
echo "=== Bisect Process ==="
echo "1. git bisect start"
echo "2. git bisect bad           # Current commit has bug"
echo "3. git bisect good $GOOD_COMMIT  # This commit was working"
echo "4. Git checks out middle commit"
echo "5. Test: ./test.sh"
echo "6. Mark: git bisect good or git bisect bad"
echo "7. Repeat until found"
echo "8. git bisect reset"
echo ""

# Demonstrate automated bisect
echo "=== Automated Bisect Command ==="
echo "git bisect start"
echo "git bisect bad HEAD"
echo "git bisect good $GOOD_COMMIT"
echo "git bisect run ./test.sh"
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

echo "=== Bisect Practice Complete ==="
echo "You've learned:"
echo "  - How git bisect works (binary search)"
echo "  - How to manually bisect"
echo "  - How to automate bisect with scripts"
echo "  - How to find the exact commit that introduced a bug"
