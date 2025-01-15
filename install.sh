#!/bin/bash

# Define colors for output
GREEN="\033[1;32m"
RED="\033[1;31m"
BLUE="\033[1;34m"
NC="\033[0m" # No color

# Print functions
print_step() {
    echo -e "${BLUE}==> $1${NC}"
}

print_success() {
    echo -e "${GREEN}[✔] $1${NC}"
}

print_error() {
    echo -e "${RED}[✘] $1${NC}"
    exit 1
}

# Install Zsh
install_zsh() {
    if command -v zsh &> /dev/null; then
        print_success "Zsh is already installed"
        if [[ "$SHELL" != "$(which zsh)" ]]; then
            print_step "Setting Zsh as the default shell..."
            chsh -s "$(which zsh)"
            print_success "Zsh is now the default shell. Please log out and back in for changes to take effect."
        else
            print_success "Zsh is already the default shell"
        fi
    else
        print_step "Installing Zsh..."
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            if command -v apt &> /dev/null; then
                sudo apt update
                sudo apt install -y zsh
            elif command -v yum &> /dev/null; then
                sudo yum install -y zsh
            else
                print_error "Unsupported Linux distribution. Please install Zsh manually."
            fi
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            if command -v brew &> /dev/null; then
                brew install zsh
            else
                print_error "Homebrew is required to install Zsh on macOS. Please install it and rerun this script."
            fi
        else
            print_error "Unsupported OS. Please install Zsh manually."
        fi
        chsh -s "$(which zsh)"
        print_success "Zsh installed and set as the default shell. Please log out and back in for changes to take effect."
    fi
}

# Install Vim
install_vim() {
    if command -v vim &> /dev/null; then
        print_success "Vim is already installed"
    else
        print_step "Installing Vim..."
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            if command -v apt &> /dev/null; then
                sudo apt update
                sudo apt install -y vim
            elif command -v yum &> /dev/null; then
                sudo yum install -y vim
            else
                print_error "Unsupported Linux distribution. Please install Vim manually."
            fi
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            if command -v brew &> /dev/null; then
                brew install vim
            else
                print_error "Homebrew is required to install Vim on macOS. Please install it and rerun this script."
            fi
        else
            print_error "Unsupported OS. Please install Vim manually."
        fi
    fi
}

# Install Tmux
install_tmux() {
    if command -v tmux &> /dev/null; then
        print_success "Tmux is already installed"
    else
        print_step "Installing Tmux..."
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            if command -v apt &> /dev/null; then
                sudo apt update
                sudo apt install -y tmux
            elif command -v yum &> /dev/null; then
                sudo yum install -y tmux
            else
                print_error "Unsupported Linux distribution. Please install Tmux manually."
            fi
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            if command -v brew &> /dev/null; then
                brew install tmux
            else
                print_error "Homebrew is required to install Tmux on macOS. Please install it and rerun this script."
            fi
        else
            print_error "Unsupported OS. Please install Tmux manually."
        fi
    fi
}

# Create symbolic links for configuration files
create_symlinks() {
    SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
    ln -sf "$SCRIPT_DIR/.zshrc" ~/.zshrc || print_error "Failed to create symlink for .zshrc"
    ln -sf "$SCRIPT_DIR/.p10k.zsh" ~/.p10k.zsh || print_error "Failed to create symlink for .p10k.zsh"
    ln -sf "$SCRIPT_DIR/vimrc" ~/.vimrc || print_error "Failed to create symlink for .vimrc"
    print_success "Symbolic links created successfully"
}

# Main script
print_step "Starting dotfiles setup..."

install_zsh
install_vim
install_tmux
create_symlinks

print_step "Setup completed!"
echo -e "${BLUE}Please restart your terminal or log out and back in to apply the changes.${NC}"
