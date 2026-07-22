# Exercise 13: Real Project Workflow

## Objective
Practice a complete real-world Git workflow from start to finish.

## Scenario

You're working on a team project. Complete these tasks in order.

## Tasks

### Task 1: Setup

1. Fork this repository on GitHub
2. Clone your fork
3. Set up upstream remote

```bash
git clone https://github.com/YOUR-USERNAME/git-github-practice.git
cd git-github-practice
git remote add upstream https://github.com/original-owner/git-github-practice.git
```

### Task 2: Create Feature Branch

```bash
git checkout main
git pull upstream main
git checkout -b feature/add-calculator
```

### Task 3: Add Calculator Code

Create a file `src/calculator.js`:

```javascript
function add(a, b) {
  return a + b;
}

function subtract(a, b) {
  return a - b;
}

function multiply(a, b) {
  return a * b;
}

function divide(a, b) {
  if (b === 0) {
    throw new Error('Cannot divide by zero');
  }
  return a / b;
}

module.exports = { add, subtract, multiply, divide };
```

### Task 4: Add Tests

Create a file `tests/calculator.test.js`:

```javascript
const { add, subtract, multiply, divide } = require('../src/calculator');

describe('Calculator', () => {
  test('add adds two numbers', () => {
    expect(add(2, 3)).toBe(5);
  });

  test('subtract subtracts two numbers', () => {
    expect(subtract(5, 3)).toBe(2);
  });

  test('multiply multiplies two numbers', () => {
    expect(add(2, 3)).toBe(5);
  });

  test('divide divides two numbers', () => {
    expect(divide(6, 3)).toBe(2);
  });

  test('divide throws on zero', () => {
    expect(() => divide(1, 0)).toThrow('Cannot divide by zero');
  });
});
```

### Task 5: Commit Changes

```bash
git add src/calculator.js tests/calculator.test.js
git commit -m "feat: add calculator with tests"
```

### Task 6: Push and Create PR

```bash
git push origin feature/add-calculator
```

Create PR on GitHub with description.

### Task 7: Code Review (Simulated)

Review your own PR:
1. Check the diff
2. Verify tests pass
3. Approve the PR

### Task 8: Merge

Merge the PR on GitHub.

### Task 9: Clean Up

```bash
git checkout main
git pull upstream main
git branch -d feature/add-calculator
git push origin --delete feature/add-calculator  # Delete remote branch
```

### Task 10: Update Fork

```bash
git fetch upstream
git checkout main
git merge upstream/main
git push origin main
```

## Verification

After completing all tasks:
1. Check that `src/calculator.js` exists on main
2. Check that `tests/calculator.test.js` exists on main
3. Verify your fork is up to date with upstream

## Bonus Challenges

1. Add more calculator functions (power, square root)
2. Add more tests
3. Update README.md with usage examples
4. Create a GitHub Actions workflow for testing

## Learning Points

- Complete fork-based workflow
- Feature branch workflow
- Pull request process
- Code review
- Merge and clean up
- Keeping fork in sync

## Next Steps

- Contribute to a real open source project
- Set up branch protection rules
- Configure CI/CD pipelines
