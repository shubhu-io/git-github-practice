# Exercise 6: Pull Requests

## Objective
Learn the GitHub Pull Request workflow.

## Instructions

### Step 1: Fork the Repository (on GitHub)
1. Go to the repository on GitHub
2. Click the "Fork" button
3. Clone your fork:
```bash
git clone https://github.com/YOUR-USERNAME/repository.git
cd repository
```

### Step 2: Add Upstream Remote
```bash
git remote add upstream https://github.com/ORIGINAL-OWNER/repository.git
git remote -v
```

### Step 3: Create a Feature Branch
```bash
git checkout -b feature/my-contribution
```

### Step 4: Make Changes
```bash
echo "# My Contribution" > CONTRIBUTION.md
git add CONTRIBUTION.md
git commit -m "docs: add my contribution"
```

### Step 5: Push to Your Fork
```bash
git push origin feature/my-contribution
```

### Step 6: Create Pull Request (GitHub CLI)
```bash
gh pr create \
  --title "Add my contribution" \
  --body "This PR adds my contribution to the project."
```

Or create manually on GitHub:
1. Go to your fork
2. Click "New pull request"
3. Select your branch
4. Fill in the PR template
5. Click "Create pull request"

### Step 7: Wait for Review
- Address any feedback
- Make additional commits if needed
- Push to the same branch

### Step 8: Merge the PR
- On GitHub, click "Merge pull request"
- Or use CLI: `gh pr merge <PR-NUMBER>`

## PR Best Practices

1. **Write a clear title** - Use conventional commit format
2. **Describe your changes** - Explain what and why
3. **Keep PRs small** - Easier to review
4. **Add tests** - Prove your changes work
5. **Update documentation** - Keep docs current

## Verification

```bash
# Check your PR exists
gh pr list

# View PR details
gh pr view <PR-NUMBER>

# Check PR checks
gh pr checks <PR-NUMBER>
```

## Next Steps

- Practice with open source projects
- Review other people's PRs
- Learn about code review best practices
