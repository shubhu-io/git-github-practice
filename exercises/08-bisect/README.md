# Exercise 8: Git Bisect

## Objective
Learn to use git bisect to find the commit that introduced a bug.

## Instructions

### Step 1: Set Up the Scenario
```bash
# Create multiple commits
git checkout main
for i in $(seq 1 10); do
  echo "commit $i" > file.txt
  git add file.txt
  git commit -m "commit $i"
done
```

### Step 2: Start Bisect
```bash
git bisect start
```

### Step 3: Mark Current Commit as Bad
```bash
git bisect bad
```

### Step 4: Mark an Older Commit as Good
```bash
git bisect good <commit-hash-of-first-commit>
```

### Step 5: Test Each Commit
Git will checkout the middle commit. Test it:
```bash
cat file.txt
```

### Step 6: Mark as Good or Bad
```bash
# If the commit is good
git bisect good

# If the commit is bad
git bisect bad
```

### Step 7: Repeat Until Found
Git will continue checking until it finds the exact commit.

### Step 8: Reset Bisect
```bash
git bisect reset
```

## Challenge

1. Create 20 commits with one "buggy" commit
2. Use bisect to find it
3. Use a script to automate bisecting

## Advanced: Automated Bisect

```bash
# Create a test script
cat > test.sh << 'EOF'
#!/bin/bash
# Return 0 if good, 1 if bad
grep -q "buggy" file.txt
EOF
chmod +x test.sh

# Use with bisect
git bisect start
git bisect bad HEAD
git bisect good <good-commit>
git bisect run ./test.sh
```

## Next Steps

- Practice with real-world scenarios
- Learn about git bisect visualize
- Explore other debugging tools
