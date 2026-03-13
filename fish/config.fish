# Fish Shell Configuration
# ~/.config/fish/config.fish

# ============================================
# Environment Variables
# ============================================

# Set default editor
set -gx EDITOR nano
set -gx VISUAL nano

# XDG Base Directory Specification
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_STATE_HOME $HOME/.local/state

# Path additions
fish_add_path $HOME/.local/bin
fish_add_path $HOME/bin
fish_add_path /usr/local/bin

# ============================================
# mise (version manager) activation
# ============================================
if test -x $HOME/.local/bin/mise
    $HOME/.local/bin/mise activate fish | source
end

# ============================================
# Starship Prompt
# ============================================
if command -q starship
    starship init fish | source
end

# ============================================
# Aliases
# ============================================

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# List files (using bat colors when available)
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# bat as cat replacement
if command -q bat
    alias cat='bat --paging=never'
    alias catp='bat'
end

# Git aliases
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gco='git checkout'
alias gb='git branch'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate'
alias gla='git log --oneline --graph --decorate --all'

# Docker aliases
alias d='docker'
alias dc='docker compose'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dex='docker exec -it'
alias dlogs='docker logs -f'
alias dprune='docker system prune -af'

# GitHub CLI
alias ghpr='gh pr create'
alias ghprl='gh pr list'
alias ghprv='gh pr view'

# HTTPie
alias https='http --default-scheme=https'

# Safety nets
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Misc
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias ports='netstat -tulanp'

# ============================================
# Functions
# ============================================

# Create directory and cd into it
function mkcd
    mkdir -p $argv[1] && cd $argv[1]
end

# Extract various archive formats
function extract
    if test -f $argv[1]
        switch $argv[1]
            case '*.tar.bz2'
                tar xjf $argv[1]
            case '*.tar.gz'
                tar xzf $argv[1]
            case '*.tar.xz'
                tar xJf $argv[1]
            case '*.bz2'
                bunzip2 $argv[1]
            case '*.gz'
                gunzip $argv[1]
            case '*.tar'
                tar xf $argv[1]
            case '*.tbz2'
                tar xjf $argv[1]
            case '*.tgz'
                tar xzf $argv[1]
            case '*.zip'
                unzip $argv[1]
            case '*.Z'
                uncompress $argv[1]
            case '*.7z'
                7z x $argv[1]
            case '*'
                echo "'$argv[1]' cannot be extracted via extract()"
        end
    else
        echo "'$argv[1]' is not a valid file"
    end
end

# Quick git add, commit, push
function gacp
    git add -A
    git commit -m "$argv"
    git push
end

# Docker shell into container
function dsh
    docker exec -it $argv[1] /bin/bash 2>/dev/null; or docker exec -it $argv[1] /bin/sh
end

# Search in files using ack and bat
function search
    ack -l $argv[1] | xargs bat --color=always 2>/dev/null
end

# ============================================
# Interactive Shell Settings
# ============================================

if status is-interactive
    # Disable greeting
    set -g fish_greeting
    
    # Set terminal title
    function fish_title
        echo (prompt_pwd)
    end
    
    # Better history
    set -g fish_history_max_age_days 365
end

# ============================================
# Local overrides (not tracked in git)
# ============================================
if test -f ~/.config/fish/local.fish
    source ~/.config/fish/local.fish
end
export PATH="$HOME/.local/bin:$PATH"

# Added by Antigravity
fish_add_path /Users/georg/.antigravity/antigravity/bin
