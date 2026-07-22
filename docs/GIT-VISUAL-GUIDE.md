---
title: Git Visual Guide
---
# Git Visual Guide

Visual representations of Git concepts.

## Git Areas

```
┌─────────────────────────────────────────────────────────────┐
│                     YOUR COMPUTER                           │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌─────────────────┐      ┌─────────────────┐              │
│  │  WORKING        │      │   STAGING       │              │
│  │  DIRECTORY      │ ───► │   AREA          │              │
│  │                 │ git  │   (Index)       │              │
│  │  (Your files)   │ add  │                 │              │
│  └─────────────────┘      └────────┬────────┘              │
│                                    │                       │
│                                    │ git commit            │
│                                    ▼                       │
│                           ┌─────────────────┐              │
│                           │   REPOSITORY    │              │
│                           │   (.git)        │              │
│                           │                 │              │
│                           │  (All history)  │              │
│                           └─────────────────┘              │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## Branching

```
        main
         │
         ▼
    ┌─────────┐
    │   A     │
    └────┬────┘
         │
         ├──────────────────────► feature/login
         │                            │
         ▼                            ▼
    ┌─────────┐                 ┌─────────┐
    │   B     │                 │   C     │
    └────┬────┘                 └────┬────┘
         │                          │
         │                          │
         ▼                          ▼
    ┌─────────┐                 ┌─────────┐
    │   D     │                 │   E     │
    └─────────┘                 └────┬────┘
                                     │
                                     │ git merge
                                     ▼
                               ┌─────────┐
                               │   F     │  (Merge commit)
                               └─────────┘
```

## Merge vs Rebase

### Merge
```
Before merge:
    main    ──A──B──C
                 \
    feature       D──E

After merge:
    main    ──A──B──C───F (merge commit)
                 \     /
                  D──E
```

### Rebase
```
Before rebase:
    main    ──A──B──C
                 \
    feature       D──E

After rebase:
    main    ──A──B──C
                      \
    feature            D'──E'  (new commits)
```

## Commit History

```
    ┌─────────────────────────────────────────────────────┐
    │                    git log --oneline                 │
    ├─────────────────────────────────────────────────────┤
    │                                                     │
    │  abc1234 (HEAD -> main) feat: add login             │
    │  def5678 fix: resolve merge conflict                │
    │  ghi9012 feat: add user model                       │
    │  jkl3456 docs: update README                        │
    │  mno7890 feat: initial commit                       │
    │                                                     │
    └─────────────────────────────────────────────────────┘
```

## Stashing

```
    Before stash:
    ┌─────────────────┐
    │ Working Directory│  (Modified files)
    └────────┬────────┘
             │
             │ git stash
             ▼
    ┌─────────────────┐
    │   Stash Stack   │
    ├─────────────────┤
    │ stash@{0} WIP   │
    │ stash@{1} old   │
    └─────────────────┘

    After git stash pop:
    ┌─────────────────┐
    │ Working Directory│  (Restored files)
    └─────────────────┘
```

## Remote Operations

```
    LOCAL                           REMOTE (GitHub)
    ┌─────────────┐                 ┌─────────────┐
    │             │   git push      │             │
    │   local     │ ──────────────► │   origin    │
    │   repo      │                 │   repo      │
    │             │ ◄────────────── │             │
    │             │   git pull      │             │
    └─────────────┘                 └─────────────┘

    git fetch (download only):
    ┌─────────────┐                 ┌─────────────┐
    │             │ ◄────────────── │             │
    │             │   git fetch     │             │
    └─────────────┘                 └─────────────┘
```

## Cherry-Pick

```
    feature/login          main
         │                  │
         ▼                  ▼
    ┌─────────┐        ┌─────────┐
    │   A     │        │   A     │
    └────┬────┘        └────┬────┘
         │                  │
         ▼                  │
    ┌─────────┐             │
    │   B     │             │
    └────┬────┘             │
         │                  │
         ▼                  │
    ┌─────────┐             │
    │   C ◄───│─────────────│── git cherry-pick C
    └────┬────┘             │
         │                  ▼
         │             ┌─────────┐
         │             │   B'    │  (copy of C)
         │             └─────────┘
         ▼
    ┌─────────┐
    │   D     │
    └─────────┘
```

## Rebase

```
Before rebase:
    main    ──A──B──C
                 \
    feature       D──E

After rebase:
    main    ──A──B──C
                      \
    feature            D'──E'  (commits replayed on top)
```

## Interactive Rebase

```
    git rebase -i HEAD~3

    pick   abc1234  First commit
    squash def5678  Second commit  ◄── Squash into previous
    reword ghi9012  Third commit   ◄── Change message
    drop   jkl3456  Bad commit     ◄── Remove entirely
```

## Git Object Model

```
    ┌─────────────────────────────────────────────────────┐
    │                    Git Objects                       │
    ├─────────────────────────────────────────────────────┤
    │                                                     │
    │  ┌─────────┐    ┌─────────┐    ┌─────────┐        │
    │  │  BLOB   │    │  TREE   │    │ COMMIT  │        │
    │  │         │    │         │    │         │        │
    │  │ (file   │    │(directory)   │ (snapshot)       │
    │  │content) │    │         │    │         │        │
    │  └─────────┘    └─────────┘    └─────────┘        │
    │                                                     │
    └─────────────────────────────────────────────────────┘
```

## Reflog

```
    git reflog

    abc1234 HEAD@{0}: commit: feat: add login
    def5678 HEAD@{1}: checkout: moving from feature to main
    ghi9012 HEAD@{2}: commit: feat: add signup
    jkl3456 HEAD@{3}: commit: initial commit
```

## Conflict Markers

```
    <<<<<<< HEAD (your changes)
    Your version of the code
    =======
    Their version of the code
    >>>>>>> feature/branch (incoming changes)
```

## Quick Reference Card

```
    ┌─────────────────────────────────────────────────────┐
    │              GIT QUICK REFERENCE                    │
    ├─────────────────────────────────────────────────────┤
    │                                                     │
    │  SETUP        │ git config --global user.name "Name"│
    │  START        │ git init / git clone <url>          │
    │  STATUS       │ git status                          │
    │  STAGE        │ git add <file> / git add .          │
    │  COMMIT       │ git commit -m "message"             │
    │  PUSH         │ git push origin main                │
    │  PULL         │ git pull                            │
    │  BRANCH       │ git branch / git checkout -b <name> │
    │  MERGE        │ git merge <branch>                  │
    │  STASH        │ git stash / git stash pop           │
    │  LOG          │ git log --oneline                   │
    │  DIFF         │ git diff                            │
    │  UNDO         │ git reset HEAD~1                    │
    │                                                     │
    └─────────────────────────────────────────────────────┘
```

## Resources

- [Learn Git Branching](https://learngitbranching.js.org/) - Interactive tutorial
- [Git Visualization](https://git-school.github.io/visualizing-git/) - Visual tool
- [Oh Shit, Git!?!](https://ohshitgit.com/) - Common mistakes
