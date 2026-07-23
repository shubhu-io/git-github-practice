---
layout: single
title: "GitHub Pages"
---

# GitHub Pages

Host static websites directly from a GitHub repository.

## Setup

### Via Web
```
Repo → Settings → Pages
  Source: Deploy from a branch
  Branch: main (root or /docs)
  - or -
  Source: GitHub Actions
```

### Via gh CLI
```bash
gh api repos/:owner/:repo/pages -X POST \
  -f source[branch]=main \
  -f source[path]=/docs
```

## Configuration

### _config.yml (Jekyll)
```yaml
title: My Site
description: Site description
url: https://username.github.io
baseurl: /repo-name    # Only for project pages
theme: minima
```

### Custom Domain
```
Settings → Pages → Custom domain
  Enter: example.com
  DNS: CNAME username.github.io (or A records)

# or via CLI:
gh api repos/:owner/:repo/pages -X PUT \
  -f cname=example.com
```

### Enforce HTTPS
```
Settings → Pages → Enforce HTTPS
```

## Build & Deploy

### GitHub Actions Deployment

```yaml
name: Deploy to Pages
on:
  push:
    branches: [main]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

jobs:
  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/configure-pages@v5
      - uses: actions/upload-pages-artifact@v3
        with:
          path: .
      - id: deployment
        uses: actions/deploy-pages@v4
```

## Jekyll Theme Support

```yaml
# _config.yml
remote_theme: pages-themes/cayman@v0.2.0
plugins:
  - jekyll-remote-theme
```

Or use any gem-based theme:
```yaml
theme: jekyll-theme-cayman
```

## Static Site Generators

Any static site generator works with Pages:

| Generator | Build command | Output dir |
|---|---|---|
| Jekyll (default) | `jekyll build` | `_site` |
| Hugo | `hugo` | `public` |
| Next.js | `next build && next export` | `out` |
| Astro | `astro build` | `dist` |
| 11ty | `npx @11ty/eleventy` | `_site` |

## Custom 404

```html
<!-- 404.html in repo root -->
---
permalink: /404.html
---
<h1>404 — Page not found</h1>
<a href="/">Go home</a>
```

## Limitations

- **Repositories**: 1 GB max (soft limit)
- **Builds**: 10 builds/hour
- **Bandwidth**: 100 GB/month (soft)
- **Pages**: 1 GB max per site
- **No server-side code**: PHP, Ruby, Python not supported
- **No custom headers**: Except CNAME
