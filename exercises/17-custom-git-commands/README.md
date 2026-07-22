# Advanced Exercise 17: Custom Git Commands

## Objective
Create your own Git commands using shell scripts.

## Instructions

### Step 1: Create Git Command Directory

```bash
# Create directory for custom commands
mkdir -p ~/.git-commands
```

### Step 2: Create Custom Command

```bash
# Create a quick-commit command
cat > ~/.git-commands/git-quick-commit << 'EOF'
#!/bin/bash
# Quick commit with conventional commit format

type=$1
scope=$2
message=$3

if [ -z "$type" ] || [ -z "$message" ]; then
    echo "Usage: git quick-commit <type> [scope] <message>"
    echo ""
    echo "Types: feat, fix, docs, style, refactor, perf, test, chore"
    exit 1
fi

if [ -n "$scope" ]; then
    git commit -m "$type($scope): $message"
else
    git commit -m "$type: $message"
fi
EOF

chmod +x ~/.git-commands/git-quick-commit
```

### Step 3: Create Alias

```bash
# Add alias to git config
git config --global alias.quick-commit '!~/.git-commands/git-quick-commit'

# Now use it
git quick-commit feat auth "add login page"
```

### Step 4: Create More Commands

```bash
# git-smart-status - Show status with more details
cat > ~/.git-commands/git-smart-status << 'EOF'
#!/bin/bash
echo "=== Branch Status ==="
git branch -v
echo ""
echo "=== Working Tree ==="
git status --short
echo ""
echo "=== Recent Commits ==="
git log --oneline -5
EOF

chmod +x ~/.git-commands/git-smart-status
git config --global alias.ss '!~/.git-commands/git-smart-status'
```

## Challenge

1. Create a command to squash last N commits
2. Create a command to show diff stats
3. Create a command to create feature branch with template

## Key Concepts

- Custom commands go in PATH or ~/.git-commands
- Use `git config --global alias` to create shortcuts
- Commands are just shell scripts
- Can use any Git command inside

## Solution

<details>
<summary>Solution</summary>

```bash
# Squash command
cat > ~/.git-commands/git-squash << 'EOF'
#!/bin/bash
count=${1:-2}
git reset --soft HEAD~$count
git commit
EOF

# Diff stats command
cat > ~/.git-commands/git-diff-stats << 'EOF'
#!/bin/bash
git diff --stat $1 $2
echo ""
git diff --shortstat $1 $2
EOF

# Feature branch template
cat > ~/.git-commands/git-feature << 'EOF'
#!/bin/bash
name=$1
if [ -z "$name" ]; then
    echo "Usage: git feature <name>"
    exit 1
fi
git checkout -b "feature/$name"
git commit --allow-empty -m "feat($name): initial commit"
EOF
```

</details>
