# Docs

To maintain workstation integrity, only install code from reputable & verified authors that regularly address issues with code updates.

## How to Run Recipes

To view the full menu type `just`

1. Bootstrap your new system: `just bootstrap`
1. Install VS Code: `just code`

Our recipes are idempotent, so you can run them again, anytime.

## System Architecture

Every piece of software you install must be able to receive updates for
bugs or security vulnerabilities. It is always best to pick a
package management system to help with the lifecycle of each program
that you want on your machine. We use several including

- [APT](./apt/README.md) is Debian's Advanced Package Tool
- [Flatpak](./flatpak.md) for installing GUI apps
- [Homebrew](../homebrew/README.md) for [Aider](./aider.md)
- [Rustup](./rust.md) for Rust
- [uv](./docs/uv.md) is the Python package manager
- [Mise](./mise.md) en place for [Node](./node.md), [Go](./go.md), [Ruby](./ruby.md)
- [npm](./docs/node.md) is the default Node package manager

These tools are significant to the project internals:

- [Eget](https://github.com/zyedidia/eget?tab=readme-ov-file#readme) to download/verify/install releases from GitHub
- [Gomplate](https://docs.gomplate.ca/) is a template rendering engine supporting JSON & YAML

## Recipes

Find the [just](./just.md) recipe definitions in the [justfile](../justfile).
While precise understanding is in inspecting the bash source of the [scripts](../scripts) that implement them, here is a summary.

### High Level Recipes

High level recipes combine many regular recipes to accomplish an objective for overall system configuration.

#### `bootstrap`

Bootstrap your new system.

#### `code`

Install VS Code.

#### `ansible`

uses [UV](.//uv.md) to install [Ansible](https://docs.ansible.com/)

### Regular Recipes

Regular recipes perform specific & granular tasks for system configuration.

#### `install-apt-packages`

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

#### `install-storage-tools`

installs utilities such as
[MinIO Client](./docs/mc.md) (`mc`), a tool for managing files on S3-compatible cloud storage.

#### `install-uv`

installs [UV](.//uv.md)
(the unified tool for the Python ecosystem)
and Python.

#### `configure-flatpak`

installs flatpak and adds the remote source for the Flathub app marketplace.

[Flatpak](./flatpak.md) is the preferred method for installing GUI applications on this system. This approach ensures applications run in isolated environments with their own dependencies, preventing conflicts with system libraries and keeping the host OS clean. It also provides access to the latest versions of applications regardless of the distribution's release cycle. Read the [flatpak.md](./flatpak.md) docs for more info.

#### `install-mise`

installs **[Mise](./mise.md)** en place, a tool to manage installations of languages and tools for development. It is used to manage multiple versions of e.g. language runtimes. It manages

- [Go](https://go.dev/) language
- [Node](https://nodejs.org/) engine

#### `install-mise-tools`

reads the `mise.toml` file in the root of the repository to install the specified tool versions. [Mise](./mise.md) manages:

- [Go](./go.md) language
- [Node](./node.md) engine (including npm)
- [Ruby](./ruby.md) language (including RubyGems)

#### `install-rails`

installs the Rails framework using [Ruby](./ruby.md)

#### `install-jekyll`

installs Jekyll using [Ruby](./ruby.md)

#### `install-goose`

installs Block's [Goose](https://block.github.io/goose/docs/category/guides) AI CLI.

#### `install-dotnet`

installs [.NET](./dotnet.md)

#### `install-font`

installs a [font](./fonts.md) needed by Posh

#### `configure-shell`

changes the system's default shell to zsh (which was installed in the apt/apt.dep),
runs a _pwsh_ script to install [Azure PowerShell](https://learn.microsoft.com/en-us/powershell/azure/)
(aka [`Az`](https://www.powershellgallery.com/packages/az)) CLI.

And installs the [Oh My Posh](https://ohmyposh.dev/) prompt
for the zsh and pwsh shells.

#### `install-terminal-tools`

installs [CLI tools](./cli-tools.md) like
[fzf](https://junegunn.github.io/fzf/) & [zoxide](https://zoxide.org/)

#### `configure-podman`

configures [Podman](.//podman.md)

#### `install-rust`

installs [Rust](./rust.md)

#### `install-java`

installs one of the Microsoft releases of OpenJDK [Java](.//java.md).

#### `install-homebrew`

installs (or updates)
[Homebrew](http://docs.brew.sh/Homebrew-on-Linux) 🍺 software management system.

#### `install-homebrew-packages`

uses Homebrew to install packages in the [`homebrew/homebrew.dep`](./homebrew.dep) file

#### `display-environment`

displays attributes of the system environment.

#### `display-versions`

displays versions of some of the main installed tools,
especially languages or their package managers.

#### `install-code`

installs and configures [Code](../code/README.md)
with updates for its _argv.json_ settings file.

#### `install-code-extensions`

installs the extensions
of [Code](../code/README.md) listed in the
[`code/code.dep`](../code/code.dep) file.

To maintain workstation integrity, only install extensions from reputable & verified authors that regularly address issues with code updates.

#### `configure-code`

updates (doing a shallow merge) Code's user settings json file.
It uses `jq` and Node/npm module `jsonc-cli`.

Unfortunately as a consequence of implementation, it erases the comments that were in them.
