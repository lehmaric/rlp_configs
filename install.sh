#!/usr/bin/env bash
#
# rlp_configs installer.
#
#   ./install.sh install     symlink managed configs into place (backing up any
#                            real file already there)
#   ./install.sh uninstall   remove the symlinks we created, restoring the most
#                            recent backup if one exists
#   ./install.sh status      show, per config, whether it is linked
#
# Places configs only. It never installs packages; it warns if a required tool
# is missing. See CONTEXT.md and docs/adr/ for the design.

set -euo pipefail

# Absolute path to this repo (the directory containing this script).
REPO_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"

STAMP="$(date +%Y%m%d-%H%M%S)"

# Managed configs: "<source relative to repo>|<target under $HOME>".
# Add a row to manage a new config (e.g. "vscode/settings.json|.config/Code/User/settings.json").
MAPPINGS=(
  "bash/.bashrc|.bashrc"
  "tmux/.tmux.conf|.tmux.conf"
  "nvim|.config/nvim"
)

# Tools each config expects. Warned about, never installed.
REQUIRED_TOOLS=(bash tmux nvim git)

c_reset=$'\033[0m'; c_grn=$'\033[32m'; c_yel=$'\033[33m'; c_red=$'\033[31m'; c_dim=$'\033[2m'
info() { printf '%s\n' "$*"; }
ok()   { printf '%s%s%s\n' "$c_grn" "$*" "$c_reset"; }
warn() { printf '%s%s%s\n' "$c_yel" "$*" "$c_reset"; }
err()  { printf '%s%s%s\n' "$c_red" "$*" "$c_reset" >&2; }

# A source has nothing to link if it is missing, or is a directory whose only
# content is the .gitkeep placeholder (e.g. nvim before a real config exists).
source_has_content() {
  local src="$1"
  [ -e "$src" ] || return 1
  if [ -d "$src" ]; then
    [ -n "$(find "$src" -type f ! -name .gitkeep -print -quit)" ] || return 1
  fi
  return 0
}

check_tools() {
  local missing=0 t
  for t in "${REQUIRED_TOOLS[@]}"; do
    if ! command -v "$t" >/dev/null 2>&1; then
      warn "tool missing: $t (configs will be linked, but install it to use them)"
      missing=1
    fi
  done
  [ "$missing" -eq 0 ] && info "${c_dim}all required tools present${c_reset}"
}

do_install() {
  check_tools
  local row src dest abs_src abs_dest
  for row in "${MAPPINGS[@]}"; do
    src="${row%%|*}"; dest="${row##*|}"
    abs_src="$REPO_DIR/$src"; abs_dest="$HOME/$dest"

    if ! source_has_content "$abs_src"; then
      info "${c_dim}skip  $dest (no source in repo yet)${c_reset}"
      continue
    fi

    if [ -L "$abs_dest" ] && [ "$(readlink -f "$abs_dest")" = "$(readlink -f "$abs_src")" ]; then
      ok "ok    $dest (already linked)"
      continue
    fi

    mkdir -p "$(dirname "$abs_dest")"

    if [ -e "$abs_dest" ] || [ -L "$abs_dest" ]; then
      local backup="${abs_dest}.bak-${STAMP}"
      mv "$abs_dest" "$backup"
      warn "backup $dest -> $(basename "$backup")"
    fi

    ln -s "$abs_src" "$abs_dest"
    ok "link  $dest -> ${abs_src/#$HOME/~}"
  done
}

do_uninstall() {
  local row src dest abs_src abs_dest
  for row in "${MAPPINGS[@]}"; do
    src="${row%%|*}"; dest="${row##*|}"
    abs_src="$REPO_DIR/$src"; abs_dest="$HOME/$dest"

    if [ -L "$abs_dest" ] && [[ "$(readlink -f "$abs_dest")" == "$(readlink -f "$REPO_DIR")"* ]]; then
      rm "$abs_dest"
      info "unlink $dest"
      # Restore the most recent backup for this target, if any.
      local newest
      newest="$(ls -1dt "${abs_dest}".bak-* 2>/dev/null | head -n1 || true)"
      if [ -n "$newest" ]; then
        mv "$newest" "$abs_dest"
        ok "restore $dest <- $(basename "$newest")"
      fi
    else
      info "${c_dim}skip  $dest (not one of our links)${c_reset}"
    fi
  done
}

do_status() {
  local row src dest abs_src abs_dest
  for row in "${MAPPINGS[@]}"; do
    src="${row%%|*}"; dest="${row##*|}"
    abs_src="$REPO_DIR/$src"; abs_dest="$HOME/$dest"

    if ! source_has_content "$abs_src"; then
      printf '%s%-16s no source in repo yet%s\n' "$c_dim" "$dest" "$c_reset"
    elif [ -L "$abs_dest" ] && [ "$(readlink -f "$abs_dest")" = "$(readlink -f "$abs_src")" ]; then
      printf '%s%-16s linked%s\n' "$c_grn" "$dest" "$c_reset"
    elif [ -e "$abs_dest" ]; then
      printf '%s%-16s exists but NOT linked%s\n' "$c_yel" "$dest" "$c_reset"
    else
      printf '%s%-16s absent%s\n' "$c_dim" "$dest" "$c_reset"
    fi
  done
}

case "${1:-}" in
  install)   do_install ;;
  uninstall) do_uninstall ;;
  status)    do_status ;;
  *)
    cat <<EOF
rlp_configs installer

usage: $0 {install|uninstall|status}

  install    symlink managed configs into \$HOME (existing files are backed up)
  uninstall  remove our symlinks and restore the most recent backup
  status     report whether each config is linked
EOF
    exit 1 ;;
esac
