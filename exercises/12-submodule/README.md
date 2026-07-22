# Exercise 12: Git Submodule

## Objective
Learn to use Git submodules for managing external dependencies.

## Instructions

### Step 1: Create External Repository

```bash
mkdir external-lib
cd external-lib
git init
echo "# External Library" > README.md
echo "function helper() {}" > lib.js
git add .
git commit -m "feat: initial release"
cd ..
```

### Step 2: Add as Submodule

```bash
git submodule add ./external-lib libs/external-lib
```

### Step 3: Check Submodule Status

```bash
git submodule status
```

### Step 4: Update Submodule

```bash
cd libs/external-lib
echo "function newHelper() {}" >> lib.js
git add .
git commit -m "feat: add new helper"
cd ../..

# Update reference
git add libs/external-lib
git commit -m "chore: update submodule"
```

### Step 5: Clone with Submodules

```bash
git clone --recursive <repo-url>
# OR
git submodule init
git submodule update
```

## Challenge

1. Create a main project with 2 submodules
2. Update both submodules
3. Remove a submodule

## Key Commands

```bash
git submodule add <url> <path>      # Add submodule
git submodule update --remote       # Update submodules
git submodule deinit <path>         # Remove submodule
git submodule foreach git pull      # Update all submodules
```

## Next Steps

- Practice with the `examples/submodule.sh` script
- Read about Git subtrees as an alternative
