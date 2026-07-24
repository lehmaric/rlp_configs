# The installer places configs only; it does not install tools

`install.sh` symlinks configs and warns if a required tool (tmux, nvim, git) is
missing, but never installs packages itself. This keeps the script
distro-agnostic and sudo-free rather than detecting and driving each package
manager (apt/dnf/pacman/…). The trade-off: setting up a truly bare machine
takes one manual `install <tool>` step per missing tool before configs are useful.
