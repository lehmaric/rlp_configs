# rlp_configs

A personal dotfiles repository: the canonical home for this user's Linux
application configs, made installable on any machine via symlinks.

## Language

**Managed config**:
A config file (or directory) that this repo owns and installs onto a machine.
Currently: bash, nvim, tmux.
_Avoid_: dotfile (too generic), setting

**Target**:
The location in the user's home where a managed config is expected by its
application (e.g. `~/.bashrc`, `~/.config/nvim`).
_Avoid_: destination, install path

**Link**:
The symlink created at a Target that points back to the managed config in the
repo. The application reads the repo's file through this Link.
_Avoid_: shortcut, alias

**Backup**:
A pre-existing real file at a Target, moved aside (timestamped) before a Link
is created. Lets an install be undone or inspected.
_Avoid_: archive, snapshot

**Local override**:
Machine-specific or secret shell config that must never be committed. Lives at
`~/.bashrc.local` and is sourced by the managed `.bashrc`.
_Avoid_: private config, env file
