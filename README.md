# rlp_configs

My Linux dotfiles, made installable on any machine. The repo owns each config;
`install.sh` symlinks it into place so the file an app reads *is* the file git
tracks. See [CONTEXT.md](./CONTEXT.md) for terminology and
[docs/adr/](./docs/adr) for the design decisions.

## Install

```sh
git clone <this-repo> ~/rlp_configs
cd ~/rlp_configs
./install.sh install
```

`install` backs up any existing real file (to `<name>.bak-<timestamp>`) before
linking, and is safe to re-run. It places configs only — it never installs
packages, but warns if `tmux`, `nvim`, or `git` is missing.

```sh
./install.sh status      # show what is / isn't linked
./install.sh uninstall   # remove our links, restore the newest backup
```

## Managed configs

| Config | Repo source        | Target             |
| ------ | ------------------ | ------------------ |
| bash   | `bash/.bashrc`     | `~/.bashrc`        |
| tmux   | `tmux/.tmux.conf`  | `~/.tmux.conf`     |
| nvim   | `nvim/` (dir)      | `~/.config/nvim`   |

### Machine-specific & secret shell config

The tracked `.bashrc` is a shared base. Anything per-machine or secret (tokens,
SDKMAN init, custom `PATH`s) goes in `~/.bashrc.local`, which is **not** tracked
and is sourced last by `.bashrc`:

```sh
cp bash/bashrc.local.example ~/.bashrc.local   # then edit for this machine
```

### nvim (not tracked yet)

The `nvim/` folder is an empty placeholder, so `install.sh` skips it. When you
have a config, move `~/.config/nvim/*` into `nvim/` (commit the plugin lockfile
too) and re-run `install`.

## Adding a new config (e.g. VSCode later)

1. Create a per-app folder and add the file(s).
2. Add a row to `MAPPINGS` in `install.sh`: `"<repo/path>|<target under $HOME>"`.
3. Run `./install.sh install`.
