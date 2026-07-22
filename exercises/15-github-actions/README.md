# Exercise 15: GitHub Actions

## Objective
Create a basic CI/CD pipeline with GitHub Actions.

## Instructions

### Step 1: Create Workflow Directory

```bash
mkdir -p .github/workflows
```

### Step 2: Create CI Workflow

```yaml
# .github/workflows/ci.yml
name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Run tests
        run: npm test
      
      - name: Run linter
        run: npm run lint
```

### Step 3: Push and Watch

```bash
git add .github/workflows/ci.yml
git commit -m "ci: add GitHub Actions workflow"
git push origin main
```

### Step 4: View Results

1. Go to your repository on GitHub
2. Click **Actions** tab
3. Watch the workflow run

## Challenge

1. Add a build step
2. Add a deployment step
3. Create a matrix build for multiple Node.js versions

## Key Concepts

- Workflows are in `.github/workflows/`
- YAML format
- Triggered by events (push, PR, etc.)
- Consist of jobs and steps

## Next Steps

- Read [docs/github-actions-guide.md](docs/github-actions-guide.md)
- Read [docs/GITHUB-ACTIONS-ADVANCED.md](docs/GITHUB-ACTIONS-ADVANCED.md)
