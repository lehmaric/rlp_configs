# Secrets and per-machine shell config stay out of the repo

The managed `.bashrc` is a committed shared base that ends by sourcing
`~/.bashrc.local` if it exists. Machine-specific and secret shell content
(tokens, proxies, per-box PATHs, tool init blocks) live only in
`~/.bashrc.local`, which is never tracked. This keeps the repo safe to make
public and gives each machine a clean place for its own differences, at the
cost of one extra untracked file per machine.
