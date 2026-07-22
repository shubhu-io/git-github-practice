#!/bin/bash
# Git Collaboration Practice Script
# Practice collaborating with others using Git

echo "=== Git Collaboration Practice ==="
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Create practice directory
PRACTICE_DIR="git-collaboration-practice"
rm -rf $PRACTICE_DIR
mkdir -p $PRACTICE_DIR
cd $PRACTICE_DIR

echo -e "${YELLOW}Setting up collaboration scenario...${NC}"
echo ""

# Step 1: Create "original" repository (simulates GitHub)
echo "Step 1: Creating original repository (simulates GitHub)..."
mkdir original-repo
cd original-repo
git init --bare
cd ..
echo -e "${GREEN}Created bare repository${NC}"
echo ""

# Step 2: Clone and set up as "Alice"
echo "Step 2: Alice clones the repository..."
git clone original-repo alice-repo
cd alice-repo
git config user.name "Alice"
git config user.email "alice@example.com"

# Alice creates initial code
echo "# Collaboration Project" > README.md
echo "function hello() { return 'Hello'; }" > utils.js
git add .
git commit -m "feat: initial project setup"
git push origin main
echo -e "${GREEN}Alice pushed initial code${NC}"
echo ""

# Step 3: Clone as "Bob"
echo "Step 3: Bob clones the repository..."
cd ..
git clone original-repo bob-repo
cd bob-repo
git config user.name "Bob"
git config user.email "bob@example.com"
echo -e "${GREEN}Bob cloned the repository${NC}"
echo ""

# Step 4: Alice makes changes
echo "Step 4: Alice adds a new feature..."
cd ../alice-repo
echo "function world() { return 'World'; }" >> utils.js
echo "exports.world = world;" >> utils.js
git add utils.js
git commit -m "feat: add world function"
git push origin main
echo -e "${GREEN}Alice pushed new feature${NC}"
echo ""

# Step 5: Bob makes changes
echo "Step 5: Bob adds a different feature..."
cd ../bob-repo
echo "function greet(name) { return 'Hello ' + name; }" > greet.js
git add greet.js
git commit -m "feat: add greet function"
git push origin main
echo -e "${GREEN}Bob pushed his feature${NC}"
echo ""

# Step 6: Alice pulls Bob's changes
echo "Step 6: Alice pulls Bob's changes..."
cd ../alice-repo
git pull origin main
echo -e "${GREEN}Alice pulled Bob's changes${NC}"
echo ""

# Step 7: Bob pulls Alice's changes
echo "Step 7: Bob pulls Alice's changes..."
cd ../bob-repo
git pull origin main
echo -e "${GREEN}Bob pulled Alice's changes${NC}"
echo ""

# Step 8: Show final state
echo "Step 8: Final state..."
echo ""
echo -e "${YELLOW}Final files:${NC}"
ls -la
echo ""
echo -e "${YELLOW}Git log:${NC}"
git log --oneline --graph --all
echo ""

# Practice scenarios
echo -e "${YELLOW}=== Practice Scenarios ===${NC}"
echo ""

echo "Scenario 1: Create a feature branch"
echo "  git checkout -b feature/add-tests"
echo "  # Make changes, commit, push"
echo "  git push -u origin feature/add-tests"
echo "  # Create PR on GitHub"
echo ""

echo "Scenario 2: Review and merge PR"
echo "  # On GitHub, review the PR"
echo "  # After approval, merge it"
echo "  git checkout main"
echo "  git pull origin main"
echo ""

echo "Scenario 3: Handle merge conflict"
echo "  # Both make changes to same file"
echo "  # Try to merge - conflict occurs!"
echo "  # Resolve conflict, commit, push"
echo ""

echo "Scenario 4: Revert a bad commit"
echo "  git revert <bad-commit-hash>"
echo "  git push origin main"
echo ""

# Clean up
cd ..
rm -rf $PRACTICE_DIR
echo -e "${GREEN}Practice directory cleaned up.${NC}"
echo ""

echo -e "${GREEN}=== Collaboration Practice Complete ===${NC}"
echo "You've learned:"
echo "  - How to clone repositories"
echo "  - How to work with remotes"
echo "  - How to push and pull changes"
echo "  - How to handle merge conflicts"
echo "  - The collaboration workflow"
echo ""
echo "Next steps:"
echo "  1. Try forking a real open source project"
echo "  2. Create a pull request"
echo "  3. Review someone else's PR"
echo "  4. Set up branch protection rules"
