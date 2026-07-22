---
layout: default
title: Practice Exercises
nav_order: 7
---
# Practice Exercises

Complete these exercises to master Git.

## How to Use This Document

1. Start from the top
2. Complete each exercise
3. Check your work
4. Move to the next exercise

## Beginner Exercises

### Exercise 1: Hello Git
**Goal:** Create your first repository and commit.

**Tasks:**
1. Create a folder called `hello-git`
2. Initialize a Git repository
3. Create a file called `hello.txt` with "Hello, Git!"
4. Stage the file
5. Commit with message "First commit"

**Check:**
```bash
git log --oneline
# Should show: abc1234 First commit
```

### Exercise 2: Multiple Files
**Goal:** Work with multiple files.

**Tasks:**
1. Create `file1.txt` and `file2.txt`
2. Stage both files
3. Commit with message "Add two files"
4. Verify both files are tracked

**Check:**
```bash
git ls-files
# Should show both files
```

### Exercise 3: See Changes
**Goal:** Understand git diff.

**Tasks:**
1. Modify `file1.txt`
2. Run `git diff`
3. Stage the change
4. Run `git diff --staged`
5. Commit the change

**Check:**
```bash
git log --oneline
# Should show two commits
```

## Intermediate Exercises

### Exercise 4: Branching
**Goal:** Create and use branches.

**Tasks:**
1. Create a branch called `feature/test`
2. Switch to the new branch
3. Create `feature.txt`
4. Commit the file
5. Switch back to `main`
6. Verify `feature.txt` doesn't exist on main

**Check:**
```bash
git branch
# Should show main and feature/test
```

### Exercise 5: Merging
**Goal:** Merge branches together.

**Tasks:**
1. Switch to `feature/test`
2. Switch to `main`
3. Merge `feature/test` into `main`
4. Verify `feature.txt` now exists

**Check:**
```bash
ls feature.txt
# Should exist
```

### Exercise 6: Merge Conflict
**Goal:** Resolve a merge conflict.

**Tasks:**
1. Create branch `feature/a`
2. Modify `README.md` on main
3. Modify `README.md` on `feature/a`
4. Try to merge
5. Resolve the conflict
6. Complete the merge

**Check:**
```bash
git log --oneline --graph
# Should show merge commit
```

### Exercise 7: Stash
**Goal:** Use git stash.

**Tasks:**
1. Make changes to a file (don't commit)
2. Stash the changes
3. Verify working directory is clean
4. Apply the stash
5. Verify changes are back

**Check:**
```bash
git stash list
# Should show stashes
```

## Advanced Exercises

### Exercise 8: Rebase
**Goal:** Rebase a branch.

**Tasks:**
1. Create branch `feature/rebase`
2. Make 3 commits
3. Switch to main
4. Make 2 commits
5. Rebase `feature/rebase` onto main
6. Verify linear history

**Check:**
```bash
git log --oneline --graph
# Should show linear history
```

### Exercise 9: Cherry-pick
**Goal:** Cherry-pick a commit.

**Tasks:**
1. Create branch `feature/a` with commit "Change A"
2. Create branch `feature/b` with commit "Change B"
3. Switch to `main`
4. Cherry-pick commit from `feature/a`

**Check:**
```bash
git log --oneline
# Should show Change A commit
```

### Exercise 10: Interactive Rebase
**Goal:** Squash commits.

**Tasks:**
1. Create 4 commits on a branch
2. Use interactive rebase to squash last 3
3. Verify only 2 commits remain

**Check:**
```bash
git log --oneline
# Should show 2 commits
```

### Exercise 11: Git Bisect
**Goal:** Find a bug with bisect.

**Tasks:**
1. Create 10 commits
2. Mark one as "bad"
3. Use bisect to find it
4. Verify you found the right commit

**Check:**
```bash
git bisect reset
# Should return to original state
```

### Exercise 12: Git Reflog
**Goal:** Recover lost work.

**Tasks:**
1. Create 3 commits
2. Reset to 2 commits ago (lose commits)
3. Use reflog to find lost commits
4. Recover them

**Check:**
```bash
git reflog
# Should show all ref changes
```

## Real-World Scenarios

### Exercise 13: Feature Branch Workflow
**Goal:** Complete a feature workflow.

**Tasks:**
1. Fork a repository
2. Clone your fork
3. Create feature branch
4. Make changes
5. Commit
6. Push
7. Create PR
8. Merge
9. Clean up

### Exercise 14: Hotfix Workflow
**Goal:** Handle a production bug.

**Tasks:**
1. Create hotfix branch from main
2. Fix the bug
3. Commit
4. Merge to main
5. Tag as hotfix
6. Update develop branch

### Exercise 15: Open Source Contribution
**Goal:** Contribute to open source.

**Tasks:**
1. Find an open source project
2. Fork it
3. Find a good first issue
4. Create a fix
5. Submit PR
6. Respond to feedback

## Daily Challenges

### Week 1 Challenge
- [ ] Create 5 repositories
- [ ] Make 20 commits total
- [ ] Use 3 different branches

### Week 2 Challenge
- [ ] Resolve 3 merge conflicts
- [ ] Complete 5 exercises
- [ ] Run 3 example scripts

### Week 3 Challenge
- [ ] Create 3 pull requests
- [ ] Review someone else's PR
- [ ] Fork and contribute to a project

### Week 4 Challenge
- [ ] Use interactive rebase
- [ ] Set up GitHub Actions
- [ ] Create a complete project workflow

## Tracking Progress

### Checklist

**Basics**
- [ ] Installation & setup
- [ ] First repository
- [ ] Basic commands

**Branching**
- [ ] Creating branches
- [ ] Switching branches
- [ ] Merging branches
- [ ] Resolving conflicts

**Collaboration**
- [ ] Remote repositories
- [ ] Push/pull
- [ ] Pull requests
- [ ] Fork workflow

**Advanced**
- [ ] Stashing
- [ ] Rebasing
- [ ] Cherry-picking
- [ ] Tagging
- [ ] GitHub Actions

### Score Card

| Skill | Beginner | Intermediate | Advanced |
|-------|----------|--------------|----------|
| Basic Commands | ☐ | ☐ | ☐ |
| Branching | ☐ | ☐ | ☐ |
| Merging | ☐ | ☐ | ☐ |
| Collaboration | ☐ | ☐ | ☐ |
| Advanced | ☐ | ☐ | ☐ |

## Resources

- [docs/EXERCISES.md](EXERCISES.md) - More exercises
- [examples/](examples/) - Practice scripts
- [LEARNING-PATH.md](LEARNING-PATH.md) - Structured learning

## Next Steps

After completing all exercises:
1. Contribute to open source projects
2. Set up your own projects
3. Mentor others
4. Keep learning!
