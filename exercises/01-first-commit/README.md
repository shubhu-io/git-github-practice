# Exercise 1: First Commit

## Objective
Create a Git repository and make your first commit.

## Instructions

### Step 1: Create a Directory
```bash
mkdir my-first-repo
cd my-first-repo
```

### Step 2: Initialize Git Repository
```bash
git init
```

You should see output like:
```
Initialized empty Git repository in /path/to/my-first-repo/.git/
```

### Step 3: Create a File
```bash
echo "# My First Repository" > README.md
echo "This is my first Git repository!" >> README.md
```

### Step 4: Check Status
```bash
git status
```

You should see `README.md` listed as an untracked file.

### Step 5: Stage the File
```bash
git add README.md
```

### Step 6: Verify Staging
```bash
git status
```

You should see `README.md` listed as a new file to be committed.

### Step 7: Commit the File
```bash
git commit -m "feat: initial commit with README"
```

### Step 8: View Your Commit
```bash
git log
```

## Verification

Run these commands to verify your work:
```bash
# Check you're in a Git repository
git rev-parse --git-dir

# Check commit exists
git log --oneline

# Check files are tracked
git ls-files
```

## Expected Output

After completing all steps, you should have:
- A `.git` directory
- A `README.md` file
- One commit in your history

## Next Steps

Once you've completed this exercise:
1. Try creating more files and committing them
2. Practice with `git status` to see changes
3. Move on to Exercise 2: Multiple Files
