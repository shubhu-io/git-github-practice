# Exercise 7: Cherry-Pick

## Objective
Learn to apply specific commits from one branch to another.

## Instructions

### Step 1: Set Up the Scenario
```bash
# Create main branch
git checkout main
echo "main content" > main.txt
git add main.txt
git commit -m "feat: initial main"
```

### Step 2: Create a Feature Branch with Multiple Commits
```bash
git checkout -b feature/multiple-changes
echo "change 1" > change1.txt
git add change1.txt
git commit -m "feat: add change 1"

echo "change 2" > change2.txt
git add change2.txt
git commit -m "feat: add change 2"

echo "change 3" > change3.txt
git add change3.txt
git commit -m "feat: add change 3"
```

### Step 3: View the History
```bash
git log --oneline
```

### Step 4: Cherry-Pick a Specific Commit
```bash
# Get the commit hash you want
COMMIT_HASH=$(git log --oneline | head -n 2 | tail -n 1 | cut -d' ' -f1)

# Cherry-pick it
git checkout main
git cherry-pick $COMMIT_HASH
```

### Step 5: Verify the Cherry-Pick
```bash
git log --oneline
ls change2.txt
```

## Challenge

1. Cherry-pick a range of commits
2. Cherry-pick with conflicts and resolve them
3. Cherry-pick and modify the commit message

## Cherry-Pick Commands

```bash
git cherry-pick <commit>           # Apply single commit
git cherry-pick <commit1>..<commit2>  # Apply range
git cherry-pick --no-commit <commit>  # Apply without committing
```

## Next Steps

- Exercise 8: Git Bisect
- Practice with the `examples/cherry-pick.sh` script
