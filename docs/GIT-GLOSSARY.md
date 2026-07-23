---
layout: single
title: Git Glossary
---
# Git Glossary

## A

**Annotated Tag**: A tag that contains additional metadata including the tagger's name, email, date, and a message. Created with `git tag -a`.

**Author**: The person who originally wrote a piece of code. Different from the committer.

**B**

**Bare Repository**: A repository that has no working directory. Used as a central repository. Created with `git init --bare`.

**Blame**: A command that shows who modified each line of a file and when. Used with `git blame`.

**Blob**: A Git object type that stores file contents. Each version of a file is stored as a blob.

**Branch**: A lightweight, movable pointer to a commit. The default branch is usually `main` or `master`.

**C**

**Cherry-Pick**: The act of picking a commit from one branch and applying it to another.

**Clean**: A working directory is "clean" when it has no uncommitted changes.

**Clone**: A copy of a repository, including all history and branches. Created with `git clone`.

**Code Review**: The process of examining code changes before they are merged, typically done via Pull Requests.

**Commit**: A snapshot of changes at a specific point in time. Each commit has a unique SHA-1 hash.

**Committer**: The person who last applied a commit. May be different from the author.

**Conflict**: When Git cannot automatically merge changes, requiring manual resolution.

**D**

**Detached HEAD**: When the HEAD points to a commit instead of a branch name. Happens when checking out a specific commit.

**Diff**: A formatted output showing the differences between two versions of files.

**Distributed Version Control**: A system where every developer has a complete copy of the repository.

**E**

**Epoch**: The timestamp when a repository was created.

**F**

**Fast-Forward**: A merge where the target branch has no new commits since the source branch diverged. Git simply moves the pointer forward.

**Fetch**: Downloading changes from a remote repository without automatically merging them.

**Fork**: A copy of someone else's repository on GitHub. Used for contributing to projects you don't have write access to.

**G**

**Git**: A distributed version control system created by Linus Torvalds in 2005.

**Gitignore**: A file specifying which files and directories Git should ignore.

**H**

**HEAD**: A pointer to the current branch or commit. Represents the current state of the working directory.

**Hook**: A script that runs automatically when certain Git events occur (pre-commit, post-commit, etc.).

**I**

**Index**: Another name for the staging area. An intermediate area where changes are prepared before committing.

**Interactive Rebase**: A rebase that allows you to modify, reorder, squash, or drop commits.

**J**

**Junction**: A Windows-specific type of symbolic link for directories.

**L**

**Lightweight Tag**: A simple pointer to a commit without additional metadata. Created with `git tag <name>`.

**Log**: A history of commits. Viewed with `git log`.

**M**

**Main**: The primary branch in a Git repository (formerly called `master`).

**Merge**: Combining changes from different branches into a single branch.

**Merge Conflict**: Occurs when Git cannot automatically merge changes from different branches.

**N**

**Newline**: A character sequence indicating the end of a line. Git normalizes line endings.

**O**

**Object**: A Git data structure (blob, tree, commit, tag) stored in the repository.

**Origin**: The default name for the remote repository you cloned from.

**P**

**Pack**: A binary file containing compressed Git objects. Used to optimize storage and transfer.

**Parent**: A commit that precedes another commit in the history.

**Pull**: Fetching changes from a remote and merging them into the current branch.

**Push**: Uploading local commits to a remote repository.

**R**

**Rebase**: Moving or combining a sequence of commits to a new base commit.

**Reflog**: A reference log that records when tips of branches and other refs were updated.

**Remote**: A version of your repository hosted elsewhere (e.g., GitHub).

**Repository**: A collection of files and their complete history, stored in a `.git` directory.

**S**

**Squash**: Combining multiple commits into a single commit.

**Stage**: To prepare changes for the next commit. Done with `git add`.

**Staging Area**: An intermediate area where changes are prepared before committing.

**Stash**: Temporarily shelving changes so you can work on something else.

**T**

**Tag**: A named pointer to a specific commit, typically used for releases.

**Tree**: A Git object that represents a directory. Contains pointers to blobs and other trees.

**U**

**Upstream**: The remote repository that a local repository was cloned from.

**V**

**Version Control**: A system that records changes to files over time, allowing you to recall specific versions.

**W**

**Working Directory**: The files you are currently editing on your computer.
