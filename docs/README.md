# Docs

_This is beta quality code so backup before using, read the docs, and scan the source before running._

To maintain workstation integrity, only install code from reputable & verified authors that regularly address issues with code updates.

## How to Use

1. **Minimal for Ansible:** Install the latest uv, python, & ansible  
   Run `./box.sh minimal.yaml --install`  
   Restart your shell: `exit` and reopen the terminal tab.

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

- [APT](https://wiki.debian.org/AptCLI) is Debian's Advanced Package Tool
- [Flatpak](./flatpak.md) is the preferred method for installing GUI apps
- [Homebrew](http://docs.brew.sh/Homebrew-on-Linux)
- [Mise](https://mise.jdx.dev/) for Node, Go
- [uv](./docs/uv.md) is a fast Python package manager
- [npm](./docs/node.md) is the default Node package manager
- [Rustup](https://rustup.rs/) for Rust

## YAML tasks

The config file you supply feeds box tasks to do.
Each task in sequence (with some arguments) will be executed (unless property `enabled` is `false`).

While the full understanding of each is found in inspecting the bash source of the lib functions that implement them, the following is a summary.

### `install_apt_packages`

connects [APT](https://wiki.debian.org/AptCLI)
using [DEB822](https://repolib.readthedocs.io/en/latest/deb822-format.html)
to these repository [sources](https://wiki.debian.org/SourcesList) &mdash;

- [Google Cloud CLI](https://docs.cloud.google.com/sdk/docs/install-sdk#deb) `google-cloud` <packages.cloud.google.com/apt>
- [Google Antigravity](https://antigravity.google/) `antigravity` <us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/>
- [Azure Cloud CLI](https://learn.microsoft.com/en-us/cli/azure/) `azure-cli` <packages.microsoft.com/repos/azure-cli/>
- [Github CLI](https://cli.github.com/) `github-cli` <cli.github.com/packages>
- [Microsoft prod](https://learn.microsoft.com/en-us/linux/packages) `microsoft-prod` <packages.microsoft.com/debian/12/prod>
- [VS Code](https://code.visualstudio.com/docs/setup/linux#_debian-and-ubuntu-based-distributions) `vscode` <packages.microsoft.com/repos/code>

> Advanced Package Tool (APT) is the primary software management system
> used in Debian-based Linux systems to manage software packages.
> It automates installing, upgrading, and removing software, including handling dependencies.
> It relies on the `/etc/apt/sources.list.d` directory to locate release package repositories.

It also runs _apt install_ on packages listed in the _Aptfile_ like

- [Zsh](https://zsh.sourceforge.io/) shell
- [Rclone](.//rclone.md) is a tool for mounting nearly any cloud service as a local file system
- [SQLite 3 CLI](https://www.sqlite.org/) that allows you to manually run SQL queries, create tables, and manage database files
- [PostgreSQL CLI](https://www.postgresql.org/docs/current/reference-client.html) has `psql`, `pgdump`, `createdb` clients for Postgres
- [MariaDB CLI](https://mariadb.com/docs/server/clients-and-utilities/mariadb-client) shell for MySQL-compatible servers
- [Redis CLI](https://redis.io/docs/latest/develop/tools/) tools for sending commands to the server
- [aws CLI](https://docs.aws.amazon.com/cli/) ☁ tools
- [gcloud CLI](https://cloud.google.com/cli) ☁ tools
- [kubectl](https://kubernetes.io/docs/reference/kubectl/) tool
- [Github](https://cli.github.com/) tools
- [Google Antigravity](https://antigravity.google/) AI IDE

### `install_yamljson`

installs dependencies needed by the system to work with JSON or YAML text files

- `yq` is installed by this task
- `jq` was defined in the _Aptfile_.

### `install_storage_tools`

installs utilities such as
[MinIO Client](https://github.com/minio/mc) `mc` a tool for managing files on Amazon S3-compatible cloud storage.

### `install_uv`

installs [UV](.//uv.md),
the unified tool for the Python ecosystem.
And [Python](https://www.python.org/).

### `install_flatpak`

installs flatpak and adds the remote source for the Flathub app marketplace.

[Flatpak](./flatpak.md) is the preferred method for installing GUI applications on this system. This approach ensures applications run in isolated environments with their own dependencies, preventing conflicts with system libraries and keeping the host OS clean. It also provides access to the latest versions of applications regardless of the distribution's release cycle. Read the [flatpak.md](./flatpak.md) docs for more info.

### `install_mise`

installs **[Mise](./mise.md)** en place, a tool to manage installations of languages and tools for development. It is used to manage multiple versions of e.g. language runtimes.

### `install_mise_tools`

reads the `mise.toml` file in the root of the repository to install the specified tool versions. [Mise](./mise.md) manages:

- [Go](./go.md) language
- [Node](./node.md) engine (including npm)
- [Ruby](./ruby.md) language (including RubyGems)

### `install_rails`

using [RubyGems](https://guides.rubygems.org/command-reference/), installs [Rails](https://guides.rubyonrails.org/getting_started.html).

### `install_goose`

installs Block's [Goose](https://block.github.io/goose/docs/category/guides) AI CLI.

### `install_dotnet`

installs a Microsoft [.NET](https://dotnet.microsoft.com/) SDK release e.g.
[10](https://learn.microsoft.com/en-us/dotnet/core/whats-new/dotnet-10/overview).
And installs the [Powershell](https://learn.microsoft.com/en-us/powershell/) shell.

### `configure_shell`

changes the system's default shell to zsh (which was installed in the Aptfile),
runs a _pwsh_ script to install [Azure PowerShell](https://learn.microsoft.com/en-us/powershell/azure/)
(aka [`Az`](https://www.powershellgallery.com/packages/az)) CLI.

And installs the [Oh My Posh](https://ohmyposh.dev/) prompt
for the zsh and pwsh shells.

### `install_font`

installs a [Nerd Font](https://www.nerdfonts.com/font-downloads)
on the system, e.g. JetBrainsMono v3.3.0;
it neither updates nor remove fonts.

### `configure_podman`

configures [Podman](.//podman.md).

### `install_rust`

uses [Rustup](https://rustup.rs/) to install the [Rust](https://rust-lang.org/) language.

And adds [cargo-binstall](https://github.com/cargo-bins/cargo-binstall) tool for quick package installation. Because the standard _cargo install_ command downloads source code and compiles it on your machine, which can be slow. So to bypass this and install pre-compiled binaries, use the community-standard tools like cargo-binstall. This is the most popular method. it automatically searches for pre-compiled releases on GitHub or other registries. Usage: Replace `cargo install <package>` with `cargo binstall <package>`

- 📖 [2024/11 Ben Brandt: A Better Cargo Install Workflow: How I manage to keep the tools I've installed with cargo up-to-date](https://benjaminbrandt.com/a-better-cargo-install-workflow/)
- 📖 [2025/12 Sam Schlinkert: A curated list of command-line utilities written in Rust](https://github.com/sts10/rust-command-line-utilities)

### `install_java`

installs one of the Microsoft releases of OpenJDK [Java](.//java.md).

### `install_homebrew`

installs (or updates)
[Homebrew](http://docs.brew.sh/Homebrew-on-Linux) 🍺 software management system.

### `brew_bundle`

uses Homebrew to install packages in the [`Brewfile`](./Brewfile) like

- [Go](https://go.dev/) language
- [Node](https://nodejs.org/) engine

### `display_environment`

displays attributes of the system environment.

### `display_versions`

displays versions of some of the main installed tools,
especially languages or their package managers.

### `install_code`

installs and configures Microsoft VS [Code](https://code.visualstudio.com/)
and configures Code with updates for its _argv.json_ settings file.

### `install_code_extensions`

installs the [extensions](https://marketplace.visualstudio.com/vscode)
of Code listed in the _codeExtensions_ file.

_To maintain workstation integrity, only install extensions from reputable & verified authors that regularly address issues with code updates._

### `configure_code`

updates (doing a shallow merge) Code's user settings.json file.
It uses `jq` and Node/npm module `jsonc-cli`.

_Unfortunately (as a consequence of implementation), it erases the comments that were in them._
