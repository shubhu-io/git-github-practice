#!/bin/bash
# Release Script
# Automates the release process

echo "=== Release Script ==="
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Check if version is provided
if [ -z "$1" ]; then
    echo -e "${RED}Error: Please provide a version number${NC}"
    echo "Usage: ./release.sh <version>"
    echo "Example: ./release.sh 1.0.0"
    exit 1
fi

VERSION=$1

# Validate version format
if ! [[ $VERSION =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo -e "${RED}Error: Invalid version format${NC}"
    echo "Please use semantic versioning (e.g., 1.0.0)"
    exit 1
fi

echo -e "${YELLOW}Preparing release v$VERSION${NC}"
echo ""

# Step 1: Check if on main branch
echo "Step 1: Checking branch..."
BRANCH=$(git branch --show-current)
if [ "$BRANCH" != "main" ]; then
    echo -e "${RED}Error: Not on main branch${NC}"
    echo "Please switch to main branch first"
    exit 1
fi
echo -e "${GREEN}On main branch${NC}"
echo ""

# Step 2: Check for uncommitted changes
echo "Step 2: Checking for uncommitted changes..."
if [ -n "$(git status --porcelain)" ]; then
    echo -e "${RED}Error: Uncommitted changes found${NC}"
    echo "Please commit or stash your changes first"
    exit 1
fi
echo -e "${GREEN}Working directory clean${NC}"
echo ""

# Step 3: Pull latest changes
echo "Step 3: Pulling latest changes..."
git pull origin main
echo ""

# Step 4: Run tests
echo "Step 4: Running tests..."
if [ -f "package.json" ]; then
    npm test
    if [ $? -ne 0 ]; then
        echo -e "${RED}Error: Tests failed${NC}"
        exit 1
    fi
fi
echo -e "${GREEN}Tests passed${NC}"
echo ""

# Step 5: Update version in package.json
echo "Step 5: Updating version in package.json..."
if [ -f "package.json" ]; then
    npm version $VERSION --no-git-tag-version
    echo -e "${GREEN}Version updated to $VERSION${NC}"
fi
echo ""

# Step 6: Update CHANGELOG.md
echo "Step 6: Updating CHANGELOG.md..."
if [ -f "CHANGELOG.md" ]; then
    DATE=$(date +%Y-%m-%d)
    sed -i "s/## \[Unreleased\]/## [Unreleased]\n\n## [$VERSION] - $DATE/" CHANGELOG.md
    echo -e "${GREEN}CHANGELOG.md updated${NC}"
fi
echo ""

# Step 7: Commit changes
echo "Step 7: Committing changes..."
git add .
git commit -m "chore: release v$VERSION"
echo ""

# Step 8: Create tag
echo "Step 8: Creating tag..."
git tag -a "v$VERSION" -m "Release version $VERSION"
echo -e "${GREEN}Tag v$VERSION created${NC}"
echo ""

# Step 9: Push changes
echo "Step 9: Pushing changes..."
git push origin main
git push origin "v$VERSION"
echo -e "${GREEN}Changes pushed to remote${NC}"
echo ""

# Step 10: Create GitHub Release
echo "Step 10: Creating GitHub Release..."
if command -v gh &> /dev/null; then
    gh release create "v$VERSION" \
        --title "Release v$VERSION" \
        --generate-notes
    echo -e "${GREEN}GitHub Release created${NC}"
else
    echo -e "${YELLOW}GitHub CLI not found. Please create release manually.${NC}"
fi
echo ""

echo -e "${GREEN}Release v$VERSION completed successfully!${NC}"
echo ""
echo "Summary:"
echo "  - Version: $VERSION"
echo "  - Tag: v$VERSION"
echo "  - Branch: main"
echo "  - Changes committed and pushed"
echo ""
