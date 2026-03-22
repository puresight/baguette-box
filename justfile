#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#
#%#
#%# justfile - A command runner for this project
#%#
#%# Just is a handy way to save and run project-specific commands!
#%#
#%# This file contains "recipes" for common development and setup tasks.
#%# To see available recipes, run: `just`
#%# To run a specific recipe, use: `just <recipe-name>`
#%#
#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#

set dotenv-load := true
set shell := ["bash", "-c"]

export SCRIPTROOT := justfile_directory()
export BIN_DIR := home_dir() + "/.local/bin"
export a := ':::::::::::::::'

[default]
_:
    @just --list

#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#
#%# -- High-level Recipes --
#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#

# Install tons of stuff to bootstrap
bootstrap: install-eget install-gomplate configure-apt install-apt-packages configure-shell install-dotnet install-mise-tools install-uv install-font install-terminal-tools install-storage-tools display-environment display-versions
    @echo
    @echo 'Bootstrap complete. Remember to restart your shell environment before proceeding.'

# Install Ansible
ansible: _install-ansible-from-uv display-environment
    @echo
    @echo Ansible CLI should be ready to use.

# Install VS Code w/ custom settings & extensions
code: configure-code
    @echo
    @echo VS Code should be ready to use.

#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#
#%# -- Regular Recipes --
#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#

# Display environment
display-environment:
    @echo
    @echo "$a display-environment $a"
    @. scripts/index.sh &&\
        display_environment

# Display versions
display-versions:
    @echo
    @echo "$a display-versions $a"
    @. scripts/index.sh &&\
        display_versions

# Configure APT sources
configure-apt: install-gomplate
    @echo
    @echo "$a configure-apt $a"
    @. scripts/index.sh &&\
        configure_apt apt

# Configure shells
configure-shell: install-apt-packages install-dotnet
    @echo
    @echo "$a configure-shell $a"
    @. scripts/index.sh &&\
        configure_shell zsh pwsh

# Configure Flatpak
configure-flatpak: install-apt-packages
    @echo
    @echo "$a configure-flatpak $a"
    @. scripts/index.sh &&\
        configure_flatpak

# Configure Podman
configure-podman: install-apt-packages
    @echo
    @echo "$a configure-podman $a"
    @. scripts/index.sh &&\
        configure_podman

# Configure Code
configure-code updates="code/user-settings.json": install-code-extensions
    @echo
    @echo "$a configure-code $a"
    @. scripts/index.sh &&\
        configure_code {{updates}}

# Install APT packages
install-apt-packages: configure-apt
    @echo
    @echo "$a install-apt-packages $a"
    @. scripts/index.sh &&\
        install_apt_packages 'apt/apt.dep'

# Install Code
install-code updates="code/argv.json": install-apt-packages
    @echo
    @echo "$a install-code $a"
    @. scripts/index.sh &&\
        install_code {{updates}}

# Install Code extensions
install-code-extensions extensions="code/code.dep": install-code
    @echo
    @echo "$a install-code-extensions $a"
    @. scripts/index.sh &&\
        install_code_extensions {{extensions}}

# Install homebrew packages
install-homebrew-packages bundle="homebrew/homebrew.dep": install-homebrew
    @echo
    @echo "$a install-homebrew-packages $a"
    @. scripts/index.sh &&\
        install_homebrew_packages {{bundle}}

# Install Homebrew
install-homebrew:
    @echo
    @echo "$a install-homebrew $a"
    @. scripts/index.sh &&\
        install_homebrew

# Install mise-en-place system
install-mise:
    @echo
    @echo "$a install-mise $a"
    @. scripts/index.sh &&\
        install_mise

# Install tools in mise.toml config
install-mise-tools: install-mise
    @echo
    @echo "$a install-mise-tools $a"
    @. scripts/index.sh &&\
        install_mise_tools

# Install Jekyll static site generator
install-jekyll: install-mise-tools
    @echo
    @echo "$a install-jekyll $a"
    @. scripts/index.sh &&\
        install_jekyll

# Install Rails framework
install-rails: install-mise-tools
    @echo
    @echo "$a install-rails $a"
    @. scripts/index.sh &&\
        install_rails

# Install Goose IDE
install-goose:
    @echo
    @echo "$a install-goose $a"
    @. scripts/index.sh &&\
        install_goose

# Install Ansible using uv
_install-ansible-from-uv: install-uv
    @. scripts/index.sh &&\
        install_using_uv_with_executables_from 'ansible' 'ansible-core,ansible-lint' 'localhost -m ping'

# Install gomplate for using JSON, YAML, & text templates
install-gomplate: install-eget
    @echo
    @echo "$a install-gomplate $a"
    ./scripts/install-gomplate.sh

# Install Eget (for downloading GitHub releases)
install-eget:
    @echo
    @echo "$a install-eget $a"
    @. scripts/index.sh &&\
        install_eget

# Install Rust language
install-rust:
    @echo
    @echo "$a install-rust $a"
    @. scripts/index.sh &&\
        install_rust

# Install terminal tools
install-terminal-tools shell="zsh":
    @echo
    @echo "$a install-terminal-tools $a"
    @. scripts/index.sh &&\
        install_terminal_tools {{shell}}

# Install a Nerd Font
install-font id="JetBrainsMono" version="v3.3.0":
    @echo
    @echo "$a install-font $a"
    @. scripts/index.sh &&\
        install_font {{id}} {{version}}

# Install .NET SDK
install-dotnet version="10": configure-apt
    @echo
    @echo "$a install-dotnet $a"
    @. scripts/index.sh &&\
        install_dotnet {{version}}

# Install OpenJDK
install-java version="21": configure-apt
    @echo
    @echo "$a install-java $a"
    @. scripts/index.sh &&\
        install_java {{version}}

# Install storage tools
install-storage-tools:
    @echo
    @echo "$a install-storage-tools $a"
    @. scripts/index.sh &&\
        install_storage_tools

# Install uv, the Python package manager
install-uv:
    @echo
    @echo "$a install-uv $a"
    @. scripts/index.sh &&\
        install_uv

#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#
