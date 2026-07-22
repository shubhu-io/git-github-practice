# Exercise 14: Git Hooks

## Objective
Learn to create and use Git hooks.

## Instructions

### Step 1: Create a Pre-Commit Hook

```bash
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash
echo "Running pre-commit hook..."

# Check for console.log statements
if git diff --cached --name-only | xargs grep -l "console.log" 2>/dev/null; then
    echo "❌ Found console.log statements. Remove them before committing."
    exit 1
fi

echo "✅ Pre-commit hook passed!"
EOF

chmod +x .git/hooks/pre-commit
```

### Step 2: Create a Commit Message Hook

```bash
cat > .git/hooks/commit-msg << 'EOF'
#!/bin/bash
COMMIT_MSG=$(cat "$1")
PATTERN="^(feat|fix|docs|style|refactor|perf|test|build|ci|chore|revert)(\(.+\))?: .{1,72}"

if ! echo "$COMMIT_MSG" | grep -qE "$PATTERN"; then
    echo "❌ Invalid commit message format!"
    echo "Expected: <type>(<scope>): <description>"
    echo "Example: feat(auth): add login page"
    exit 1
fi
EOF

chmod +x .git/hooks/commit-msg
```

### Step 3: Test the Hooks

```bash
# Test pre-commit hook
echo "console.log('test')" > test.js
git add test.js
git commit -m "test"
# Should fail

# Remove console.log and commit
echo "// test" > test.js
git add test.js
git commit -m "test: remove console.log"
# Should pass
```

### Step 4: Use Husky (Modern Approach)

```bash
# Install husky
npm install husky --save-dev

# Initialize
npx husky init

# Add pre-commit hook
npx husky add .husky/pre-commit "npx lint-staged"
```

## Challenge

1. Create a hook that checks for TODO comments
2. Create a hook that runs tests before push
3. Create a hook that adds issue numbers to commits

## Key Concepts

- Hooks are scripts in `.git/hooks/`
- Must be executable (`chmod +x`)
- Client-side hooks run on your computer
- Server-side hooks run on the remote

## Next Steps

- Read [docs/GIT-HOOKS-GUIDE.md](docs/GIT-HOOKS-GUIDE.md)
- Set up Husky for your projects
