#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# Print step message
print_step() {
    echo -e "${BLUE}==> $1${NC}"
}

# Print success message
print_success() {
    echo -e "${GREEN}==> $1${NC}"
}

# Print error message
print_error() {
    echo -e "${RED}==> Error: $1${NC}"
    exit 1
}

# Check if command exists
check_command() {
    if ! command -v $1 &> /dev/null; then
        print_error "$1 is not installed. Please install it first."
    fi
}

# Check required commands
print_step "Checking required dependencies..."
check_command "zsh"
check_command "git"
check_command "curl"
print_success "All dependencies are installed!"

# Backup existing files
print_step "Backing up existing configuration files..."
backup_timestamp=$(date +%Y%m%d_%H%M%S)
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.backup.$backup_timestamp
[ -f ~/.p10k.zsh ] && mv ~/.p10k.zsh ~/.p10k.zsh.backup.$backup_timestamp

# Install oh-my-zsh if not already installed
print_step "Checking oh-my-zsh installation..."
if [ ! -d ~/.oh-my-zsh ]; then
    print_step "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    print_success "oh-my-zsh is already installed"
fi

# Install powerlevel10k theme
print_step "Installing powerlevel10k theme..."
if [ ! -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
else
    print_success "powerlevel10k theme is already installed"
fi

# Create symbolic links
print_step "Creating symbolic links..."
ln -sf "$PWD/zshrc" ~/.zshrc
ln -sf "$PWD/p10k.zsh" ~/.p10k.zsh

print_success "Installation completed successfully!"
print_step "Please restart your terminal or run 'source ~/.zshrc' to apply changes"

