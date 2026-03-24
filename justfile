#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#
#%#
#%# justfile - A command runner for this project
#%#
#%# Just is a handy way to save and run project-specific commands!
#%#
#%# This file contains "recipes" for common development and setup tasks
#%#   To see available recipes, run: `just`
#%#   To run a specific recipe, use: `just <recipe-name>`
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

# Bootstrap the system to the max
bootstrap-max: install-apt-packages configure-shell install-dotnet install-tools-terminal install-tools-storage configure-flatpak install-homebrew install-rust install-uv install-java install-kubectl install-node install-go install-ruby install-jekyll install-rails install-goose install-ansible configure-podman display-environment display-versions
    @echo
    @echo 'Remember to restart your shell environment before proceeding.'

# Bootstrap the system
bootstrap: install-apt-packages configure-shell install-uv install-node display-environment display-versions
    @echo
    @echo 'Remember to restart your shell environment before proceeding.'

# Install VS Code w/ custom settings & extensions
code: configure-code
    @echo
    @echo 'VS Code is ready to use.'

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

# TODO Refactor function configure_shell to remove dependency on install-dotnet
# Configure shells
configure-shell: install-apt-packages install-font install-dotnet
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

# Install APT packages
install-apt-packages: configure-apt
    @echo
    @echo "$a install-apt-packages $a"
    @. scripts/index.sh &&\
        install_apt_packages 'apt/apt.dep'

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

# Install kubectl using mise
install-kubectl version="latest": install-mise
    @echo
    @echo "$a install-kubectl $a"
    @echo "global: $HOME/.config/mise/config.toml"
    mise use -g "kubectl@{{version}}"

# Install Node engine using mise
install-node version="sub-2:lts": install-mise
    @echo
    @echo "$a install-node $a"
    @echo "global: $HOME/.config/mise/config.toml"
    mise use -g "node@{{version}}"

# Install Go language using mise
install-go version="sub-0.0.1:latest": install-mise
    @echo
    @echo "$a install-go $a"
    @echo "global: $HOME/.config/mise/config.toml"
    mise use -g "go@{{version}}"

# Install Ruby language using mise
install-ruby version="sub-0.1:latest": install-mise
    @echo
    @echo "$a install-ruby $a"
    @echo "global: $HOME/.config/mise/config.toml"
    mise use -g "ruby@{{version}}"

# Install Jekyll static site generator
install-jekyll: install-ruby
    @echo
    @echo "$a install-jekyll $a"
    @. scripts/index.sh &&\
        install_jekyll

# Install Rails framework
install-rails: install-ruby
    @echo
    @echo "$a install-rails $a"
    @. scripts/index.sh &&\
        install_rails

# Install .NET SDK
install-dotnet version="10": install-mise
    @echo
    @echo "$a install-rails $a"
    @echo "global: $HOME/.config/mise/config.toml"
    mise use -g "dotnet@{{version}}"

# Install OpenJDK
install-java version="21": install-mise
    @echo
    @echo "$a install-java $a"
    @# microsoft- (MSFT) corretto- (Amazon) temurin- (Eclipse Adoptium) zulu- (Azul Systems) oracle- (Oracle) 
    @echo "global: $HOME/.config/mise/config.toml"
    mise use -g "java@temurin-{{version}}"

# Install Kotlin language
install-kotlin version="latest": install-java
    @echo
    @echo "$a install-kotlin $a"
    @echo "global: $HOME/.config/mise/config.toml"
    mise use -g "kotlin@{{version}}"

# Install Erlang language
install-erlang: install-mise
    @echo
    @echo "$a install-erlang $a"
    @echo "global: $HOME/.config/mise/config.toml"
    mise use -g "erlang@latest"

# Install Elixir language
install-elixir: install-erlang
    @echo
    @echo "$a install-elixir $a"
    mise use -g elixir@latest

# Install Goose IDE
install-goose:
    @echo
    @echo "$a install-goose $a"
    @. scripts/index.sh &&\
        install_goose

# Install gomplate for using JSON, YAML, & text templates
install-gomplate: install-mise
    @echo
    @echo "$a install-gomplate $a"
    mise use -g gomplate@latest

# Install Rust language using Rustup
install-rust:
    @echo
    @echo "$a install-rust $a"
    @. scripts/index.sh &&\
        install_rust

# Install terminal tools
install-tools-terminal shell="zsh": install-mise
    @echo
    @echo "$a install-tools-terminal $a"
    @. scripts/index.sh &&\
        install_terminal_tools {{shell}}

# Install a Nerd Font
install-font id="JetBrainsMono" version="v3.3.0":
    @echo
    @echo "$a install-font $a"
    @. scripts/index.sh &&\
        install_font {{id}} {{version}}

# Install storage tools
install-tools-storage: install-mise
    @echo
    @echo "$a install-tools-storage $a"
    mise use -g mc@latest

# Install uv, the Python package manager
install-uv:
    @echo
    @echo "$a install-uv $a"
    @. scripts/index.sh &&\
        install_uv

# Install Ansible
install-ansible: _install-ansible-from-uv display-environment
    @echo
    @echo 'Ansible CLI should be ready to use.'

# Private: install Ansible using uv
_install-ansible-from-uv: install-uv
    @. scripts/index.sh &&\
        install_using_uv_with_executables_from 'ansible' 'ansible-core,ansible-lint' 'localhost -m ping'

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

# Configure Code
configure-code updates="code/user-settings.json": install-code-extensions
    @echo
    @echo "$a configure-code $a"
    @. scripts/index.sh &&\
        configure_code {{updates}}

#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#
