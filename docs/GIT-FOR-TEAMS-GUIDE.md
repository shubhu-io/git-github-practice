---
layout: default
title: Git for Teams
nav_order: 32
---
# Git for Teams Guide

Best practices for teams using Git.

## Team Workflow Selection

### Small Teams (2-5 people)

**Recommended:** GitHub Flow
```
main ──────────────────────────────────────►
  │                                          
  ├── feature/login ──────► PR ──► merge    
  │                                          
  └── feature/signup ─────► PR ──► merge    
```

**Rules:**
- Always create PRs
- At least 1 review required
- Deploy main automatically

### Medium Teams (5-20 people)

**Recommended:** Gitflow
```
main ──────────────────────────────────────►
  │                                          
  ├── develop ─────────────────────────────►
  │   │                                      
  │   ├── feature/login ────► PR ──► merge   
  │   │                                      
  │   └── feature/signup ───► PR ──► merge   
  │                                          
  └── release/1.0 ─────────► PR ──► merge    
```

**Rules:**
- Develop is integration branch
- Features branch from develop
- Releases branch from develop
- Hotfixes branch from main

### Large Teams (20+ people)

**Recommended:** Trunk-Based Development
```
main ──────────────────────────────────────►
  │   │                                      
  │   ├── feature ──► PR ──► merge (< 1 day) 
  │   │                                      
  │   └── feature ──► PR ──► merge (< 1 day) 
```

**Rules:**
- Short-lived branches (< 1 day)
- Feature flags for incomplete work
- Comprehensive testing
- Frequent integration

## Branch Naming Conventions

### Standard Naming

```
feature/user-authentication
bugfix/login-timeout
hotfix/security-patch
docs/api-documentation
refactor/extract-service
test/unit-tests
chore/update-dependencies
```

### With Issue Numbers

```
feature/123-user-authentication
bugfix/456-login-timeout
```

### With Author Name

```
feature/john/user-authentication
bugfix/jane/login-timeout
```

## Commit Message Standards

### Conventional Commits

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

### Examples

```bash
feat(auth): add OAuth2 support
fix(api): handle null response
docs(readme): update installation guide
test(auth): add unit tests for login
chore(deps): update dependencies
```

### Using commitlint

```bash
# Install
npm install --save-dev @commitlint/cli @commitlint/config-conventional

# commitlint.config.js
module.exports = {
  extends: ['@commitlint/config-conventional'],
};
```

## Code Review Process

### Before Reviewing

1. Check CI/CD passes
2. Read PR description
3. Understand the context

### During Review

1. Review functionality
2. Check code quality
3. Look for security issues
4. Verify tests exist
5. Check documentation

### Review Checklist

- [ ] Code does what it's supposed to do
- [ ] Tests cover the changes
- [ ] No security vulnerabilities
- [ ] Documentation updated
- [ ] Follows coding standards
- [ ] No unnecessary complexity

## Branch Protection Rules

### Main Branch

1. ✅ Require pull request before merging
2. ✅ Require approvals (1-2)
3. ✅ Require status checks to pass
4. ✅ Require branches to be up to date
5. ✅ Require conversation resolution
6. ✅ Include administrators

### Develop Branch

1. ✅ Require pull request before merging
2. ✅ Require status checks to pass
3. ✅ Allow force pushes (for rebasing)

## CI/CD Pipeline

### Basic Pipeline

```yaml
name: CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
      - run: npm ci
      - run: npm test
      - run: npm run lint
```

### Deployment Pipeline

```yaml
name: Deploy

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm ci
      - run: npm run build
      - uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./dist
```

## Communication

### PR Descriptions

```markdown
## What
Brief description of changes

## Why
Reason for changes

## How
Implementation details

## Testing
How to test the changes

## Related Issues
Closes #123
```

### Issue Templates

```markdown
## Description
What is the issue?

## Steps to Reproduce
1. 
2. 
3. 

## Expected Behavior
What should happen?

## Actual Behavior
What actually happens?
```

## Tools and Integrations

### Required Tools

- **Git** - Version control
- **GitHub/GitLab/Bitbucket** - Remote hosting
- **CI/CD** - Automated testing/deployment
- **Linter** - Code quality
- **Formatter** - Code style

### Recommended Tools

- **VS Code** - Editor with Git integration
- **GitHub Desktop** - GUI client
- **Sourcetree** - Advanced Git GUI
- **Husky** - Git hooks
- **lint-staged** - Pre-commit linting

## Onboarding New Team Members

### Checklist

- [ ] GitHub account created
- [ ] SSH key added
- [ ] Repository access granted
- [ ] Development environment set up
- [ ] Git configuration done
- [ ] Workflow documented
- [ ] First PR created

### Documentation

- [ ] README with setup instructions
- [ ] CONTRIBUTING.md with guidelines
- [ ] CODE_OF_CONDUCT.md
- [ ] Issue/PR templates
- [ ] Branch protection rules

## Resources

- [GitHub Guides](https://guides.github.com/)
- [Git Flow](https://nvie.com/posts/a-successful-git-branching-model/)
- [GitHub Flow](https://docs.github.com/en/get-started/using-github/github-flow)
