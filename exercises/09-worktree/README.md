# Exercise 9: Git Worktrees

## Objective
Learn to use Git worktrees for working on multiple branches simultaneously.

## Instructions

### Step 1: Create a Worktree

```bash
# Create worktree for feature branch
git worktree add ../feature-work feature/my-feature
```

### Step 2: Work in the Worktree

```bash
cd ../feature-work
echo "feature work" > feature.txt
git add feature.txt
git commit -m "feat: work done in worktree"
```

### Step 3: Switch Back to Main Worktree

```bash
cd ../original-repo
```

### Step 4: View All Worktrees

```bash
git worktree list
```

### Step 5: Create Worktree for Hotfix

```bash
# Create from specific commit
git worktree add -b hotfix/urgent ../hotfix-work HEAD~1
```

### Step 6: Remove Worktree

```bash
cd ../feature-work
git worktree remove .
```

## Challenge

1. Create 3 worktrees for different branches
2. Make changes in each worktree simultaneously
3. Merge changes from worktrees
4. Clean up all worktrees

## Use Cases

1. **Simultaneous Development** - Work on multiple features
2. **Hotfix Without Stashing** - Fix bugs without losing work
3. **Testing Different Branches** - Test builds from multiple branches
4. **Code Reviews** - Review PRs while keeping your work

## Next Steps

- Exercise 10: Reflog
- Practice with the `examples/worktree.sh` script
