# Dotfiles

This repository contains my personal dotfiles configuration for a consistent development environment across different machines. It includes customized configurations for zsh shell with the powerlevel10k theme.

## What's Included

- Zsh configuration
- Powerlevel10k theme setup
- Custom aliases and functions
- Shell preferences and settings

## Prerequisites

Before installation, ensure you have the following installed:
- git
- zsh
- curl
- [Optional] A [Nerd Font](https://www.nerdfonts.com/) for powerlevel10k theme

## Installation

### Quick Setup

```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/.dotfiles && cd ~/.dotfiles && ./install.sh
```

### Manual Installation

1. Clone the repository:
```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/.dotfiles
```

2. Navigate to the directory:
```bash
cd ~/.dotfiles
```

3. Run the installation script:
```bash
./install.sh
```

## What it Does

The installation script will:
1. Install Oh My Zsh if not already installed
2. Install the Powerlevel10k theme
3. Create symbolic links for all configuration files
4. Backup any existing configurations

## Customization

After installation, you can customize your setup by editing:
- `~/.zshrc` for shell configurations
- `~/.p10k.zsh` for Powerlevel10k theme settings

