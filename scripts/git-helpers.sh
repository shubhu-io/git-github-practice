#!/bin/bash
# Git Helper Functions
# Source this file to add helper functions to your shell
# Usage: source git-helpers.sh

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function: Create a new feature branch
# Usage: new-feature <branch-name>
new-feature() {
    if [ -z "$1" ]; then
        echo -e "${RED}Error: Please provide a branch name${NC}"
        echo "Usage: new-feature <branch-name>"
        return 1
    fi
    
    git checkout main
    git pull origin main
    git checkout -b "feature/$1"
    echo -e "${GREEN}Created and switched to feature/$1${NC}"
}

# Function: Create a new bugfix branch
# Usage: new-bugfix <branch-name>
new-bugfix() {
    if [ -z "$1" ]; then
        echo -e "${RED}Error: Please provide a branch name${NC}"
        echo "Usage: new-bugfix <branch-name>"
        return 1
    fi
    
    git checkout main
    git pull origin main
    git checkout -b "bugfix/$1"
    echo -e "${GREEN}Created and switched to bugfix/$1${NC}"
}

# Function: Create a new hotfix branch
# Usage: new-hotfix <branch-name>
new-hotfix() {
    if [ -z "$1" ]; then
        echo -e "${RED}Error: Please provide a branch name${NC}"
        echo "Usage: new-hotfix <branch-name>"
        return 1
    fi
    
    git checkout main
    git checkout -b "hotfix/$1"
    echo -e "${GREEN}Created and switched to hotfix/$1${NC}"
}

# Function: Quick commit with conventional commit format
# Usage: qc <type> <message>
# Example: qc feat "add login page"
qc() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo -e "${RED}Error: Please provide type and message${NC}"
        echo "Usage: qc <type> <message>"
        echo "Types: feat, fix, docs, style, refactor, test, chore"
        return 1
    fi
    
    git add -A
    git commit -m "$1: $2"
    echo -e "${GREEN}Committed with message: $1: $2${NC}"
}

# Function: Show pretty log
# Usage: pretty-log
pretty-log() {
    git log --pretty=format:'%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]' --decorate --numstat
}

# Function: Show short log
# Usage: short-log
short-log() {
    git log --oneline -10
}

# Function: Find large files in history
# Usage: large-files
large-files() {
    echo -e "${YELLOW}Finding large files in Git history...${NC}"
    git rev-list --objects --all | \
        git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | \
        sed -n 's/^blob //p' | sort -rnk2 | head -20
}

# Function: Show repository statistics
# Usage: git-stats
git-stats() {
    echo -e "${BLUE}=== Repository Statistics ===${NC}"
    echo ""
    echo -e "${YELLOW}Total commits:${NC} $(git rev-list --all --count)"
    echo -e "${YELLOW}Contributors:${NC} $(git shortlog -sn --all | wc -l)"
    echo -e "${YELLOW}Branches:${NC} $(git branch -a | wc -l)"
    echo -e "${YELLOW}Tags:${NC} $(git tag | wc -l)"
    echo ""
    echo -e "${YELLOW}Top 5 contributors:${NC}"
    git shortlog -sn --all | head -5
}

# Function: Clean up merged branches
# Usage: cleanup-branches
cleanup-branches() {
    echo -e "${YELLOW}Cleaning up merged branches...${NC}"
    git branch --merged | grep -v '\*\|main\|master' | xargs -n 1 git branch -d
    echo -e "${GREEN}Cleanup complete!${NC}"
}

# Function: Sync with upstream
# Usage: sync-upstream
sync-upstream() {
    echo -e "${YELLOW}Syncing with upstream...${NC}"
    git fetch upstream
    git checkout main
    git merge upstream/main
    git push origin main
    echo -e "${GREEN}Sync complete!${NC}"
}

# Function: Create a release
# Usage: create-release <version>
create-release() {
    if [ -z "$1" ]; then
        echo -e "${RED}Error: Please provide a version number${NC}"
        echo "Usage: create-release <version>"
        echo "Example: create-release 1.0.0"
        return 1
    fi
    
    echo -e "${YELLOW}Creating release v$1...${NC}"
    git checkout main
    git pull origin main
    git tag -a "v$1" -m "Release version $1"
    git push origin "v$1"
    echo -e "${GREEN}Release v$1 created and pushed!${NC}"
}

# Function: Show help
# Usage: git-helpers-help
git-helpers-help() {
    echo -e "${BLUE}=== Git Helper Functions ===${NC}"
    echo ""
    echo -e "${YELLOW}Branch Functions:${NC}"
    echo "  new-feature <name>   - Create and switch to a new feature branch"
    echo "  new-bugfix <name>    - Create and switch to a new bugfix branch"
    echo "  new-hotfix <name>    - Create and switch to a new hotfix branch"
    echo ""
    echo -e "${YELLOW}Commit Functions:${NC}"
    echo "  qc <type> <message>  - Quick commit with conventional format"
    echo ""
    echo -e "${YELLOW}View Functions:${NC}"
    echo "  pretty-log           - Show pretty formatted log"
    echo "  short-log            - Show last 10 commits"
    echo "  large-files          - Find large files in history"
    echo "  git-stats            - Show repository statistics"
    echo ""
    echo -e "${YELLOW}Utility Functions:${NC}"
    echo "  cleanup-branches     - Delete merged branches"
    echo "  sync-upstream        - Sync with upstream repository"
    echo "  create-release <v>   - Create and push a release tag"
    echo ""
    echo -e "${YELLOW}Usage:${NC}"
    echo "  Source this file: source git-helpers.sh"
    echo "  Then call functions: new-feature my-feature"
}

echo -e "${GREEN}Git Helper Functions loaded!${NC}"
echo "Type 'git-helpers-help' to see available functions"
