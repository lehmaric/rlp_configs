# Install by symlink, with a hand-written bash script

We install managed configs by symlinking the repo's files into their home
Targets, driven by a single hand-written `install.sh`. We rejected copying
(local edits would silently drift from the repo), and rejected dedicated tools
(GNU Stow, chezmoi) to avoid a bootstrap dependency and keep every line of
behaviour transparent and owned. The symlink means the file an application
reads *is* the git-tracked file, so edits are captured automatically.
