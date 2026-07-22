# GitHub Pages Guide

A complete guide to setting up and using GitHub Pages.

## What is GitHub Pages?

GitHub Pages is a free static site hosting service. It hosts your website directly from a GitHub repository.

## Getting Started

### Step 1: Create a Repository

```bash
# Create a new repository
gh repo create my-website --public

# Or use existing repository
```

### Step 2: Enable GitHub Pages

1. Go to your repository on GitHub
2. Click **Settings** > **Pages**
3. Select source branch (usually `main`)
4. Click **Save**

### Step 3: Create Your Site

```bash
# Create index.html
cat > index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>My GitHub Pages Site</title>
</head>
<body>
    <h1>Welcome to My Site!</h1>
    <p>This is hosted on GitHub Pages.</p>
</body>
</html>
EOF

# Commit and push
git add index.html
git commit -m "feat: initial site"
git push origin main
```

### Step 4: Access Your Site

Your site will be available at:
```
https://<username>.github.io/<repository>/
```

## Site Types

### User/Organization Site

- Repository name: `<username>.github.io`
- URL: `https://<username>.github.io/`
- Source: `main` branch

### Project Site

- Repository name: any name
- URL: `https://<username>.github.io/<repo>/`
- Source: `main` or `gh-pages` branch

## Using Jekyll

Jekyll is GitHub Pages' built-in static site generator.

### Basic Jekyll Setup

```bash
# Create _config.yml
cat > _config.yml << 'EOF'
title: My Site
description: A GitHub Pages site
theme: minima
EOF

# Create index.md
cat > index.md << 'EOF'
---
layout: home
title: Home
---

# Welcome to My Site

This is a Jekyll site hosted on GitHub Pages.
EOF

# Create about.md
cat > about.md << 'EOF'
---
layout: page
title: About
---

# About

This site was built with Jekyll and GitHub Pages.
EOF

# Commit and push
git add .
git commit -m "feat: add Jekyll site"
git push origin main
```

### Jekyll Themes

```yaml
# _config.yml
theme: minima
# OR
remote_theme: pages-themes/cayman@v0.2.0
```

Popular themes:
- minima
- cayman
- minimal-mistakes
- just-the-docs

## Custom Domain

### Setting Up

1. Buy a domain (e.g., from Namecheap, Google Domains)
2. Go to **Settings** > **Pages**
3. Enter your custom domain
4. Click **Save**

### DNS Configuration

For apex domain (`example.com`):
```
Type: A
Name: @
Value: 185.199.108.153

Type: A
Name: @
Value: 185.199.109.153

Type: A
Name: @
Value: 185.199.110.153

Type: A
Name: @
Value: 185.199.111.153
```

For subdomain (`www.example.com`):
```
Type: CNAME
Name: www
Value: <username>.github.io
```

### Enable HTTPS

1. Go to **Settings** > **Pages**
2. Check **Enforce HTTPS**

## GitHub Actions for Pages

### Deploy with GitHub Actions

```yaml
# .github/workflows/deploy.yml
name: Deploy to GitHub Pages

on:
  push:
    branches: [ main ]

permissions:
  contents: read
  pages: write
  id-token: write

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
      - run: npm ci
      - run: npm run build
      - uses: actions/upload-pages-artifact@v2
        with:
          path: ./dist

  deploy:
    needs: build
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - id: deployment
        uses: actions/deploy-pages@v2
```

### Deploy Static Site

```yaml
# .github/workflows/deploy-static.yml
name: Deploy Static Site

on:
  push:
    branches: [ main ]

permissions:
  contents: read
  pages: write
  id-token: write

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Setup Pages
        uses: actions/configure-pages@v4
      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: '.'
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

## Common Issues

### Page Not Found (404)

1. Check source branch setting
2. Ensure `index.html` or `index.md` exists
3. Wait a few minutes for deployment
4. Check repository is public

### Custom Domain Not Working

1. Verify DNS settings
2. Wait for DNS propagation (up to 48 hours)
3. Check CNAME file in repository
4. Re-enable HTTPS after DNS changes

### Build Failures

1. Check GitHub Actions logs
2. Verify Jekyll configuration
3. Ensure all dependencies are listed
4. Test locally with `bundle exec jekyll serve`

## Local Development

### With Jekyll

```bash
# Install Jekyll
gem install bundler jekyll

# Create Gemfile
cat > Gemfile << 'EOF'
source "https://rubygems.org"
gem "github-pages", group: :jekyll_plugins
EOF

# Install dependencies
bundle install

# Serve locally
bundle exec jekyll serve

# Open http://localhost:4000
```

### With Node.js

```bash
# Install dependencies
npm install

# Serve locally
npx serve .

# Or with live reload
npx live-server --port=8080
```

## Best Practices

1. **Keep it simple** - Static sites load faster
2. **Optimize images** - Use WebP format
3. **Minify assets** - Reduce file sizes
4. **Use CDN** - GitHub Pages is already a CDN
5. **Add analytics** - Track visitor behavior
6. **Test locally** - Before pushing changes
7. **Use branches** - For different environments

## Examples

### Portfolio Site

```html
<!DOCTYPE html>
<html>
<head>
    <title>My Portfolio</title>
    <style>
        body { font-family: sans-serif; max-width: 800px; margin: 0 auto; }
        .project { border: 1px solid #ccc; padding: 1rem; margin: 1rem 0; }
    </style>
</head>
<body>
    <h1>My Portfolio</h1>
    <div class="project">
        <h2>Project 1</h2>
        <p>Description of project 1</p>
    </div>
    <div class="project">
        <h2>Project 2</h2>
        <p>Description of project 2</p>
    </div>
</body>
</html>
```

### Documentation Site

```markdown
---
layout: default
title: Documentation
---

# Documentation

## Getting Started

Follow these steps to get started...

## API Reference

### Method 1: `doSomething()`

Description of the method...

## Examples

```javascript
doSomething();
```
```

## Resources

- [GitHub Pages Documentation](https://docs.github.com/pages)
- [Jekyll Documentation](https://jekyllrb.com/docs/)
- [GitHub Pages Themes](https://pages.github.com/themes/)
