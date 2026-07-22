# Exercise 4: Rebase

## Objective
Learn to rebase branches for a cleaner history.

## Instructions

### Step 1: Set Up the Scenario
```bash
# Create main branch with commits
git checkout main
echo "main change 1" >> README.md
git add README.md
git commit -m "feat: main change 1"

echo "main change 2" >> README.md
git add README.md
git commit -m "feat: main change 2"
```

### Step 2: Create a Feature Branch
```bash
git checkout -b feature/my-feature
echo "feature change 1" > feature.txt
git add feature.txt
git commit -m "feat: add feature change 1"
```

### Step 3: See the History Before Rebase
```bash
git log --oneline --graph --all
```

You'll see the feature branch diverged from main.

### Step 4: Rebase onto Main
```bash
git rebase main
```

### Step 5: See the History After Rebase
```bash
git log --oneline --graph --all
```

The history should now be linear!

### Step 6: Merge (Fast-Forward)
```bash
git checkout main
git merge feature/my-feature
```

This should be a fast-forward merge (no merge commit).

## Challenge

1. Create a main branch with 3 commits
2. Create a feature branch with 3 commits
3. Rebase the feature branch onto main
4. Verify the history is linear
5. Merge using fast-forward

## Rebase vs Merge

| Aspect | Rebase | Merge |
|--------|--------|-------|
| History | Linear | Branching |
| Merge commits | No | Yes |
| Safe for shared branches | No | Yes |
| Complexity | Higher | Lower |

## Important Notes

- **Never rebase commits that have been pushed to a shared repository**
- Rebase rewrites commit history
- Use merge for public/shared branches
- Use rebase for local/private branches

## Next Steps

- Exercise 5: Stash
- Practice with the `examples/rebase-practice.sh` script
