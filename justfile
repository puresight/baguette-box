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
bootstrap-max: install-apt-packages configure-shell install-dotnet install-tools-terminal install-tools-storage configure-flatpak install-homebrew install-rust install-uv install-java install-kubectl install-viteplus install-go install-ruby install-jekyll install-rails install-goose install-ansible configure-podman display-environment display-versions
    @printf "\nRemember to restart your shell environment before proceeding.\n"

# Bootstrap the system
bootstrap: install-apt-packages configure-shell install-uv install-viteplus display-environment display-versions
    @printf "\nRemember to restart your shell environment before proceeding.\n"

# Install VS Code w/ custom settings & extensions
code: configure-code
    @printf "\nVS Code is ready to use.\n"

#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#
#%# -- Regular Recipes : Debian Only --
#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#

# Check Debian APT
check-apt:
    @printf "\n$a check-apt $a\n"
    ./scripts/check-apt.sh

# Configure APT sources
configure-apt: check-apt install-gomplate
    @printf "\n$a configure-apt $a\n"
    ./scripts/apt.sh

# TODO Refactor function configure_shell to remove dependency on install-dotnet
# Configure shells
configure-shell: install-apt-packages install-font install-dotnet
    @printf "\n$a configure-shell $a\n"
    @. scripts/index.sh && \
        configure_shell zsh pwsh

# Configure Flatpak
configure-flatpak: install-apt-packages
    @printf "\n$a configure-flatpak $a\n"
    @. scripts/configure-flatpak.sh

# Configure Podman
configure-podman: install-apt-packages
    @printf "\n$a configure-podman $a\n"
    @. scripts/index.sh && \
        configure_podman

# Install APT packages
install-apt-packages: configure-apt
    @printf "\n$a install-apt-packages $a\n"
    @. scripts/apt.sh && \
        install_apt_packages 'apt/apt.dep'

#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#
#%# -- Regular Recipes --
#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#

# Display environment
display-environment:
    @printf "\n$a display-environment $a\n"
    @. scripts/index.sh && \
        display_environment

# Display versions
display-versions:
    @printf "\n$a display-versions $a\n"
    @. scripts/index.sh && \
        display_versions

# Install gomplate for using JSON, YAML, & text templates
install-gomplate: install-mise
    @printf "\n$a install-gomplate $a\n"
    mise use -g gomplate@latest

# Install storage tools
install-tools-storage: install-mise
    @printf "\n$a install-tools-storage $a\n"
    mise use -g mc@latest

# Install VitePlus and Node.js, Gemini CLI
install-viteplus version="22":
    @printf "\n$a install-viteplus $a\n"
    @./scripts/install-viteplus.sh {{version}}

# Install Rust language using Rustup
install-rust:
    @printf "\n$a install-rust $a\n"
    @. scripts/install-rust.sh && \
        install_rust

# Install uv, the Python package manager
install-uv:
    @printf "\n$a install-uv $a\n"
    @. scripts/index.sh && \
        install_uv

# Install Wasmer
install-wasmer: install-mise
    @printf "\n$a install-wasmer $a\n"
    @eval "$(mise hook-env)" && \
        mise use --global github:wasmerio/wasmer && \
        wasmer run syrusakbary/cowsay "WebAssembly rocks!"

# Install Code
install-code updates="code/argv.json":
    @printf "\n$a install-code $a\n"
    @. scripts/index.sh && \
        install_code {{updates}}

# Install Code extensions
install-code-extensions extensions="code/code.dep": install-code
    @printf "\n$a install-code-extensions $a\n"
    @. scripts/index.sh && \
        install_code_extensions {{extensions}}

# Configure Code
configure-code updates="code/user-settings.json": install-code-extensions install-viteplus
    @printf "\n$a configure-code $a\n"
    @. scripts/index.sh && \
        configure_code {{updates}}

#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#
#%# -- Regular Recipes : Fedora untested --
#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#

# Install homebrew packages
install-homebrew-packages bundle="homebrew/homebrew.dep": install-homebrew
    @printf "\n$a install-homebrew-packages $a\n"
    @. scripts/index.sh && \
        install_homebrew_packages {{bundle}}

# Install Homebrew
install-homebrew:
    @printf "\n$a install-homebrew $a\n"
    @. scripts/index.sh && \
        install_homebrew

# Install mise-en-place system
install-mise:
    @printf "\n$a install-mise $a\n"
    @. scripts/index.sh && \
        install_mise

# Install kubectl using mise
install-kubectl version="latest": install-mise
    @printf "\n$a install-kubectl $a\n"
    mise use -g "kubectl@{{version}}"

# Install Go language using mise
install-go version="sub-0.0.1:latest": install-mise
    @printf "\n$a install-go $a\n"
    mise use -g go@{{version}}
    @mise plugins add tinygo https://github.com/mritd/asdf-tinygo.git
    mise use -g tinygo@{{version}}

# Install Ruby language using mise
install-ruby version="sub-0.1:latest": install-mise
    @printf "\n$a install-ruby $a\n"
    mise use -g "ruby@{{version}}"

# Install Jekyll static site generator
install-jekyll: install-ruby
    @printf "\n$a install-jekyll $a\n"
    @. scripts/index.sh && \
        install_jekyll

# Install Rails framework
install-rails: install-ruby
    @printf "\n$a install-rails $a\n"
    @. scripts/index.sh && \
        install_rails

# Install Microsoft .NET SDK using mise
install-dotnet version="10": install-mise
    @printf "\n$a install-rails $a\n"
    mise use -g "dotnet@{{version}}"

# Install OpenJDK using mise
install-java version="21": install-mise
    @printf "\n$a install-java $a\n"
    @# microsoft- (MSFT) corretto- (Amazon) temurin- (Eclipse Adoptium) zulu- (Azul Systems) oracle- (Oracle) 
    mise use -g "java@temurin-{{version}}"

# Install Kotlin language using mise
install-kotlin version="latest": install-java
    @printf "\n$a install-kotlin $a\n"
    mise use -g "kotlin@{{version}}"

# Install Scala language using mise
install-scala version="latest": install-java
    @printf "\n$a install-scala $a\n"
    mise use -g "scala@{{version}}"
    mise use -g sbt@latest # Scala Build Tool

# Install Haskell language
install-haskell version="latest": install-mise install-apt-packages
    @printf "\n$a install-haskell $a\n"
    mise use -g "ghc@{{version}}"

# Install Erlang language
install-erlang version="latest": install-mise install-apt-packages
    @printf "\n$a install-erlang $a\n"
    mise use -g "erlang@{{version}}"

# Install Elixir language using mise
install-elixir version="latest": install-erlang
    @printf "\n$a install-elixir $a\n"
    mise use -g elixir@{{version}}

# Install Flutter toolkit using mise
install-flutter version="latest": install-mise
    @printf "\n$a install-flutter $a\n"
    mise use -g flutter@{{version}}

# Install Ollama
install-ollama version="latest": install-mise
    @printf "\n$a install-ollama $a\n"
    mise use -g ollama@{{version}}

# Install Goose IDE
install-goose:
    @printf "\n$a install-goose $a\n"
    @. scripts/index.sh && \
        install_goose

# Install terminal tools
install-tools-terminal shell="zsh": install-mise
    @printf "\n$a install-tools-terminal $a\n"
    @. scripts/index.sh && \
        install_terminal_tools {{shell}}

# Install a Nerd Font
install-font id="JetBrainsMono" version="v3.3.0":
    @printf "\n$a install-font $a\n"
    @./scripts/install-font.sh  {{id}} {{version}}

# Install Ansible
install-ansible: _install-ansible-from-uv display-environment
    @printf "\nAnsible CLI should be ready to use."

# Private: install Ansible using uv
_install-ansible-from-uv: install-uv
    @. scripts/index.sh && \
        install_using_uv_with_executables_from 'ansible' 'ansible-core,ansible-lint' 'localhost -m ping'

#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#
