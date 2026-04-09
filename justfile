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
#%# -- Featured Recipes --
#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#

# Bootstrap the Debian system
[group('Debian only')]
[group('* * * Featured * * *')]
bootstrap-debian: _check-online install-apt-packages configure-shell install-uv install-viteplus display-environment display-versions
    @printf "\nRemember to restart your shell environment before proceeding.\n"

# Install VS Code with settings & extensions
[group('* * * Featured * * *')]
code: _check-online configure-code
    @printf "✓ code "
    @code --version

# For test purposes only
[group('Test')]
_test-debian: _check-online install-apt-packages configure-shell install-dotnet install-tools-terminal install-mc configure-flatpak install-homebrew install-rust install-uv install-java install-kubectl install-viteplus install-go install-ruby install-jekyll install-rails install-goose install-ansible display-environment display-versions
    @printf "\nRemember to restart your shell environment before proceeding.\n"

# For test purposes only
[group('Test')]
_test-ublue: _check-online _check-fedora install-homebrew install-homebrew-packages install-mise install-gomplate install-mc install-uv install-wasmer install-stockyard install-java install-kotlin install-scala install-go install-rust install-ruby install-rails  install-viteplus display-environment display-versions
    @printf "\nRemember to restart your shell environment before proceeding.\n"

#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#
#%# -- Regular Recipes : Fedora untested --
#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#

# Install Jekyll static site generator
[group('Frameworks')]
install-jekyll: install-ruby
    @printf "\n$a install-jekyll $a\n"
    @./scripts/install-jekyll.sh

# Install Microsoft .NET SDK using mise
[group('Languages')]
[group('SDK')]
install-dotnet version="10": install-mise
    @printf "\n$a install-dotnet $a\n"
    mise use -g "dotnet@{{version}}"

# Install Haskell language using mise
[group('Languages')]
install-haskell version="latest": install-mise install-apt-packages
    @printf "\n$a install-haskell $a\n"
    mise use -g "ghc@{{version}}"

# Install Erlang language using mise
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

# Install Stockyard.dev, the LLM control plane
[group('AI')]
install-stockyard: install-mise
    #!/bin/bash
    printf "\n$a install-stockyard $a\n"
    mise use -g github:stockyard-dev/Stockyard
    # brew install stockyard-dev/tap/stockyard
    stockyard doctor

# Install Ollama
[group('AI')]
install-ollama version="0.20.2": install-mise
    @printf "\n$a install-ollama $a\n"
    mise use -g ollama@{{version}}

# Compile & install llmfit to find compatible local models
[group('Tools')]
[group('AI')]
install-llmfit: install-rust
    #!/bin/bash
    printf "\n$a install-llmfit $a\n"
    # Install llmfit by compiling it from source using cargo.
    # This ensures it's linked against the system's GLIBC, avoiding compatibility issues.
    cargo install llmfit
    eval "$(mise hook-env)"
    printf "✓ "
    llmfit --version

# Install Goose IDE
[group('AI')]
[group('IDE')]
install-goose:
    @printf "\n$a install-goose $a\n"
    @./scripts/install-goose.sh

# Install terminal tools
[group('Tools')]
install-tools-terminal: install-mise
    @printf "\n$a install-tools-terminal $a\n"
    @./scripts/install-terminal-tools.sh

# Install a Nerd Font
[group('Tools')]
install-font id="JetBrainsMono" version="v3.3.0":
    @printf "\n$a install-font $a\n"
    @./scripts/install-font.sh  {{id}} {{version}}

# Install Ansible
[group('Tools')]
install-ansible:
    @printf "\n$a install-ansible $a\n"
    @. scripts/lib/uv.sh && \
        install_using_uv_with_executables_from 'ansible' 'ansible-core,ansible-lint' 'localhost -m ping'

#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#
#%# -- Regular Recipes : Debian Only --
#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#

# Check Debian APT
[group('Debian only')]
_check-debian:
    @printf "\n$a _check-debian $a\n"
    @./scripts/check-apt.sh

# TODO Refactor function configure_shell to remove dependency on install-dotnet
# Configure shells
[group('Debian only')]
configure-shell: install-apt-packages install-font install-dotnet
    @printf "\n$a configure-shell $a\n"
    @./scripts/configure-shell.sh

# Configure Flatpak
[group('Debian only')]
configure-flatpak: install-apt-packages
    @printf "\n$a configure-flatpak $a\n"
    @./scripts/configure-flatpak.sh

# Configure Podman
[group('Debian only')]
configure-podman-chromeos: install-apt-packages
    @printf "\n$a configure-podman-chromeos $a\n"
    @./scripts/configure-podman-chromeos.sh

# Configure APT sources
[group('Debian only')]
configure-apt: _check-debian install-gomplate
    @printf "\n$a configure-apt $a\n"
    @./scripts/configure-apt.sh

# Install APT packages
[group('Debian only')]
install-apt-packages: configure-apt
    @printf "\n$a install-apt-packages $a\n"
    @./scripts/install-apt-packages.sh 'apt/apt.Packages'

#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#
#%# -- Regular Recipes --
#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#

# Check Online
_check-online:
    #!/bin/bash
    (timeout 2 bash -c 'exec 3<>/dev/tcp/detectportal.firefox.com/80') 2>/dev/null # Assumed: Firefox still operates its captive portal website
    if [ $? -ne 0 ]; then
        printf "\n❌ Error: disconnected from the Internet. Check your connection and try again.\n\n" >&2
        exit 1
    fi

# Display environment
[group('Information')]
display-environment:
    @printf "\n$a display-environment $a\n"
    @./scripts/display-environment.sh

# Display versions
[group('Information')]
display-versions:
    @printf "\n$a display-versions $a\n"
    @./scripts/display-versions.sh

# Install Homebrew
[group('Managers')]
install-homebrew:
    @printf "\n$a install-homebrew $a\n"
    @./scripts/install-homebrew.sh

# Install homebrew packages
[group('Managers')]
install-homebrew-packages: install-homebrew
    @printf "\n$a install-homebrew-packages $a\n"
    @./scripts/install-homebrew-packages.sh

# Install mise-en-place system
[group('Managers')]
install-mise:
    @printf "\n$a install-mise $a\n"
    @./scripts/install-mise.sh

# Install gomplate for using JSON, YAML, & text templates
[group('Tools')]
install-gomplate: install-mise
    @printf "\n$a install-gomplate $a\n"
    mise use -g gomplate@latest

# Install storage tools
[group('Tools')]
install-mc: install-mise
    @printf "\n$a install-mc $a\n"
    mise use -g mc@latest

# Install VitePlus and Node
[group('Languages')]
[group('Managers')]
install-viteplus version="22":
    @printf "\n$a install-viteplus $a\n"
    @./scripts/install-viteplus.sh {{version}}

# Install Gemini CLI
[group('AI')]
install-gemini: install-viteplus
    #!/bin/bash
    printf "\n$a install-gemini $a\n"
    if ! command -v gemini &>/dev/null; then
        echo "Installing Gemini CLI globally..."
        vp install -g @google/gemini-cli
    fi
    printf "✓ gemini "
    gemini --version 2>/dev/null | tail -n 1

# Install OpenAI Codex CLI
[group('AI')]
install-codex: install-viteplus
    #!/bin/bash
    printf "\n$a install-codex $a\n"
    if ! command -v codex &>/dev/null; then
        echo "Installing OpenAI Codex CLI globally..."
        vp install -g @openai/codex
    fi
    printf "✓ "
    codex --version

# Install Anthropic Claude Code CLI
[group('AI')]
install-claude-code: install-viteplus
    #!/bin/bash
    printf "\n$a install-claude-code $a\n"
    if ! command -v claude-code &>/dev/null; then
        echo "Installing Anthropic Claude Code CLI globally..."
        vp install -g @anthropic-ai/claude-code
    fi
    printf "✓ "
    claude --version

# Install Rust language using Rustup
[group('Languages')]
install-rust:
    @printf "\n$a install-rust $a\n"
    @./scripts/install-rust.sh

# Install Go language using mise
[group('Languages')]
install-go version="latest": install-mise
    #!/bin/bash
    printf "\n$a install-go $a\n"
    mise plugins update
    mise use -g go@{{version}} && \
        eval "$(mise hook-env)" && \
        go version
    # Pre-2026 way using Github backend # mise use github:tinygo-org/tinygo
    mise use -g tinygo@latest && \
        eval "$(mise hook-env)" && \
        tinygo version

# Install Ruby language using mise
[group('Languages')]
install-ruby version="sub-0.1:latest": install-mise
    #!/bin/bash
    printf "\n$a install-ruby $a\n"
    mise settings ruby.compile=false  # Precompiled ruby will be the default in 2026.8.0.
    # mise settings ruby.compile=1    # if precompiled has trouble
    mise use -g "ruby@{{version}}"
    eval "$(mise hook-env)"
    printf "✓ "
    ruby --version

# Install Rails framework
[group('Frameworks')]
install-rails: install-ruby
    @printf "\n$a install-rails $a\n"
    @./scripts/install-rails.sh

# Install uv, the Python package manager
[group('Languages')]
[group('Managers')]
install-uv:
    @printf "\n$a install-uv $a\n"
    @./scripts/install-uv.sh

# Install kubectl using mise
[group('Tools')]
install-kubectl version="latest": install-mise
    #!/bin/bash
    printf "\n$a install-kubectl $a\n"
    mise use -g kubectl@{{version}} && \
        eval "$(mise hook-env)" && \
        kubectl version --client

# Install Wasmer
[group('Tools')]
[group('Managers')]
install-wasmer: install-mise
    #!/bin/bash
    printf "\n$a install-wasmer $a\n"
    eval "$(mise hook-env)" && \
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
    #!/bin/bash
    printf "\n$a install-scala $a\n"
    mise use -g "scala@{{version}}"
    mise use -g sbt@latest # Scala Build Tool

# Install Code
[group('IDE')]
install-code updates="code/argv.json":
    @printf "\n$a install-code $a\n"
    @./scripts/install-code.sh {{updates}}

# Install Code extensions
[group('Managers')]
install-code-extensions extensions="code/code.Extensions": install-code
    @printf "\n$a install-code-extensions $a\n"
    @./scripts/install-code-extensions.sh {{extensions}}

# Configure Code
[group('Tools')]
configure-code updates="code/user-settings.json": install-code-extensions install-viteplus
    @printf "\n$a configure-code $a\n"
    @./scripts/configure-code.sh {{updates}}

#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#

# Check Fedora RPM
[group('Fedora only')]
_check-fedora:
    @printf "\n$a _check-fedora $a\n"
    @./scripts/check-rpm.sh
