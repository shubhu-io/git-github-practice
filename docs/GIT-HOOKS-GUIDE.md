---
layout: single
title: Git Hooks Guide
---
# Git Hooks Guide

Complete guide to Git hooks.

## What are Git Hooks?

Scripts that run automatically when certain Git events occur. They help enforce code quality and automate tasks.

## Hook Locations

```
.git/
├── hooks/
│   ├── pre-commit        # Runs before commit
│   ├── prepare-commit-msg # Modifies commit message
│   ├── commit-msg        # Validates commit message
│   ├── post-commit       # Runs after commit
│   ├── pre-push          # Runs before push
│   ├── pre-rebase        # Runs before rebase
│   ├── post-checkout     # Runs after checkout
│   └── post-merge        # Runs after merge
```

## Types of Hooks

### Client-Side Hooks (Run on your computer)

| Hook | When It Runs | Common Use |
|------|--------------|------------|
| `pre-commit` | Before commit | Linting, formatting |
| `prepare-commit-msg` | Before editor opens | Template messages |
| `commit-msg` | After commit message | Validate format |
| `post-commit` | After commit | Notifications |
| `pre-push` | Before push | Run tests |
| `post-checkout` | After checkout | Clear cache |
| `post-merge` | After merge | Install deps |

### Server-Side Hooks (Run on server)

| Hook | When It Runs | Common Use |
|------|--------------|------------|
| `pre-receive` | Before accepting push | Access control |
| `update` | Per branch update | Branch rules |
| `post-receive` | After accepting push | Notifications, CI |

## Creating a Hook

### Step 1: Create the Hook File

```bash
# Create pre-commit hook
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash

echo "Running pre-commit checks..."

# Run linter
npm run lint
if [ $? -ne 0 ]; then
    echo "❌ Linting failed!"
    exit 1
fi

# Run tests
npm test
if [ $? -ne 0 ]; then
    echo "❌ Tests failed!"
    exit 1
fi

echo "✅ All checks passed!"
EOF
```

### Step 2: Make It Executable

```bash
chmod +x .git/hooks/pre-commit
```

### Step 3: Test It

```bash
git commit -m "test"
# Hook should run
```

## Common Hook Examples

### pre-commit: Run Linter

```bash
#!/bin/bash
# .git/hooks/pre-commit

# Run ESLint
npx eslint --ext .js,.jsx,.ts,.tsx .
if [ $? -ne 0 ]; then
    echo "❌ Linting failed. Fix errors before committing."
    exit 1
fi
```

### pre-commit: Run Formatter

```bash
#!/bin/bash
# .git/hooks/pre-commit

# Check formatting
npx prettier --check "src/**/*.{js,jsx,ts,tsx,json,md}"
if [ $? -ne 0 ]; then
    echo "❌ Formatting issues found. Run 'npm run format' first."
    exit 1
fi
```

### commit-msg: Validate Conventional Commits

```bash
#!/bin/bash
# .git/hooks/commit-msg

COMMIT_MSG=$(cat "$1")
PATTERN="^(feat|fix|docs|style|refactor|perf|test|build|ci|chore|revert)(\(.+\))?: .{1,72}"

if ! echo "$COMMIT_MSG" | grep -qE "$PATTERN"; then
    echo "❌ Invalid commit message format!"
    echo ""
    echo "Expected: <type>(<scope>): <description>"
    echo "Types: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert"
    echo ""
    echo "Example: feat(auth): add login page"
    exit 1
fi
```

### pre-push: Run Tests

```bash
#!/bin/bash
# .git/hooks/pre-push

echo "Running tests before push..."

npm test
if [ $? -ne 0 ]; then
    echo "❌ Tests failed. Fix before pushing."
    exit 1
fi
```

### post-checkout: Clear Cache

```bash
#!/bin/bash
# .git/hooks/post-checkout

# Clear npm cache on branch switch
npm cache clean --force 2>/dev/null

# Reinstall if package.json changed
if [ "$1" != "$2" ]; then
    echo "📦 Installing dependencies..."
    npm install
fi
```

### post-merge: Install Dependencies

```bash
#!/bin/bash
# .git/hooks/post-merge

# Check if package.json changed
CHANGED=$(git diff HEAD@{1} HEAD --name-only | grep package.json)

if [ "$CHANGED" ]; then
    echo "📦 package.json changed, installing dependencies..."
    npm install
fi
```

## Using Husky (Recommended)

Husky makes Git hooks easy to manage.

### Setup

```bash
# Install husky
npm install husky --save-dev

# Initialize
npx husky init

# Add hook
npx husky add .husky/pre-commit "npm run lint"
```

### package.json Configuration

```json
{
  "scripts": {
    "prepare": "husky"
  }
}
```

### .husky Directory

```
.husky/
├── pre-commit      # Runs on commit
├── commit-msg      # Validates message
└── pre-push        # Runs before push
```

### Example: .husky/pre-commit

```bash
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

npx lint-staged
```

## Sharing Hooks

### Option 1: npm package

```bash
# Install
npm install --save-dev husky lint-staged

# .husky/pre-commit
npx lint-staged

# package.json
{
  "lint-staged": {
    "*.{js,ts}": ["eslint --fix", "prettier --write"],
    "*.{json,md}": ["prettier --write"]
  }
}
```

### Option 2: Git Directory

```bash
# Commit hooks (not recommended)
git add .git/hooks
```

### Option 3: Core.hooksPath

```bash
# Use custom hooks directory
git config core.hooksPath .githooks

# .githooks/pre-commit
#!/bin/bash
# Your hook script
```

## Debugging Hooks

### Add Debug Output

```bash
#!/bin/bash
# Add this at the top
set -x  # Enable debug mode

# Your hook code
```

### Check Hook Location

```bash
# Verify hook is in right place
ls -la .git/hooks/

# Check if executable
chmod +x .git/hooks/pre-commit
```

### Test Hook Manually

```bash
# Run hook directly
.git/hooks/pre-commit
```

## Best Practices

1. **Keep hooks fast** - Don't slow down workflow
2. **Provide clear messages** - Tell users what went wrong
3. **Allow bypass when needed** - `git commit --no-verify`
4. **Version control shared hooks** - Use .githooks or npm
5. **Test hooks** - Make sure they work
6. **Document hooks** - Explain what they do

## Bypassing Hooks

```bash
# Skip pre-commit hook
git commit --no-verify -m "message"

# Skip pre-push hook
git push --no-verify
```

**Warning:** Only bypass hooks when necessary!

## Resources

- [Git Hooks Documentation](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks)
- [Husky Documentation](https://typicode.github.io/husky/)
- [lint-staged](https://github.com/lint-staged/lint-staged)
