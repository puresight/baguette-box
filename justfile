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
export OS_FAMILY := "debian"
export a := ':::::::::::::::'

[default]
_:
    @just --list

#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#
#%# -- High-level Recipes --
#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#

# Bootstrap the Debian system
[group('Debian only')]
[group('* Featured *')]
debian: install-apt-packages configure-shell install-uv install-viteplus display-environment display-versions
    @printf "\nRemember to restart your shell environment before proceeding.\n"

# Bootstrap the uBlue system
[group('uBlue only')]
[group('* Featured *')]
ublue: install-mise install-gomplate install-tools-storage install-uv install-wasmer install-kubectl install-java install-kotlin install-scala install-go install-rust install-ruby install-rails  install-viteplus display-environment display-versions
    @printf "\nRemember to restart your shell environment before proceeding.\n"

# Install VS Code w/ custom settings & extensions
[group('* Featured *')]
code: configure-code
    @printf "\nVS Code is ready to use.\n"

# For test purposes only on Debian
_test-debian: install-apt-packages configure-shell install-dotnet install-tools-terminal install-tools-storage configure-flatpak install-homebrew install-rust install-uv install-java install-kubectl install-viteplus install-go install-ruby install-jekyll install-rails install-goose install-ansible configure-podman display-environment display-versions
    @printf "\nRemember to restart your shell environment before proceeding.\n"

#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#
#%# -- Regular Recipes : Debian Only --
#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#

# Check Debian APT
[group('Debian only')]
check-apt:
    @printf "\n$a check-apt $a\n"
    ./scripts/check-apt.sh

# Configure APT sources
[group('Debian only')]
configure-apt: check-apt install-gomplate
    @printf "\n$a configure-apt $a\n"
    ./scripts/apt.sh

# TODO Refactor function configure_shell to remove dependency on install-dotnet
# Configure shells
[group('Debian only')]
configure-shell: install-apt-packages install-font install-dotnet
    @printf "\n$a configure-shell $a\n"
    @. scripts/index.sh && \
        configure_shell zsh pwsh

# Configure Flatpak
[group('Debian only')]
configure-flatpak: install-apt-packages
    @printf "\n$a configure-flatpak $a\n"
    @. scripts/configure-flatpak.sh

# Configure Podman
[group('Debian only')]
configure-podman: install-apt-packages
    @printf "\n$a configure-podman $a\n"
    @. scripts/index.sh && \
        configure_podman

# Install APT packages
[group('Debian only')]
install-apt-packages: configure-apt
    @printf "\n$a install-apt-packages $a\n"
    @. scripts/apt.sh && \
        install_apt_packages 'apt/apt.dep'

#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#
#%# -- Regular Recipes --
#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#

# Display environment
[group('Information')]
display-environment:
    @printf "\n$a display-environment $a\n"
    @. scripts/index.sh && \
        display_environment

# Display versions
[group('Information')]
display-versions:
    @printf "\n$a display-versions $a\n"
    @. scripts/index.sh && \
        display_versions

# Install mise-en-place system
[group('Managers')]
install-mise:
    @printf "\n$a install-mise $a\n"
    @. scripts/index.sh && \
        install_mise

# Install gomplate for using JSON, YAML, & text templates
[group('Tools')]
install-gomplate: install-mise
    @printf "\n$a install-gomplate $a\n"
    mise use -g gomplate@latest

# Install storage tools
[group('Tools')]
install-tools-storage: install-mise
    @printf "\n$a install-tools-storage $a\n"
    mise use -g mc@latest

# Install VitePlus and Node.js, Gemini CLI
[group('Languages')]
[group('Managers')]
install-viteplus version="22":
    @printf "\n$a install-viteplus $a\n"
    @./scripts/install-viteplus.sh {{version}}

# Install Rust language using Rustup
[group('Languages')]
install-rust:
    @printf "\n$a install-rust $a\n"
    @. scripts/install-rust.sh && \
        install_rust

# Install Go language using mise
[group('Languages')]
install-go version="latest": install-mise
    @printf "\n$a install-go $a\n"
    mise plugins update
    mise use -g go@{{version}} && \
        eval "$(mise hook-env)" && \
        go version
    @# Pre-2026 way using Github backend # mise use github:tinygo-org/tinygo
    mise use -g tinygo@latest && \
        eval "$(mise hook-env)" && \
        tinygo version

# Install Ruby language using mise
[group('Languages')]
install-ruby version="sub-0.1:latest": install-mise
    @printf "\n$a install-ruby $a\n"
    mise settings ruby.compile=false # Precompiled ruby will be the default in 2026.8.0.
    # mise settings ruby.compile=1 # if precompiled has trouble
    mise use -g "ruby@{{version}}" && \
        eval "$(mise hook-env)" && \
        ruby --version

# Install Rails framework
[group('Frameworks')]
install-rails: install-ruby
    @printf "\n$a install-rails $a\n"
    @. scripts/index.sh && \
        install_rails

# Install uv, the Python package manager
[group('Managers')]
install-uv:
    @printf "\n$a install-uv $a\n"
    @. scripts/index.sh && \
        install_uv

# Install kubectl using mise
[group('Tools')]
install-kubectl version="latest": install-mise
    @printf "\n$a install-kubectl $a\n"
    @mise use -g kubectl@{{version}} && \
        eval "$(mise hook-env)" && \
        kubectl version --client

# Install Wasmer
[group('Tools')]
[group('Managers')]
install-wasmer: install-mise
    @printf "\n$a install-wasmer $a\n"
    @eval "$(mise hook-env)" && \
        mise use --global github:wasmerio/wasmer && \
        wasmer run syrusakbary/cowsay "WebAssembly rocks!"

# Install OpenJDK using mise
[group('Languages')]
[group('SDK')]
install-java version="21": install-mise
    @printf "\n$a install-java $a\n"
    @# microsoft- (MSFT) corretto- (Amazon) temurin- (Eclipse Adoptium) zulu- (Azul Systems) oracle- (Oracle) 
    mise use -g "java@temurin-{{version}}"

# Install Kotlin language using mise
[group('Languages')]
install-kotlin version="latest": install-java
    @printf "\n$a install-kotlin $a\n"
    mise use -g "kotlin@{{version}}"

# Install Scala language using mise
[group('Languages')]
install-scala version="latest": install-java
    @printf "\n$a install-scala $a\n"
    mise use -g "scala@{{version}}"
    mise use -g sbt@latest # Scala Build Tool

# Install Code
[group('IDE')]
install-code updates="code/argv.json":
    @printf "\n$a install-code $a\n"
    @. scripts/index.sh && \
        install_code {{updates}}

# Install Code extensions
[group('Managers')]
install-code-extensions extensions="code/code.dep": install-code
    @printf "\n$a install-code-extensions $a\n"
    @. scripts/index.sh && \
        install_code_extensions {{extensions}}

# Configure Code
[group('Tools')]
configure-code updates="code/user-settings.json": install-code-extensions install-viteplus
    @printf "\n$a configure-code $a\n"
    @. scripts/index.sh && \
        configure_code {{updates}}

#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#
#%# -- Regular Recipes : Fedora untested --
#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#

# Install Jekyll static site generator
[group('Frameworks')]
install-jekyll: install-ruby
    @printf "\n$a install-jekyll $a\n"
    @. scripts/index.sh && \
        install_jekyll

# Install homebrew packages
[group('Managers')]
install-homebrew-packages bundle="homebrew/debian.dep": install-homebrew
    @printf "\n$a install-homebrew-packages $a\n"
    @. scripts/index.sh && \
        install_homebrew_packages {{bundle}}
    # TODO: refactor function to use $OS_FAMILY version of .dep

# Install Homebrew
[group('Managers')]
install-homebrew:
    @printf "\n$a install-homebrew $a\n"
    @. scripts/index.sh && \
        install_homebrew

# Install Microsoft .NET SDK using mise
[group('Languages')]
[group('SDK')]
install-dotnet version="10": install-mise
    @printf "\n$a install-dotnet $a\n"
    mise use -g "dotnet@{{version}}"

# Install Haskell language
[group('Languages')]
install-haskell version="latest": install-mise install-apt-packages
    @printf "\n$a install-haskell $a\n"
    mise use -g "ghc@{{version}}"

# Install Erlang language
[group('Languages')]
install-erlang version="latest": install-mise install-apt-packages
    @printf "\n$a install-erlang $a\n"
    mise use -g "erlang@{{version}}"

# Install Elixir language using mise
[group('Languages')]
install-elixir version="latest": install-erlang
    @printf "\n$a install-elixir $a\n"
    mise use -g elixir@{{version}}

# Install Flutter toolkit using mise
[group('Languages')]
[group('SDK')]
install-flutter version="latest": install-mise
    @printf "\n$a install-flutter $a\n"
    mise use -g flutter@{{version}}

# Install Stockyard the LLM control plane
[group('AI')]
install-stockyard: install-mise
    @printf "\n$a install-stockyard $a\n"
    mise use -g github:stockyard-dev/Stockyard
    @# brew install stockyard-dev/tap/stockyard
    stockyard doctor

# Install Ollama
[group('AI')]
install-ollama version="latest": install-mise
    @printf "\n$a install-ollama $a\n"
    mise use -g ollama@{{version}}

# Install Goose IDE
[group('AI')]
[group('IDE')]
install-goose:
    @printf "\n$a install-goose $a\n"
    @. scripts/index.sh && \
        install_goose

# Install terminal tools
[group('Tools')]
install-tools-terminal shell="zsh": install-mise
    @printf "\n$a install-tools-terminal $a\n"
    @. scripts/index.sh && \
        install_terminal_tools {{shell}}

# Install a Nerd Font
[group('Tools')]
install-font id="JetBrainsMono" version="v3.3.0":
    @printf "\n$a install-font $a\n"
    @./scripts/install-font.sh  {{id}} {{version}}

# Install Ansible
[group('Tools')]
install-ansible: _install-ansible-from-uv display-environment
    @printf "\nAnsible CLI should be ready to use."

# Private: install Ansible using uv
_install-ansible-from-uv: install-uv
    @. scripts/index.sh && \
        install_using_uv_with_executables_from 'ansible' 'ansible-core,ansible-lint' 'localhost -m ping'

#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#
