_This is beta quality code so backup before using, read the docs, and scan the source before running._

To maintain workstation integrity, only install code from reputable & verified authors that regularly address issues with code updates.

## How to Run

1. **For IT professionals using Ansible:** (Optional) Install the latest uv, python, & [ansible](https://pypi.org/project/ansible/)  
   Run `./box.sh ansible.yaml --install`  

1. **Bootstrap your system:** Install your shell, core language runtimes, system-level fixes, etc  
   Run `./box.sh system.yaml --install`  
   Restart your shell: `exit` and reopen the terminal tab.

1. **Code:** Install VS Code with settings and extensions  
   Run `./box.sh code.yaml --install`

This program is idempotent. You can run it again anytime.

## System Architecture

Every piece of software you install must be able to receive updates for
bugs or security vulnerabilities. It is always best to pick a
package management system to help with the lifecycle of each program
that you want on your machine. We use several including

- [APT](./apt/README.md) is Debian's Advanced Package Tool
- [Flatpak](./flatpak.md) is the preferred method for installing GUI apps
- [Homebrew](http://docs.brew.sh/Homebrew-on-Linux)
- [Mise](https://mise.jdx.dev/) for Node, Go
- [uv](./docs/uv.md) is a fast Python package manager
- [npm](./docs/node.md) is the default Node package manager
- [Rustup](https://rustup.rs/) for Rust

These tools are significant to the project:

- [Eget](https://github.com/zyedidia/eget?tab=readme-ov-file#readme) to download/verify/install releases from GitHub
- [Gomplate](https://docs.gomplate.ca/) is a template rendering engine supporting JSON & YAML

## YAML tasks

The config file you supply feeds box tasks to do.
Each task in sequence (with some arguments) will be executed (unless property `enabled` is `false`).

While the full understanding of each is found in inspecting the bash source of the lib functions that implement them, the following is a summary.

### `install_apt_packages`

1. Connects [APT](https://wiki.debian.org/AptCLI)
   using [DEB822](https://repolib.readthedocs.io/en/latest/deb822-format.html)
   to the repository [sources](https://wiki.debian.org/SourcesList) in directory
   [`apt`](../apt/README.md)
1. Then runs `apt install`
   on packages listed in the [`apt/apt.dep`](../apt/apt.dep)

<!-- --

- [Zsh](https://zsh.sourceforge.io/) shell
- [Rclone](.//rclone.md) is a tool for mounting nearly any cloud service as a local file system
- [aws CLI](https://docs.aws.amazon.com/cli/) ☁ tools
- [gcloud CLI](https://cloud.google.com/cli) ☁ tools
- [kubectl](https://kubernetes.io/docs/reference/kubectl/) tool
- [Github](https://cli.github.com/) tools
- [Google Antigravity](https://antigravity.google/) AI IDE

<!-- -->

### `install_storage_tools`

installs utilities such as
[MinIO Client](./docs/mc.md) (`mc`), a tool for managing files on S3-compatible cloud storage.

### `install_uv`

installs [UV](.//uv.md)
(the unified tool for the Python ecosystem)
and Python.

### `install_using_uv_with_executables_from`

uses [UV](.//uv.md) to install tool packages
(like [Ansible](https://docs.ansible.com/)).

### `configure_flatpak`

installs flatpak and adds the remote source for the Flathub app marketplace.

[Flatpak](./flatpak.md) is the preferred method for installing GUI applications on this system. This approach ensures applications run in isolated environments with their own dependencies, preventing conflicts with system libraries and keeping the host OS clean. It also provides access to the latest versions of applications regardless of the distribution's release cycle. Read the [flatpak.md](./flatpak.md) docs for more info.

### `install_mise`

installs **[Mise](./mise.md)** en place, a tool to manage installations of languages and tools for development. It is used to manage multiple versions of e.g. language runtimes. It manages

- [Go](https://go.dev/) language
- [Node](https://nodejs.org/) engine

### `install_mise_tools`

reads the `mise.toml` file in the root of the repository to install the specified tool versions. [Mise](./mise.md) manages:

- [Go](./go.md) language
- [Node](./node.md) engine (including npm)
- [Ruby](./ruby.md) language (including RubyGems)

### `install_rails`

installs the Rails framework using [Ruby](./ruby.md)

### `install_jekyll`

installs Jekyll using [Ruby](./ruby.md)

### `install_goose`

installs Block's [Goose](https://block.github.io/goose/docs/category/guides) AI CLI.

### `install_dotnet`

installs [.NET](./dotnet.md)

### `install_font`

installs a [font](./fonts.md) needed by Posh

### `configure_shell`

changes the system's default shell to zsh (which was installed in the apt/apt.dep),
runs a _pwsh_ script to install [Azure PowerShell](https://learn.microsoft.com/en-us/powershell/azure/)
(aka [`Az`](https://www.powershellgallery.com/packages/az)) CLI.

And installs the [Oh My Posh](https://ohmyposh.dev/) prompt
for the zsh and pwsh shells.

### `install_terminal_tools`

installs [CLI tools](./cli-tools.md) like
[fzf](https://junegunn.github.io/fzf/) & [zoxide](https://zoxide.org/)

### `configure_podman`

configures [Podman](.//podman.md)

### `install_rust`

installs [Rust](./rust.md)

### `install_java`

installs one of the Microsoft releases of OpenJDK [Java](.//java.md).

### `install_homebrew`

installs (or updates)
[Homebrew](http://docs.brew.sh/Homebrew-on-Linux) 🍺 software management system.

### `brew_bundle`

uses Homebrew to install packages in the [`homebrew.dep`](./homebrew.dep) file

### `display_environment`

displays attributes of the system environment.

### `display_versions`

displays versions of some of the main installed tools,
especially languages or their package managers.

### `install_code`

installs and configures [Code](../code/README.md)
with updates for its _argv.json_ settings file.

### `install_code_extensions`

installs the extensions
of [Code](../code/README.md) listed in the
[`code/code.dep`](../code/code.dep) file.

_To maintain workstation integrity, only install extensions from reputable & verified authors that regularly address issues with code updates._

### `configure_code`

updates (doing a shallow merge) Code's user settings.json file.
It uses `jq` and Node/npm module `jsonc-cli`.

_Unfortunately (as a consequence of implementation), it erases the comments that were in them._
