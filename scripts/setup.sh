#!/bin/bash
# Setup script for the project

echo "Setting up Git & GitHub Practice Repository..."

# Initialize git if not already
if [ ! -d ".git" ]; then
    git init
    echo "Git repository initialized."
fi

# Install dependencies if package.json exists
if [ -f "package.json" ]; then
    npm install
    echo "Dependencies installed."
fi

echo "Setup complete!"
echo "Run 'git remote add origin <your-repo-url>' to connect to GitHub."
