---
title: Exercise Solutions
---
# Git Exercises

Structured exercises to practice Git concepts.

## Exercise Levels

- **Beginner**: Basic commands and workflows
- **Intermediate**: Branching, merging, and collaboration
- **Advanced**: Complex scenarios and debugging

---

## Beginner Exercises

### Exercise 1: First Commit

**Goal**: Create a repository and make your first commit.

**Tasks**:
1. Create a new directory called `my-first-repo`
2. Initialize a Git repository
3. Create a file called `README.md`
4. Add the file to staging
5. Commit with message "feat: initial commit"

**Solution**:
```bash
mkdir my-first-repo
cd my-first-repo
git init
echo "# My First Repo" > README.md
git add README.md
git commit -m "feat: initial commit"
```

**Verify**: Run `git log` to see your commit.

---

### Exercise 2: Multiple Files

**Goal**: Practice staging and committing multiple files.

**Tasks**:
1. Create `index.html` with basic HTML structure
2. Create `style.css` with a simple style
3. Stage both files
4. Commit with message "feat: add HTML and CSS"

**Solution**:
```bash
cat > index.html << 'EOF'
<!DOCTYPE html>
<html>
<head><title>My Site</title></head>
<body><h1>Hello World</h1></body>
</html>
EOF

cat > style.css << 'EOF'
h1 { color: blue; }
EOF

git add index.html style.css
git commit -m "feat: add HTML and CSS"
```

---

### Exercise 3: Commit History

**Goal**: Understand commit history.

**Tasks**:
1. View commit history with `git log`
2. View compact history with `git log --oneline`
3. View visual history with `git log --oneline --graph`

**Solution**:
```bash
git log
git log --oneline
git log --oneline --graph --all
```

---

## Intermediate Exercises

### Exercise 4: Branching

**Goal**: Create and switch between branches.

**Tasks**:
1. Create a new branch called `feature/login`
2. Switch to the new branch
3. Create a file `login.html`
4. Commit the file
5. Switch back to `main`
6. Verify `login.html` doesn't exist on main

**Solution**:
```bash
git checkout -b feature/login
echo "<h1>Login Page</h1>" > login.html
git add login.html
git commit -m "feat: add login page"
git checkout main
ls login.html  # Should not exist
```

---

### Exercise 5: Merging

**Goal**: Merge branches together.

**Tasks**:
1. Switch to `feature/login`
2. Merge into `main`
3. Verify `login.html` now exists on main

**Solution**:
```bash
git checkout feature/login
git checkout main
git merge feature/login
ls login.html  # Should exist
```

---

### Exercise 6: Merge Conflicts

**Goal**: Create and resolve a merge conflict.

**Tasks**:
1. Create a branch `feature/header`
2. Modify `README.md` on both main and feature/header
3. Merge and observe conflict
4. Resolve the conflict
5. Complete the merge

**Solution**:
```bash
# On main
echo "Main content" > README.md
git add README.md
git commit -m "feat: update README on main"

# On feature
git checkout -b feature/header
echo "Feature content" > README.md
git add README.md
git commit -m "feat: update README on feature"

# Merge (will conflict)
git checkout main
git merge feature/header

# Resolve conflict in README.md
# Choose which content to keep or combine
git add README.md
git commit -m "fix: resolve merge conflict"
```

---

### Exercise 7: Stashing

**Goal**: Practice stashing changes.

**Tasks**:
1. Make some changes but don't commit
2. Stash the changes
3. Verify working directory is clean
4. Apply the stash

**Solution**:
```bash
echo "WIP: feature work" >> feature.txt
git stash save "WIP: feature work"
git status  # Clean
git stash pop
```

---

## Advanced Exercises

### Exercise 8: Rebase

**Goal**: Practice rebasing.

**Tasks**:
1. Create a feature branch
2. Make multiple commits
3. Rebase onto main
4. Verify linear history

**Solution**:
```bash
git checkout -b feature/awesome
echo "commit 1" > file1.txt
git add file1.txt && git commit -m "feat: add file1"
echo "commit 2" > file2.txt
git add file2.txt && git commit -m "feat: add file2"

git checkout main
echo "main change" >> README.md
git add README.md && git commit -m "feat: update README"

git checkout feature/awesome
git rebase main
git log --oneline --graph
```

---

### Exercise 9: Cherry-Pick

**Goal**: Apply specific commits from another branch.

**Tasks**:
1. Create two branches with different commits
2. Cherry-pick a specific commit
3. Verify the change

**Solution**:
```bash
# Create branch A with commits
git checkout -b feature/a
echo "A1" > a1.txt
git add a1.txt && git commit -m "feat: A1"
echo "A2" > a2.txt
git add a2.txt && git commit -m "feat: A2"

# Create branch B
git checkout main
git checkout -b feature/b

# Cherry-pick A1 only
git cherry-pick <commit-hash-of-A1>
```

---

### Exercise 10: Interactive Rebase

**Goal**: Squash commits using interactive rebase.

**Tasks**:
1. Create a branch with 3 commits
2. Use interactive rebase to squash the last 2 commits
3. Verify the result

**Solution**:
```bash
git checkout -b feature/squash
echo "1" > file1.txt && git add file1.txt && git commit -m "1"
echo "2" > file2.txt && git add file2.txt && git commit -m "2"
echo "3" > file3.txt && git add file3.txt && git commit -m "3"

# Interactive rebase (non-interactive for automation)
git reset --soft HEAD~2
git commit -m "feat: combine 2 and 3"
```

---

### Exercise 11: Git Bisect

**Goal**: Find the commit that introduced a bug.

**Tasks**:
1. Create multiple commits
2. Mark one commit as "bad"
3. Use bisect to find it

**Solution**:
```bash
# Create commits with one "bad" commit
git checkout -b feature/test
for i in $(seq 1 10); do
  echo "commit $i" > file.txt
  git add file.txt
  if [ $i -eq 5 ]; then
    git commit -m "feat: commit $i (BAD)"
  else
    git commit -m "feat: commit $i"
  fi
done

# Use bisect
git bisect start
git bisect bad  # Current is bad
git bisect good main  # First commit is good
# Test each commit, mark good/bad
git bisect reset
```

---

## Exercise Tracking

Use this checklist to track your progress:

- [ ] Exercise 1: First Commit
- [ ] Exercise 2: Multiple Files
- [ ] Exercise 3: Commit History
- [ ] Exercise 4: Branching
- [ ] Exercise 5: Merging
- [ ] Exercise 6: Merge Conflicts
- [ ] Exercise 7: Stashing
- [ ] Exercise 8: Rebase
- [ ] Exercise 9: Cherry-Pick
- [ ] Exercise 10: Interactive Rebase
- [ ] Exercise 11: Git Bisect

## Next Steps

After completing these exercises:
1. Practice with the example scripts in `examples/`
2. Read the documentation in `docs/`
3. Contribute to open source projects
4. Set up your own GitHub workflow
