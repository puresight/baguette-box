set dotenv-load := true
set shell := ["bash", "-c"]

export SCRIPTROOT := justfile_directory()
export BIN_DIR := home_dir() + "/.local/bin"

[default]
_:
    @just --list

#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#
# -- Tasty Recipes --
#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#

# Bootstrap the system
bootstrap:
    @echo
    @echo "-- bootstrap recipe --"
    @. scripts/index.sh &&\
        configure_apt apt &&\
        install_apt_packages 'apt/apt.dep' &&\
        install_uv &&\
        install_goose &&\
        install_dotnet 10 &&\
        configure_shell zsh pwsh &&\
        install_font JetBrainsMono 'v3.3.0' &&\
        install_terminal_tools zsh &&\
        install_rust &&\
        install_java 21 &&\
        install_mise &&\
        install_mise_tools &&\
        install_storage_tools &&\
        install_jekyll &&\
        install_rails &&\
        install_homebrew &&\
        brew_bundle 'homebrew.dep' &&\
        configure_flatpak &&\
        display_environment &&\
        display_versions
    @# install_using_uv_with_executables_from 'ansible' 'ansible-core,ansible-lint' 'localhost -m ping'
    @# configure_podman
    @echo 'Bootstrap complete. Remember to restart your shell environment before proceeding.'

# Install Ansible
ansible: _install-ansible-from-uv
    @echo
    @echo "-- ansible recipe --"
    @. scripts/index.sh &&\
        display_environment
    @echo 'The ansible CLI should be ready to use.'

# Install VS Code with custom settings and extensions
code:
    @echo
    @echo "-- code recipe --"
    @. scripts/index.sh &&\
        install_code &&\
        install_code_extensions &&\
        configure_code

#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#
# -- Tools & Languages --
#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#

# Install Ansible using uv. This is a private recipe.
_install-ansible-from-uv: install-uv
    @echo
    @. scripts/index.sh &&\
        install_using_uv_with_executables_from 'ansible' 'ansible-core,ansible-lint' 'localhost -m ping'

# Install eget for downloading GitHub releases
install-eget:
    @echo
    @echo "-- install-eget recipe --"
    @. scripts/index.sh &&\
        install_eget

# Install OpenJDK
install-java version="21":
    @echo
    @echo "-- install-java recipe --"
    @. scripts/index.sh &&\
        install_java "{{version}}"

# Install uv, the Python package manager
install-uv:
    @echo
    @echo "-- install-uv recipe --"
    @. scripts/index.sh &&\
        install_uv

#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#
