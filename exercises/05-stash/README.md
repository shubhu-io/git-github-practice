# Exercise 5: Stash

## Objective
Learn to temporarily save changes with git stash.

## Instructions

### Step 1: Start Working on Something
```bash
echo "work in progress" > wip.txt
```

### Step 2: Check Status
```bash
git status
```

`wip.txt` will be shown as untracked.

### Step 3: Stash the Changes
```bash
git stash save "WIP: working on wip.txt"
```

### Step 4: Verify Clean Working Directory
```bash
git status
```

The working directory should be clean.

### Step 5: Work on Something Else
```bash
echo "hotfix" > hotfix.txt
git add hotfix.txt
git commit -m "hotfix: urgent fix"
```

### Step 6: Apply the Stash
```bash
git stash pop
```

### Step 7: Verify Changes Are Back
```bash
ls wip.txt
git status
```

## Challenge

1. Create three different stashes
2. List all stashes
3. Apply a specific stash (not the most recent)
4. Drop a specific stash
5. Clear all stashes

## Stash Commands

```bash
git stash                      # Stash changes
git stash save "message"       # Stash with message
git stash list                 # List all stashes
git stash pop                  # Apply and remove
git stash apply                # Apply only
git stash drop                 # Delete most recent
git stash clear                # Delete all
git stash show                 # Show stash contents
```

## Next Steps

- Exercise 6: Pull Requests
- Practice with the `examples/stash-practice.sh` script
