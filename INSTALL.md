# Installation

Full setup guide, from a freshly unboxed machine to a working environment.
For the short version, see [README.md](README.md).

- [macOS (nix-darwin)](#macos-nix-darwin)
- [NixOS](#nixos)
- [Linux (standalone home-manager)](#linux-standalone-home-manager)
- [Day-to-day](#day-to-day)
- [Troubleshooting](#troubleshooting)

## macOS (nix-darwin)

### 1. Xcode Command Line Tools

Needed for `git` and the system toolchain before Nix is in place.

```shell
xcode-select --install
```

Sign in to the **App Store** now as well — `mas` installs the App Store apps
during the first switch and fails if no account is signed in.

### 2. Install Determinate Nix

```shell
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --determinate
```

`--determinate` matters: `modules/darwin/default.nix` sets `nix.enable = false`,
which hands Nix management to the Determinate installer instead of nix-darwin.
Installing plain upstream Nix here leaves the daemon unmanaged.

Open a new shell afterwards so `nix` is on `PATH`.

### 3. Install Homebrew

nix-darwin declares Homebrew packages but does **not** install Homebrew itself.
The first switch fails without it.

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### 4. Clone the repository

The clone path is not arbitrary — the `rebuild` and `update` aliases in
`modules/home/zsh.nix` point at `~/ghq/simenandre.no/dotfiles`, so clone it
there.

```shell
mkdir -p ~/ghq/simenandre.no
git clone https://simenandre.no/dotfiles.git ~/ghq/simenandre.no/dotfiles
cd ~/ghq/simenandre.no/dotfiles
```

HTTPS on purpose: SSH access depends on 1Password's SSH agent, which is not
installed yet. After the first switch, git rewrites the HTTPS remote to SSH
(`url."git@simenandre.no:".insteadOf`), so this remote keeps working.

### 5. First switch (bootstrap nix-darwin)

```shell
sudo nix run nix-darwin#darwin-rebuild -- switch --flake .#default
```

This is the long one: it installs every Homebrew cask, the Mac App Store apps,
all nixpkgs packages, and applies the macOS defaults. Expect Homebrew to prompt
for your password, and expect to approve a few system dialogs.

Subsequent switches use the installed binary:

```shell
sudo darwin-rebuild switch --flake .#default
```

Restart the terminal (or log out and back in) so the new zsh config, `PATH`, and
Ghostty configuration take effect.

### 6. 1Password and SSH

Git commits are signed through 1Password's SSH agent
(`/Applications/1Password.app/Contents/MacOS/op-ssh-sign`), so this has to be
set up before committing anything.

1. Open **1Password**, sign in, and unlock it.
2. Settings → Developer → enable **Use the SSH agent**.
3. Settings → Developer → enable **Integrate with 1Password CLI** (for `op`).
4. Verify the signing key matches the one pinned in `modules/home/git.nix`:

   ```shell
   ssh-add -l
   ```

5. Confirm GitHub over SSH works:

   ```shell
   ssh -T git@github.com
   ```

### 7. Sign in to the rest

Each of these is a one-time manual login:

```shell
gh auth login          # GitHub CLI
op signin              # 1Password CLI
gcloud auth login      # Google Cloud
gcloud auth application-default login
```

GUI apps that need a login or permission grant: Tailscale (App Store), Slack,
Discord, Signal, Obsidian, Proton Mail, ProtonVPN, Spotify, Raycast (grant
Accessibility), Google Drive.

### 8. Container runtime

Docker CLIs come from Homebrew, but the VM has to be started once:

```shell
colima start
```

`DOCKER_HOST` is already pointed at `~/.colima/default/docker.sock` by
`modules/home/zsh.nix`.

### 9. Rust toolchain

`rustup` is installed, but ships without a toolchain:

```shell
rustup default stable
```

### 10. Tools not managed by Nix

These are installed with `go install` and live in `~/go/bin`. Shell completions
for them are generated on every switch, and the generator quietly skips any that
are missing:

```shell
go install github.com/sokkelorg/cli/cmd/so@latest
go install github.com/simenandre/bobbin/cmd/bobbin@latest
go install github.com/simenandre/robin-cli/cmd/robin@latest
go install github.com/dinacomputer/api/cmd/dinactl@latest
go install github.com/sokkelorg/identity/cmd/identityctl@latest
```

### 11. Loose ends

```shell
mkdir -p ~/Screenshots     # macos.nix points screencapture here; it is not created for you
```

`~/.gitignore_global` is referenced by `core.excludesfile` but is not managed by
this repo. Create it if you want it:

```
.DS_Store
.twm.yaml
.twm.yml

**/.claude/settings.local.json
```

Some macOS defaults (Dock, Finder, trackpad) only take effect after a logout or
restart.

## NixOS

```shell
sudo nixos-generate-config --show-hardware-config > hosts/nixbox/hardware-configuration.nix
sudo nixos-rebuild switch --flake .#nixbox
```

The `nixbox` host expects the user `simenandre`. Git commit signing is disabled
outside macOS, so no 1Password setup is required.

## Linux (standalone home-manager)

```shell
# x86_64
home-manager switch --flake .#simenandre

# aarch64
home-manager switch --flake .#simenandre@aarch64-linux
```

## Day-to-day

Aliases defined in `modules/home/zsh.nix` (macOS):

| Alias     | Does                                              |
| --------- | ------------------------------------------------- |
| `rebuild` | `darwin-rebuild switch` against this flake        |
| `update`  | `nix flake update`, then rebuild                  |
| `nix-gc`  | Garbage-collect store paths older than 14 days    |

`scripts/cleanup.sh` is a separate macOS cleanup utility (caches, logs, trash).

## Troubleshooting

**`error: Homebrew is not installed`** — step 3 was skipped, or `brew` is not on
`PATH` for the shell running the switch. Run `eval "$(/opt/homebrew/bin/brew shellenv)"`.

**Mac App Store apps fail to install** — sign in to the App Store, then re-run
the switch. `mas` cannot authenticate on its own.

**home-manager refuses to overwrite an existing file** — files it would clobber
are backed up with a `.bak` suffix (`backupFileExtension = "bak"`). If a switch
still fails on a collision, a stale `.bak` from an earlier run is usually in the
way; delete it and re-run.

**A cask fails to install because the app already exists** — remove the
hand-installed copy from `/Applications` and re-run the switch.

**`warning: failed to generate _<tool>`** during activation — that tool is not
installed (see step 10). Harmless; only its completions are missing.

**A `nixpkgs` package suddenly fails to build** — check `flake.lock`. Pinned
overrides live in `modules/darwin/default.nix` (for example WhatsApp's version
and hash).
