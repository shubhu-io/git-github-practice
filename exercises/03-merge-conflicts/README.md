# Exercise 3: Merge Conflicts

## Objective
Learn to create and resolve merge conflicts.

## Instructions

### Step 1: Create a Branch and Make Changes
```bash
git checkout -b feature/change-color
echo "color=blue" > config.txt
git add config.txt
git commit -m "feat: add color config"
```

### Step 2: Switch to Main and Make Conflicting Changes
```bash
git checkout main
echo "color=red" > config.txt
git add config.txt
git commit -m "feat: set color to red"
```

### Step 3: Try to Merge (Will Conflict)
```bash
git merge feature/change-color
```

You should see a conflict message like:
```
Auto-merging config.txt
CONFLICT (content): Merge conflict in config.txt
Automatic merge failed; fix conflicts and then commit the result.
```

### Step 4: View the Conflict
```bash
cat config.txt
```

You'll see conflict markers:
```
<<<<<<< HEAD
color=red
=======
color=blue
>>>>>>> feature/change-color
```

### Step 5: Resolve the Conflict
Edit `config.txt` to choose one version or combine them:
```
color=purple
```

Or keep one version:
```
color=blue
```

### Step 6: Stage the Resolved File
```bash
git add config.txt
```

### Step 7: Complete the Merge
```bash
git commit -m "fix: resolve merge conflict in config"
```

### Step 8: Verify the Resolution
```bash
git log --oneline --graph
cat config.txt
```

## Challenge

1. Create a branch that modifies line 1 of a file
2. Create another branch that modifies line 1 differently
3. Try to merge both into main
4. Resolve the conflicts

## Tips

- Look for `<<<<<<<`, `=======`, and `>>>>>>>` markers
- Choose which version to keep (or combine both)
- Remove all conflict markers before committing
- Use `git diff` to see what changed

## Next Steps

- Exercise 4: Rebase
- Practice with the `examples/merge-conflict.sh` script
