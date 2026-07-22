---
layout: default
title: Git Interview Questions
nav_order: 29
---
# Git Interview Questions

Common Git interview questions and answers.

## Basic Questions

### Q1: What is Git?
**Answer:** Git is a distributed version control system that tracks changes in source code during software development. It allows multiple developers to work on the same project simultaneously.

### Q2: What is the difference between Git and GitHub?
**Answer:**
- **Git**: Version control system (runs locally)
- **GitHub**: Web-based platform for hosting Git repositories (runs online)

### Q3: What are the three main areas in Git?
**Answer:**
1. **Working Directory** - Your actual files
2. **Staging Area** - Where you prepare changes
3. **Repository** - Where commits are stored

### Q4: What is a commit?
**Answer:** A commit is a snapshot of changes at a specific point in time. It has a unique SHA-1 hash and contains metadata like author, date, and message.

### Q5: What is a branch?
**Answer:** A branch is a lightweight, movable pointer to a commit. It allows parallel development without affecting the main codebase.

## Intermediate Questions

### Q6: What is the difference between `git merge` and `git rebase`?
**Answer:**
- **Merge**: Creates a merge commit, preserves history
- **Rebase**: Replays commits on top of another branch, creates linear history

### Q7: What is a merge conflict?
**Answer:** A merge conflict occurs when Git cannot automatically merge changes from different branches. You must manually resolve the conflicts.

### Q8: What is `git stash`?
**Answer:** Git stash temporarily stores uncommitted changes so you can work on something else. Use `git stash pop` to restore them.

### Q9: What is the difference between `git pull` and `git fetch`?
**Answer:**
- **Fetch**: Downloads changes without applying
- **Pull**: Fetches and merges changes

### Q10: What is `git cherry-pick`?
**Answer:** Cherry-pick applies a specific commit from one branch to another, useful for applying fixes to multiple branches.

## Advanced Questions

### Q11: What is a detached HEAD?
**Answer:** When HEAD points to a commit instead of a branch name. This happens when checking out a specific commit. Changes are lost if you switch branches.

### Q12: What is `git rebase -i`?
**Answer:** Interactive rebase allows you to modify commits during rebase - squash, reword, edit, or drop commits.

### Q13: What is `git bisect`?
**Answer:** Git bisect uses binary search to find the commit that introduced a bug by testing intermediate commits.

### Q14: What is a bare repository?
**Answer:** A repository with no working directory, used as a central server. Created with `git init --bare`.

### Q15: What is `git reflog`?
**Answer:** Reference log tracks all changes to HEAD and branches. Useful for recovering lost commits.

## Scenario Questions

### Q16: How do you undo the last commit?
**Answer:**
```bash
# Keep changes
git reset HEAD~1

# Discard changes (DANGEROUS)
git reset --hard HEAD~1

# Create undo commit (safe for shared)
git revert HEAD
```

### Q17: How do you resolve a merge conflict?
**Answer:**
1. Open the conflicted file
2. Find conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`)
3. Choose which changes to keep
4. Remove the markers
5. Stage and commit

### Q18: How do you recover a deleted branch?
**Answer:**
```bash
git reflog
git checkout -b recovered-branch abc1234
```

### Q19: How do you squash commits?
**Answer:**
```bash
git rebase -i HEAD~3
# Change 'pick' to 'squash' for commits to combine
```

### Q20: How do you see who changed a line?
**Answer:**
```bash
git blame filename.txt
```

## System Design Questions

### Q21: Design a Git branching strategy.
**Answer:** Consider:
- **Main**: Production-ready code
- **Develop**: Integration branch
- **Feature/**: New features
- **Release/**: Release preparation
- **Hotfix/**: Emergency fixes

### Q22: How would you handle a large monorepo?
**Answer:**
- Use sparse checkout
- Implement code ownership
- Use Git LFS for large files
- Consider monorepo tools (Nx, Turborepo)

### Q23: How do you migrate a large repository?
**Answer:**
- Use `git filter-branch` or BFG
- Consider history rewriting
- Plan downtime
- Communicate with team

## Best Practices Questions

### Q24: What makes a good commit message?
**Answer:**
- Use imperative mood ("Add" not "Added")
- Keep under 72 characters
- Describe what and why, not how
- Reference issues when relevant

### Q25: What is the Git workflow you follow?
**Answer:** My typical workflow:
1. Pull latest changes
2. Create feature branch
3. Make changes
4. Write tests
5. Commit with clear messages
6. Push and create PR
7. Code review
8. Merge

## Coding Questions

### Q26: Write a command to find a commit that introduced a bug.
**Answer:**
```bash
git bisect start
git bisect bad HEAD
git bisect good <good-commit>
# Test each commit
git bisect reset
```

### Q27: Write a command to see the difference between two branches.
**Answer:**
```bash
git diff branch1..branch2
# or
git diff branch1 branch2
```

### Q28: Write a command to unstage a file.
**Answer:**
```bash
git restore --staged filename.txt
# or
git reset HEAD filename.txt
```

### Q29: Write a command to see the last 10 commits.
**Answer:**
```bash
git log -10
# or
git log --oneline -10
```

### Q30: Write a command to delete a remote branch.
**Answer:**
```bash
git push origin --delete branch-name
```

## Resources

- [GitHub Interview Questions](https://github.com/topics/interview-questions)
- [Git Documentation](https://git-scm.com/doc)
- [LeetCode Git Problems](https://leetcode.com/)
