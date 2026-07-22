# Exercise 11: Git Bisect

## Objective
Learn to use git bisect to find the commit that introduced a bug.

## Instructions

### Step 1: Create Multiple Commits

```bash
for i in $(seq 1 10); do
  echo "commit $i" > file.txt
  git add file.txt
  git commit -m "commit $i"
done
```

### Step 2: Start Bisect

```bash
git bisect start
git bisect bad HEAD
git bisect good <first-commit-hash>
```

### Step 3: Test Each Commit

```bash
# Git checks out middle commit
cat file.txt
# Test if it's good or bad
git bisect good  # or git bisect bad
```

### Step 4: Reset Bisect

```bash
git bisect reset
```

## Automated Bisect

### Create Test Script

```bash
cat > test.sh << 'EOF'
#!/bin/bash
grep -q "commit 5" file.txt
EOF
chmod +x test.sh
```

### Run Automated Bisect

```bash
git bisect start
git bisect bad HEAD
git bisect good <first-commit-hash>
git bisect run ./test.sh
```

## Challenge

1. Create 20 commits with one "buggy" commit
2. Use manual bisect to find it
3. Use automated bisect with a script

## Key Concepts

- **Binary Search** - Bisect uses binary search to find the bug
- **Good/Bad Markers** - You mark commits as working or not
- **Automation** - Use `git bisect run` with a test script

## Next Steps

- Exercise 12: Git Submodule
- Practice with the `examples/bisect.sh` script
