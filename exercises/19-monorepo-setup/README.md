# Advanced Exercise 19: Monorepo with Turborepo

## Objective
Set up a monorepo using Turborepo for multiple packages.

## Instructions

### Step 1: Initialize Turborepo

```bash
# Create new monorepo
npx create-turbo@latest my-monorepo
cd my-monorepo
```

### Step 2: Understand Structure

```
my-monorepo/
├── apps/
│   ├── web/           # Next.js app
│   └── docs/          # Documentation
├── packages/
│   ├── ui/            # Shared UI components
│   ├── config/        # Shared configuration
│   └── typescript/    # Shared TypeScript config
├── turbo.json
├── package.json
└── pnpm-workspace.yaml
```

### Step 3: Add a New Package

```bash
# Create new package
mkdir -p packages/utils/src
cd packages/utils

# Create package.json
cat > package.json << 'EOF'
{
  "name": "@my-monorepo/utils",
  "version": "0.0.1",
  "main": "./src/index.ts",
  "types": "./src/index.ts",
  "scripts": {
    "build": "tsc",
    "dev": "tsc --watch",
    "lint": "eslint src/",
    "test": "jest"
  },
  "devDependencies": {
    "typescript": "^5.0.0"
  }
}
EOF

# Create utility functions
cat > src/index.ts << 'EOF'
export function formatDate(date: Date): string {
  return date.toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  });
}

export function capitalize(str: string): string {
  return str.charAt(0).toUpperCase() + str.slice(1);
}

export function slugify(str: string): string {
  return str
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/(^-|-$)/g, '');
}
EOF
```

### Step 4: Use Package in App

```bash
# In apps/web
cd apps/web

# Install local package
pnpm add @my-monorepo/utils

# Use in code
cat > app/page.tsx << 'EOF'
import { formatDate, capitalize, slugify } from '@my-monorepo/utils';

export default function Home() {
  return (
    <div>
      <p>Formatted: {formatDate(new Date())}</p>
      <p>Capitalized: {capitalize('hello world')}</p>
      <p>Slugified: {slugify('Hello World!')}</p>
    </div>
  );
}
EOF
```

### Step 5: Run Tasks

```bash
# Build all packages
pnpm build

# Build specific package
pnpm turbo build --filter=@my-monorepo/utils

# Run tests
pnpm test

# Lint everything
pnpm lint
```

## Challenge

1. Add a new app that uses the shared packages
2. Set up task caching with Turborepo
3. Configure remote caching with Vercel

## Key Concepts

- Monorepos share code between packages
- Turborepo manages build pipelines
- Package dependencies are local
- Task caching speeds up builds

## Solution

<details>
<summary>Solution</summary>

```bash
# Add remote caching
pnpm turbo login
pnpm turbo link

# Check cache status
pnpm turbo run build --dry

# Filter packages
pnpm turbo build --filter='./packages/*'
pnpm turbo test --filter='@my-monorepo/*'

# Debug task graph
pnpm turbo build --graph=task-graph.html
```

</details>
