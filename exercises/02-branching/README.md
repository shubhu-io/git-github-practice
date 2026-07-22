# Exercise 2: Branching

## Objective
Learn to create, switch between, and manage Git branches.

## Instructions

### Step 1: Create a New Branch
```bash
git branch feature/my-feature
```

### Step 2: List All Branches
```bash
git branch
```

You should see:
```
* main
  feature/my-feature
```

### Step 3: Switch to the New Branch
```bash
git checkout feature/my-feature
```

Or using the newer command:
```bash
git switch feature/my-feature
```

### Step 4: Verify You're on the New Branch
```bash
git branch
```

The `*` should now be next to `feature/my-feature`.

### Step 5: Make Changes on the New Branch
```bash
echo "# New Feature" > feature.md
echo "This is a new feature!" >> feature.md
git add feature.md
git commit -m "feat: add new feature"
```

### Step 6: Switch Back to Main
```bash
git checkout main
```

### Step 7: Verify the Feature File Doesn't Exist on Main
```bash
ls feature.md
```

This should show an error - the file only exists on the feature branch!

### Step 8: Merge the Feature Branch
```bash
git merge feature/my-feature
```

### Step 9: Verify the Feature File Now Exists
```bash
ls feature.md
```

### Step 10: Delete the Feature Branch
```bash
git branch -d feature/my-feature
```

## Challenge

1. Create three branches: `feature/a`, `feature/b`, `feature/c`
2. Make a different commit on each branch
3. Merge all three into main
4. Delete all feature branches

## Verification

```bash
# Check branch history
git log --oneline --graph

# Verify all files exist
ls -la

# Check no extra branches remain
git branch
```

## Next Steps

- Exercise 3: Merge Conflicts
- Practice with the `examples/branching.sh` script
