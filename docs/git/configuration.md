# Configuration

## git config

Set configuration values at system, global, or local level.

```bash
git config --global user.name "Name"           # Set user name
git config --global user.email "email"         # Set user email
git config --global core.editor "code --wait"  # Set editor
git config --global init.defaultBranch main    # Default branch name
git config --global pull.rebase true           # Rebase on pull
git config --global fetch.prune true           # Auto-prune on fetch
git config --list                              # List all config
git config --list --global                     # Global config only
git config --list --local                      # Repo config only
git config --list --show-origin               # Show config file origin
git config <key>                               # Get a value
git config --unset <key>                       # Remove a value
git config --global alias.<name> "<cmd>"       # Create alias
git config --global core.autocrlf input        # Line endings (Linux/Mac)
git config --global core.autocrlf true         # Line endings (Windows)
git config --global color.ui auto              # Enable colors
git config --global core.excludesfile ~/.gitignore_global  # Global gitignore
git config --global diff.tool vscode           # Set diff tool
git config --global merge.tool vscode          # Set merge tool
git config --global core.safecrlf warn         # Warn about CRLF issues
git config --global credential.helper store    # Cache credentials
```

### Useful Aliases

```bash
git config --global alias.co "checkout"
git config --global alias.br "branch -a"
git config --global alias.ci "commit"
git config --global alias.st "status -sb"
git config --global alias.lg "log --oneline --graph --all"
git config --global alias.undo "reset --soft HEAD~1"
git config --global alias.unstage "restore --staged"
git config --global alias.last "log -1 HEAD"
```

## git help

Get help for any Git command.

```bash
git help <command>                       # Open man page
git <command> --help                     # Same as above
git help -a                              # List all commands
git help -g                              # List guides
git help tutorial                        # Git tutorial
git help workflows                       # Workflows guide
```

## git maintenance

Optimize repository performance.

```bash
git maintenance start                    # Start background maintenance
git maintenance stop                     # Stop background maintenance
git maintenance run --task=gc            # Run garbage collection
git maintenance run --task=commit-graph  # Write commit graph
git maintenance run --task=prefetch      # Prefetch remotes
git maintenance run --task=loose-objects # Pack loose objects
git maintenance run --task=incremental-repack  # Incremental repack
```

## git gc

Garbage collect and optimize repository.

```bash
git gc                                   # Run garbage collection
git gc --aggressive                      # Full optimization (slow)
git gc --auto                            # Auto-gc when needed
git gc --prune=now                       # Prune all loose objects
```

## git fsck

Check repository integrity.

```bash
git fsck                                # Check object database
git fsck --full                         # Full check
git fsck --unreachable                  # Show unreachable objects
git fsck --lost-found                   # Put dangling objects in .git/lost-found
```
