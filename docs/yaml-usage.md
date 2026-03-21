# Legacy YAML Usage

This document describes the legacy `box.sh` script and YAML-based execution model. This interface is slowly being phased out in favor of the newer modular `just` orchestration.

## YAML tasks

The config file you supply feeds box tasks to do.
Each task in sequence (with some arguments) will be executed (unless property `enabled` is `false`).

While the full understanding of each is found in inspecting the bash source of the lib functions that implement them, the following is a summary.

### `install_apt_packages`

1. Connects APT
   using DEB822
   to the repository sources in directory
   `apt`
1. Then runs `apt install`
   on packages listed in the `apt/apt.dep`

<!-- --

- Zsh shell
- Rclone is a tool for mounting nearly any cloud service as a local file system
- aws CLI ☁ tools
- gcloud CLI ☁ tools
- kubectl tool
- Github tools
- Google Antigravity AI IDE

<!-- -->

### `install_storage_tools`

installs utilities such as
MinIO Client (`mc`), a tool for managing files on S3-compatible cloud storage.

### `install_uv`

installs UV
(the unified tool for the Python ecosystem)
and Python.

### `install_using_uv_with_executables_from`

uses UV to install tool packages
(like Ansible).

### `configure_flatpak`

installs flatpak and adds the remote source for the Flathub app marketplace.

Flatpak is the preferred method for installing GUI applications on this system. This approach ensures applications run in isolated environments with their own dependencies, preventing conflicts with system libraries and keeping the host OS clean. It also provides access to the latest versions of applications regardless of the distribution's release cycle. Read the flatpak.md docs for more info.

### `install_mise`

installs **Mise** en place, a tool to manage installations of languages and tools for development. It is used to manage multiple versions of e.g. language runtimes. It manages

- Go language
- Node engine

### `install_mise_tools`

reads the `mise.toml` file in the root of the repository to install the specified tool versions. Mise manages:

- Go language
- Node engine (including npm)
- Ruby language (including RubyGems)

### `install_rails`

installs the Rails framework using Ruby

### `install_jekyll`

installs Jekyll using Ruby

### `install_goose`

installs Block's Goose AI CLI.

### `install_dotnet`

installs .NET

### `install_font`

installs a font needed by Posh

### `configure_shell`

changes the system's default shell to zsh (which was installed in the apt/apt.dep),
runs a _pwsh_ script to install Azure PowerShell
(aka `Az`) CLI.

And installs the Oh My Posh prompt
for the zsh and pwsh shells.

### `install_terminal_tools`

installs CLI tools like
fzf & zoxide

### `configure_podman`

configures Podman

### `install_rust`

installs Rust

### `install_java`

installs one of the Microsoft releases of OpenJDK Java.

### `install_homebrew`

installs (or updates)
Homebrew 🍺 software management system.

### `brew_bundle`

uses Homebrew to install packages in the `homebrew.dep` file

### `display_environment`

displays attributes of the system environment.

### `display_versions`

displays versions of some of the main installed tools,
especially languages or their package managers.

### `install_code`

installs and configures Code
with updates for its _argv.json_ settings file.

### `install_code_extensions`

installs the extensions
of Code listed in the
`code/code.dep` file.

_To maintain workstation integrity, only install extensions from reputable & verified authors that regularly address issues with code updates._

### `configure_code`

updates (doing a shallow merge) Code's user settings.json file.
It uses `jq` and Node/npm module `jsonc-cli`.

_Unfortunately (as a consequence of implementation), it erases the comments that were in them._