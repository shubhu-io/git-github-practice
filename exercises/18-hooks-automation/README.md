# Advanced Exercise 18: Git Hooks Automation

## Objective
Build a complete Git hooks automation system.

## Scenario
Create a team Git hooks setup that enforces standards.

## Instructions

### Step 1: Create Hooks Repository Structure

```bash
mkdir -p git-hooks-setup/{hooks,scripts,config}
```

### Step 2: Create Pre-Commit Hook

```bash
cat > git-hooks-setup/hooks/pre-commit << 'EOF'
#!/bin/bash

# Pre-commit hook that runs linting and formatting

echo "Running pre-commit checks..."

# Run lint-staged
npx lint-staged

if [ $? -ne 0 ]; then
    echo "❌ Pre-commit checks failed"
    exit 1
fi

echo "✅ Pre-commit checks passed"
EOF
```

### Step 3: Create Commit Message Hook

```bash
cat > git-hooks-setup/hooks/commit-msg << 'EOF'
#!/bin/bash

# Validate commit message format

commit_msg=$(cat "$1")
pattern="^(feat|fix|docs|style|refactor|perf|test|build|ci|chore|revert)(\(.+\))?: .{1,72}"

if ! echo "$commit_msg" | grep -qE "$pattern"; then
    echo "❌ Invalid commit message!"
    echo ""
    echo "Format: <type>(<scope>): <description>"
    echo ""
    echo "Examples:"
    echo "  feat(auth): add login page"
    echo "  fix(api): handle null response"
    echo "  docs(readme): update installation"
    echo ""
    echo "Types: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert"
    exit 1
fi

echo "✅ Commit message format valid"
EOF
```

### Step 4: Create Push Hook

```bash
cat > git-hooks-setup/hooks/pre-push << 'EOF'
#!/bin/bash

# Run tests before push

echo "Running pre-push checks..."

# Run tests
npm test

if [ $? -ne 0 ]; then
    echo "❌ Tests failed. Push aborted."
    exit 1
fi

# Run build
npm run build

if [ $? -ne 0 ]; then
    echo "❌ Build failed. Push aborted."
    exit 1
fi

echo "✅ Pre-push checks passed"
EOF
```

### Step 5: Create Installation Script

```bash
cat > git-hooks-setup/install.sh << 'EOF'
#!/bin/bash

# Install Git hooks

HOOKS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/hooks"
GIT_HOOKS_DIR="$(git rev-parse --git-dir)/hooks"

echo "Installing Git hooks..."

# Backup existing hooks
if [ -d "$GIT_HOOKS_DIR" ]; then
    backup_dir="$GIT_HOOKS_DIR.backup.$(date +%Y%m%d%H%M%S)"
    mv "$GIT_HOOKS_DIR" "$backup_dir"
    echo "Backed up existing hooks to $backup_dir"
fi

# Create hooks directory
mkdir -p "$GIT_HOOKS_DIR"

# Copy hooks
for hook in "$HOOKS_DIR"/*; do
    if [ -f "$hook" ]; then
        hook_name=$(basename "$hook")
        cp "$hook" "$GIT_HOOKS_DIR/$hook_name"
        chmod +x "$GIT_HOOKS_DIR/$hook_name"
        echo "Installed $hook_name"
    fi
done

echo "✅ Git hooks installed successfully"
EOF

chmod +x git-hooks-setup/install.sh
```

## Challenge

1. Add a secret scanning hook
2. Add a branch naming validation hook
3. Create a hook manager that can enable/disable hooks

## Key Concepts

- Hooks can be shared via a repository
- Installation scripts make setup easy
- Hooks enforce team standards
- Can be combined with Husky

## Solution

<details>
<summary>Solution</summary>

```bash
# Secret scanning hook
cat > git-hooks-setup/hooks/pre-commit-secrets << 'EOF'
#!/bin/bash

# Check for secrets in staged files

patterns=(
    "AKIA[0-9A-Z]{16}"           # AWS Access Key
    "ghp_[0-9a-zA-Z]{36}"        # GitHub Token
    "sk-[0-9a-zA-Z]{32}"         # OpenAI Key
    "password\s*=\s*['\"].*['\"]" # Password assignment
)

for pattern in "${patterns[@]}"; do
    if git diff --cached --name-only | xargs grep -lE "$pattern" 2>/dev/null; then
        echo "⚠️  Potential secret detected!"
        echo "Pattern: $pattern"
        exit 1
    fi
done

echo "✅ No secrets detected"
EOF

# Branch naming hook
cat > git-hooks-setup/hooks/pre-push-branch << 'EOF'
#!/bin/bash

# Validate branch name format

branch=$(git symbolic-ref HEAD 2>/dev/null | cut -d/ -f3-)
pattern="^(feature|bugfix|hotfix|docs|chore)/[a-z0-9-]+$"

if ! echo "$branch" | grep -qE "$pattern"; then
    echo "❌ Invalid branch name: $branch"
    echo ""
    echo "Format: <type>/<name>"
    echo "Types: feature, bugfix, hotfix, docs, chore"
    echo "Example: feature/user-auth"
    exit 1
fi

echo "✅ Branch name valid"
EOF
```

</details>
