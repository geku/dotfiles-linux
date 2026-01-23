# Dotfiles

Personal dotfiles for Ubuntu developer VM setup.

## Quick Start

```bash
# Clone the repository
git clone https://github.com/geku/dotfiles-linux.git ~/.dotfiles

# Run the installation script
cd ~/.dotfiles
./install.sh
```

## What's Included

### Fish Shell (`fish/config.fish`)
- Custom aliases for git, docker, and common commands
- `bat` integration (better `cat`)
- mise activation for language version management
- Starship prompt initialization
- Useful functions: `mkcd`, `extract`, `gacp`, `dsh`, `search`

### Starship Prompt (`starship/starship.toml`)
- Minimal, fast prompt with git status
- Language version display (Node, Python, Go, Rust, etc.)
- Docker context awareness
- Command duration for slow commands
- Nerd Font icons (requires Fira Code Nerd Font)

### mise Configuration (`mise/config.toml`)
- Node.js LTS
- Python latest
- Auto-install on directory change
- Legacy version file support (`.nvmrc`, `.python-version`, etc.)

### Git Configuration (`git/gitconfig`)
- Sensible defaults (rebase on pull, prune on fetch)
- Color output
- Useful aliases (`gs`, `gc`, `gp`, `lg`, etc.)
- `bat` as pager
- GitHub CLI credential helper

## Cloud-Init Setup

For initial VM setup, use the `cloud-init.yaml` file:

```bash
# For cloud providers supporting cloud-init
# Upload cloud-init.yaml as user-data when creating the VM

# Or run manually on existing Ubuntu:
sudo cloud-init init --file cloud-init.yaml
```

## Installed Software (via cloud-init)

| Tool | Description |
|------|-------------|
| Docker | Container runtime with compose |
| Git | Version control |
| GitHub CLI (gh) | GitHub from the terminal |
| HTTPie | User-friendly HTTP client |
| curl | Data transfer tool |
| nano | Text editor |
| jq | JSON processor |
| bat | Better `cat` with syntax highlighting |
| fish | Friendly interactive shell |
| ack | Better `grep` for code |
| mise | Polyglot version manager |
| Starship | Cross-shell prompt |
| Fira Code Nerd Font | Programming font with icons |
| Build essentials | GCC, make, etc. |

## Post-Installation

1. **Configure Git:**
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your@email.com"
   ```

2. **Authenticate GitHub:**
   ```bash
   gh auth login
   ```

3. **Install additional languages with mise:**
   ```bash
   # Install specific versions
   mise use node@20
   mise use python@3.12
   mise use golang@latest

   # Or add to ~/.config/mise/config.toml and run:
   mise install
   ```

4. **Local overrides:**
   Create `~/.config/fish/local.fish` for machine-specific settings:
   ```fish
   # ~/.config/fish/local.fish
   set -gx MY_API_KEY "secret"
   alias myalias="some command"
   ```

## Directory Structure

```
dotfiles/
├── fish/
│   └── config.fish      # Fish shell configuration
├── git/
│   └── gitconfig        # Git configuration
├── mise/
│   └── config.toml      # mise (version manager) configuration
├── starship/
│   └── starship.toml    # Starship prompt configuration
├── install.sh           # Installation script
└── README.md            # This file
```

## License

MIT
