# Advanced Exercise 16: Git Subtree Workflow

## Objective
Master Git subtree for managing projects within projects.

## Scenario
You're working on a monorepo that includes a shared library.

## Instructions

### Step 1: Add a Subtree

```bash
# Add external repository as subtree
git subtree add --prefix=libs/shared-library \
    https://github.com/org/shared-library.git main --squash

# Verify
ls libs/shared-library/
```

### Step 2: Make Changes to Subtree

```bash
# Make changes
cd libs/shared-library
echo "// New feature" >> src/utils.js
cd ../..

# Commit changes
git add .
git commit -m "feat(shared): add new utility function"
```

### Step 3: Push Changes Back

```bash
# Push changes to subtree repository
git subtree push --prefix=libs/shared-library \
    https://github.com/org/shared-library.git feature/new-util
```

### Step 4: Pull Updates

```bash
# Pull updates from subtree repository
git subtree pull --prefix=libs/shared-library \
    https://github.com/org/shared-library.git main --squash
```

## Challenge

1. Add a second subtree
2. Split a subtree into its own repository
3. Merge conflicting subtree changes

## Key Concepts

- Subtree keeps code in your repository
- Use `--squash` to collapse history
- Push/pull to sync with upstream
- Split to extract subtree as separate repo

## Solution

<details>
<summary>Solution</summary>

```bash
# Add second subtree
git subtree add --prefix=libs/utils \
    https://github.org/utils.git main --squash

# Split subtree
git subtree split --prefix=libs/shared-library -b shared-only

# Add as remote branch
git remote add shared libs/shared-library.git
git fetch shared
git merge shared-only --allow-unrelated-histories
```

</details>
