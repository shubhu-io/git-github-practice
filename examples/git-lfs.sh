#!/bin/bash
# Git LFS Practice Script
# This script helps you practice Git Large File Storage

echo "=== Git LFS Practice ==="
echo ""

# Create a practice directory
PRACTICE_DIR="git-lfs-practice"
rm -rf $PRACTICE_DIR
mkdir -p $PRACTICE_DIR
cd $PRACTICE_DIR

# Initialize a new repository
git init
echo "Created a new Git repository"
echo ""

# Check if Git LFS is installed
echo "=== Checking Git LFS Installation ==="
if command -v git-lfs &> /dev/null; then
    echo "Git LFS is installed"
else
    echo "Git LFS is not installed"
    echo "Install with: brew install git-lfs (macOS)"
    echo "             sudo apt-get install git-lfs (Linux)"
    echo "             Download from https://git-lfs.github.com/"
    echo ""
    echo "Continuing with demonstration only..."
fi
echo ""

# Install Git LFS
echo "=== Installing Git LFS ==="
git lfs install
echo ""

# Track file patterns
echo "=== Tracking File Patterns ==="
echo "Common patterns to track:"
echo "  git lfs track \"*.psd\"        # Photoshop files"
echo "  git lfs track \"*.zip\"        # Zip archives"
echo "  git lfs track \"*.mp4\"        # Video files"
echo "  git lfs track \"*.bin\"        # Binary files"
echo "  git lfs track \"models/*\"     # Entire directory"
echo ""

# Track specific patterns
git lfs track "*.psd"
git lfs track "*.zip"
git lfs track "*.mp4"
echo ""

# Show .gitattributes
echo "=== .gitattributes Content ==="
cat .gitattributes
echo ""

# Create sample large files (simulated)
echo "=== Creating Sample Files ==="
echo "Creating simulated large files..."
echo "This is a simulated PSD file" > sample.psd
echo "This is a simulated ZIP file" > archive.zip
echo "This is a simulated MP4 file" > video.mp4
echo "This is a regular text file" > readme.txt
echo ""

# Show file status
echo "=== File Status ==="
git status
echo ""

# Stage and commit
echo "=== Staging and Committing ==="
git add .
git commit -m "feat: add files with LFS tracking"
echo ""

# Show LFS tracked files
echo "=== LFS Tracked Files ==="
git lfs ls-files
echo ""

# Show LFS status
echo "=== LFS Status ==="
git lfs status
echo ""

# Common LFS commands
echo "=== Common LFS Commands ==="
echo ""
echo "Track files:"
echo "  git lfs track \"*.pattern\""
echo ""
echo "Show tracked patterns:"
echo "  git lfs track"
echo ""
echo "List LFS files:"
echo "  git lfs ls-files"
echo ""
echo "Show LFS status:"
echo "  git lfs status"
echo ""
echo "Pull LFS files:"
echo "  git lfs pull"
echo ""
echo "Push LFS files:"
echo "  git lfs push origin main"
echo ""
echo "Migrate existing files to LFS:"
echo "  git lfs migrate import --include=\"*.psd\" --everything"
echo ""

# Clean up
echo "=== Cleaning Up ==="
cd ..
rm -rf $PRACTICE_DIR
echo "Practice directory cleaned up."
echo ""

echo "=== Git LFS Practice Complete ==="
echo "You've learned:"
echo "  - How to install Git LFS"
echo "  - How to track file patterns"
echo "  - How to view LFS tracked files"
echo "  - Common LFS commands"
echo ""
echo "When to use Git LFS:"
echo "  - Large binary files (PSD, ZIP, MP4)"
echo "  - Game assets"
echo "  - Machine learning models"
echo "  - Any file > 1MB that changes frequently"
