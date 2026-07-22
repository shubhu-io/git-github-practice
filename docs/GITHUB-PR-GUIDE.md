---
title: Pull Request Guide
---
# GitHub Pull Request Guide

A comprehensive guide to creating, managing, and reviewing Pull Requests on GitHub.

## What is a Pull Request?

A Pull Request (PR) is a way to propose changes to a repository. It allows others to review, discuss, and approve changes before they are merged into the main branch.

## Creating a Pull Request

### 1. Fork the Repository (for open source)

```bash
# Click "Fork" on GitHub, then clone your fork
git clone https://github.com/YOUR-USERNAME/repository.git
cd repository

# Add upstream remote
git remote add upstream https://github.com/ORIGINAL-OWNER/repository.git
```

### 2. Create a Branch

```bash
# Sync with upstream first
git fetch upstream
git checkout main
git merge upstream/main

# Create feature branch
git checkout -b feature/your-feature-name
```

### 3. Make Changes and Commit

```bash
# Make your changes
# ... edit files ...

# Stage and commit
git add .
git commit -m "feat: add new feature description"
```

### 4. Push to Your Fork

```bash
git push origin feature/your-feature-name
```

### 5. Create the Pull Request

#### Using GitHub Web Interface
1. Go to the original repository
2. Click "Pull requests" tab
3. Click "New pull request"
4. Select your branch
5. Fill in the PR template
6. Click "Create pull request"

#### Using GitHub CLI
```bash
gh pr create \
  --title "Add new feature" \
  --body "Description of the changes" \
  --base main \
  --head feature/your-feature-name
```

## PR Best Practices

### Title
- Use conventional commit format: `feat:`, `fix:`, etc.
- Keep it concise and descriptive
- Example: `feat(auth): add OAuth2 support`

### Description
```markdown
## Description
Brief description of what this PR does.

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Unit tests added/updated
- [ ] Integration tests pass
- [ ] Manual testing completed

## Checklist
- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] No breaking changes (or documented)
```

## Reviewing Pull Requests

### As a Reviewer

1. **Check the description** - Understand what the PR aims to do
2. **Review the code** - Look for bugs, style issues, and improvements
3. **Test locally** - Pull the branch and test the changes
4. **Leave constructive feedback** - Be specific and helpful
5. **Approve or request changes** - Use GitHub's review system

### Review Comments

```
# Suggestion
suggestion: Consider using const instead of let here

# Question
question: What happens if the API returns null?

# Praise
love: Great implementation of the retry logic!

# Blocking
blocker: This needs to be fixed before merging
```

### Using GitHub CLI for Reviews

```bash
# View PR details
gh pr view 123

# Checkout PR branch
gh pr checkout 123

# Approve PR
gh pr review 123 --approve

# Request changes
gh pr review 123 --request-changes --body "Please fix..."
```

## Merging Pull Requests

### Merge Types

#### Merge Commit (default)
- Preserves all commits
- Creates a merge commit
- Good for: preserving history

#### Squash and Merge
- Combines all commits into one
- Cleaner history
- Good for: small features

#### Rebase and Merge
- Replays commits on top of base
- Linear history
- Good for: clean history

### Merging via CLI

```bash
# Merge commit
gh pr merge 123 --merge

# Squash and merge
gh pr merge 123 --squash

# Rebase and merge
gh pr merge 123 --rebase
```

## Managing Pull Requests

### Update PR with New Changes

```bash
# Make more commits
git add .
git commit -m "fix: address review comments"

# Push to same branch
git push origin feature/your-feature-name
# PR automatically updates
```

### Resolve Merge Conflicts

```bash
# Fetch latest changes
git fetch upstream

# Rebase on main
git checkout feature/your-feature-name
git rebase upstream/main

# Resolve conflicts in files
# Then continue rebase
git add .
git rebase --continue

# Force push (required after rebase)
git push --force-with-lease origin feature/your-feature-name
```

### Close a PR Without Merging

```bash
# Close via CLI
gh pr close 123

# Or comment "Close #123" in a commit
```

## PR Labels

Common labels for PRs:
- `bug` - Bug fix
- `enhancement` - New feature
- `documentation` - Docs changes
- `dependencies` - Dependency updates
- `needs-review` - Ready for review
- `ready-to-merge` - Approved and ready

## PR Templates

### Bug Fix Template

```markdown
## Bug Description
What bug does this fix?

## Root Cause
What caused the bug?

## Solution
How does this fix the bug?

## Testing
How was this tested?

## Screenshots
If applicable, add screenshots.

## Related Issues
Closes #123
```

### Feature Template

```markdown
## Feature Description
What feature does this add?

## Motivation
Why is this feature needed?

## Implementation
How was this implemented?

## Testing
How was this tested?

## Documentation
Was documentation added/updated?

## Related Issues
Closes #456
```

## Advanced Topics

### Draft Pull Requests

Create a PR that's not ready for review:

```bash
gh pr create --draft --title "WIP: New feature"
```

### Pull Request Reviews

Request specific reviewers:

```bash
gh pr edit 123 --add-reviewer username1,username2
```

### Auto-merge

Enable auto-merge when all checks pass:

```bash
gh pr merge 123 --auto --squash
```

## Common Issues

### "This branch is out-of-date"
```bash
git fetch upstream
git checkout feature/your-feature-name
git rebase upstream/main
git push --force-with-lease
```

### "Changes requested"
1. Address the feedback
2. Push new commits
3. Re-request review

### "Merge conflict"
1. Fetch latest changes
2. Rebase on main
3. Resolve conflicts
4. Force push

## Links

- [GitHub Pull Request Documentation](https://docs.github.com/en/pull-requests)
- [GitHub CLI PR Commands](https://cli.github.com/manual/gh_pr)
- [Conventional Commits](https://www.conventionalcommits.org/)
