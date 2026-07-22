# Exercise 10: Git Reflog

## Objective
Learn to use git reflog to recover lost commits and branches.

## Instructions

### Step 1: Create Some Commits

```bash
echo "commit 1" > file1.txt
git add file1.txt
git commit -m "commit 1"

echo "commit 2" > file2.txt
git add file2.txt
git commit -m "commit 2"

echo "commit 3" > file3.txt
git add file3.txt
git commit -m "commit 3"
```

### Step 2: View Reflog

```bash
git reflog
```

### Step 3: Accidentally Reset

```bash
git reset --hard HEAD~2
```

### Step 4: Use Reflog to Recover

```bash
git reflog
# Find the lost commit hash
git cherry-pick <commit-hash>
```

### Step 5: Recover Deleted Branch

```bash
# Create and delete a branch
git checkout -b feature/to-delete
echo "work" > work.txt
git add work.txt
git commit -m "feature work"
git checkout main
git branch -D feature/to-delete

# Recover using reflog
git reflog
git checkout -b feature/recovered <commit-hash>
```

## Challenge

1. Create 5 commits
2. Reset to 3 commits ago
3. Recover all lost commits
4. Recover a deleted branch

## Key Commands

```bash
git reflog                    # View all ref changes
git reflog show branch        # View specific branch reflog
git cherry-pick <hash>        # Recover a commit
git checkout -b <branch> <hash>  # Recover a branch
```

## Next Steps

- Exercise 11: Git Bisect
- Practice with the `examples/reflog-rescue.sh` script
