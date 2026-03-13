#!/usr/bin/env bash
# Dotfiles Installation Script
# Run: ./install.sh

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}======================================${NC}"
echo -e "${BLUE}   Dotfiles Installation Script${NC}"
echo -e "${BLUE}======================================${NC}"
echo ""

# Function to print status messages
info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to create symlink with backup
create_symlink() {
    local src="$1"
    local dest="$2"
    
    if [ -L "$dest" ]; then
        # Remove existing symlink
        rm "$dest"
    elif [ -f "$dest" ] || [ -d "$dest" ]; then
        # Backup existing file/directory
        warn "Backing up existing $dest to ${dest}.backup"
        mv "$dest" "${dest}.backup.$(date +%Y%m%d_%H%M%S)"
    fi
    
    # Create parent directory if needed
    mkdir -p "$(dirname "$dest")"
    
    # Create symlink
    ln -sf "$src" "$dest"
    success "Linked $dest -> $src"
}

# ============================================
# Fish Shell Configuration
# ============================================
info "Setting up Fish shell configuration..."

mkdir -p "$HOME/.config/fish"
create_symlink "$DOTFILES_DIR/fish/config.fish" "$HOME/.config/fish/config.fish"

# ============================================
# Starship Prompt Configuration
# ============================================
info "Setting up Starship prompt..."

mkdir -p "$HOME/.config"
create_symlink "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"

# ============================================
# mise Configuration
# ============================================
info "Setting up mise configuration..."

mkdir -p "$HOME/.config/mise"
create_symlink "$DOTFILES_DIR/mise/config.toml" "$HOME/.config/mise/config.toml"

# ============================================
# Git Configuration
# ============================================
info "Setting up Git configuration..."

create_symlink "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"

# ============================================
# Install mise plugins and tools
# ============================================
if command -v mise &> /dev/null; then
    info "Installing mise tools..."
    mise install --yes 2>/dev/null || warn "mise install failed (tools may already be installed)"
    success "mise tools configured"
else
    warn "mise not found. Install it and run 'mise install' to set up tools."
fi

# ============================================
# Final Steps
# ============================================
echo ""
echo -e "${GREEN}======================================${NC}"
echo -e "${GREEN}   Installation Complete!${NC}"
echo -e "${GREEN}======================================${NC}"
echo ""
echo "Next steps:"
echo "  1. Configure git user info:"
echo "     git config --global user.name \"Your Name\""
echo "     git config --global user.email \"your@email.com\""
echo ""
echo "  2. Authenticate with GitHub:"
echo "     gh auth login"
echo ""
echo "  3. Start a new fish shell or restart your terminal"
echo ""
echo "  4. (Optional) Create ~/.config/fish/local.fish for local overrides"
echo ""
