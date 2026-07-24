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
linking, and is safe to re-run. It links every mapped config whose repo folder
exists — even an empty one — so files added later show up at the target with no
re-run. It places configs only: it never installs packages, but warns if
`tmux`, `nvim`, or `git` is missing.

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

### nvim (empty for now)

`~/.config/nvim` is already symlinked to the repo's `nvim/` folder, which holds
only a `.gitkeep` placeholder. Add an `init.lua` (and the rest of your config)
into `nvim/` and it appears at `~/.config/nvim` immediately — no re-run needed.
Commit the plugin lockfile (e.g. `lazy-lock.json`) too, for reproducible
plugin versions across machines.

## Adding a new config (e.g. VSCode later)

1. Create a per-app folder and add the file(s).
2. Add a row to `MAPPINGS` in `install.sh`: `"<repo/path>|<target under $HOME>"`.
3. Run `./install.sh install`.
