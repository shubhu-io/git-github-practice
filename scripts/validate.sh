#!/bin/bash
# Validation Script
# Runs all checks to validate the project

echo "=== Project Validation ==="
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

ERRORS=0

# Function: Check if command exists
check_command() {
    if ! command -v $1 &> /dev/null; then
        echo -e "${RED}Error: $1 is not installed${NC}"
        return 1
    fi
    return 0
}

# Function: Run check
run_check() {
    local name=$1
    local command=$2
    
    echo -e "${YELLOW}Running: $name${NC}"
    eval $command
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ $name passed${NC}"
    else
        echo -e "${RED}✗ $name failed${NC}"
        ERRORS=$((ERRORS + 1))
    fi
    echo ""
}

# Step 1: Check prerequisites
echo "Step 1: Checking prerequisites..."
check_command "node" || exit 1
check_command "npm" || exit 1
check_command "git" || exit 1
echo -e "${GREEN}All prerequisites installed${NC}"
echo ""

# Step 2: Check Node.js version
echo "Step 2: Checking Node.js version..."
NODE_VERSION=$(node --version | cut -d'v' -f2 | cut -d'.' -f1)
if [ $NODE_VERSION -lt 18 ]; then
    echo -e "${RED}Error: Node.js 18 or higher is required${NC}"
    ERRORS=$((ERRORS + 1))
else
    echo -e "${GREEN}Node.js version: $(node --version)${NC}"
fi
echo ""

# Step 3: Check npm version
echo "Step 3: Checking npm version..."
echo -e "${GREEN}npm version: $(npm --version)${NC}"
echo ""

# Step 4: Install dependencies
echo "Step 4: Installing dependencies..."
npm install --ignore-scripts
if [ $? -ne 0 ]; then
    echo -e "${RED}Error: Failed to install dependencies${NC}"
    ERRORS=$((ERRORS + 1))
else
    echo -e "${GREEN}Dependencies installed${NC}"
fi
echo ""

# Step 5: Run linter
echo "Step 5: Running linter..."
if [ -f "package.json" ] && grep -q '"lint"' package.json; then
    run_check "Linting" "npm run lint"
else
    echo -e "${YELLOW}Skipping: No lint script found${NC}"
    echo ""
fi

# Step 6: Run formatter check
echo "Step 6: Running formatter check..."
if [ -f "package.json" ] && grep -q '"format:check"' package.json; then
    run_check "Format check" "npm run format:check"
else
    echo -e "${YELLOW}Skipping: No format:check script found${NC}"
    echo ""
fi

# Step 7: Run tests
echo "Step 7: Running tests..."
if [ -f "package.json" ] && grep -q '"test"' package.json; then
    run_check "Tests" "npm test"
else
    echo -e "${YELLOW}Skipping: No test script found${NC}"
    echo ""
fi

# Step 8: Check Git status
echo "Step 8: Checking Git status..."
if git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${GREEN}Git repository detected${NC}"
    if [ -n "$(git status --porcelain)" ]; then
        echo -e "${YELLOW}Warning: Uncommitted changes detected${NC}"
    else
        echo -e "${GREEN}Working directory clean${NC}"
    fi
else
    echo -e "${YELLOW}Warning: Not a Git repository${NC}"
fi
echo ""

# Step 9: Check for required files
echo "Step 9: Checking required files..."
REQUIRED_FILES=(
    "README.md"
    "LICENSE"
    "package.json"
    ".gitignore"
    ".gitattributes"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo -e "${GREEN}✓ $file exists${NC}"
    else
        echo -e "${RED}✗ $file missing${NC}"
        ERRORS=$((ERRORS + 1))
    fi
done
echo ""

# Step 10: Check package.json validity
echo "Step 10: Checking package.json validity..."
if [ -f "package.json" ]; then
    node -e "require('./package.json')" 2>/dev/null
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}package.json is valid${NC}"
    else
        echo -e "${RED}package.json is invalid${NC}"
        ERRORS=$((ERRORS + 1))
    fi
else
    echo -e "${YELLOW}package.json not found${NC}"
fi
echo ""

# Summary
echo "=== Validation Summary ==="
echo ""
if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}All checks passed!${NC}"
    echo ""
    echo "Your project is ready for development."
else
    echo -e "${RED}$ERRORS check(s) failed${NC}"
    echo ""
    echo "Please fix the issues above before proceeding."
    exit 1
fi
