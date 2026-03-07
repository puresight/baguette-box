# Docs

_To maintain workstation integrity, only install code from reputable & verified authors that regularly address issues with code updates._

## How to Use

- Run command `./box.sh --install --config everything.yaml`
- Restart your shell: close and reopen the terminal

This script is idempotent. You can run it again anytime.

## YAML tasks

The config file you supply feeds box tasks to do.
Each task in sequence (with some arguments) will be executed - unless property `enabled` is `false`.

While the full understanding of each is found in inspecting the bash source of the lib functions that implement them, the following is a summary.

#### `install_apt_packages`

Advanced Package Tool (APT) is the primary software management system
used in Debian-based Linux systems to manage software packages.
It automates installing, upgrading, and removing software, including handling dependencies.
It relies on the `/etc/apt/sources.list.d` directory to locate release package repositories.

This task connects [APT](https://wiki.debian.org/AptCLI)
using [DEB822](https://repolib.readthedocs.io/en/latest/deb822-format.html)
to these repository [sources](https://wiki.debian.org/SourcesList) &mdash;

- [Google Cloud CLI](https://docs.cloud.google.com/sdk/docs/install-sdk#deb) `google-cloud` <packages.cloud.google.com/apt>
- [Google Antigravity](https://antigravity.google/) `antigravity` <us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/>
- [Azure Cloud CLI](https://learn.microsoft.com/en-us/cli/azure/) `azure-cli` <packages.microsoft.com/repos/azure-cli/>
- [Github CLI](https://cli.github.com/) `github-cli` <cli.github.com/packages>
- [Microsoft prod](https://learn.microsoft.com/en-us/linux/packages) `microsoft-prod` <packages.microsoft.com/debian/12/prod>
- [VS Code](https://code.visualstudio.com/docs/setup/linux#_debian-and-ubuntu-based-distributions) `vscode` <packages.microsoft.com/repos/code>

And runs _apt install_ on packages listed in the _Aptfile_ like

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

#### `install_yamljson`

This task installs dependencies needed by the system to work with JSON or YAML text files

- `yq` is installed by this task
- `jq` was defined in the _Aptfile_.

#### `install_storage_tools`

This task installs utilities such as
[MinIO Client](https://github.com/minio/mc) `mc` a tool for managing files on Amazon S3-compatible cloud storage.

#### `install_uv`

This task installs [UV](.//uv.md),
the unified tool for the Python ecosystem.
And [Python](https://www.python.org/).

#### `install_flatpak`

This task installs flatpak and adds the remote source for the Flathub app marketplace.

[Flatpak](./flatpak.md) is the preferred method for installing GUI applications on this system. This approach ensures applications run in isolated environments with their own dependencies, preventing conflicts with system libraries and keeping the host OS clean. It also provides access to the latest versions of applications regardless of the distribution's release cycle. Read the [flatpak.md](./flatpak.md) docs for more info.

#### `install_mise`

This task installs Mise en place. **[Mise](https://mise.jdx.dev/)** is a tool with potential to manage installations of languages and tools for development. It could be used to manage multiple versions of Node.js, Go, or Ruby in the future. Under construction.

<!-- --
- [Go](https://go.dev/) language
- [Node](https://nodejs.org/) engine
<!-- -->

#### `install_goose`

This task installs Block's [Goose](https://block.github.io/goose/docs/category/guides) AI CLI.

#### `install_dotnet`

This task installs a Microsoft [.NET](https://dotnet.microsoft.com/) SDK release e.g.
[10](https://learn.microsoft.com/en-us/dotnet/core/whats-new/dotnet-10/overview).
And installs the [Powershell](https://learn.microsoft.com/en-us/powershell/) shell.

#### `configure_shell`

This task changes the system's default shell to zsh (which was installed in the Aptfile),
runs a _pwsh_ script to install [Azure PowerShell](https://learn.microsoft.com/en-us/powershell/azure/)
(aka [`Az`](https://www.powershellgallery.com/packages/az)) CLI.

And installs the [Oh My Posh](https://ohmyposh.dev/) prompt
for the zsh and pwsh shells.

#### `install_font`

This task _installs_ a [Nerd Font](https://www.nerdfonts.com/font-downloads)
on the system, e.g. JetBrainsMono v3.3.0;
it neither updates nor remove fonts.

#### `configure_podman`

This task configures [Podman](.//podman.md).

#### `install_rust`

This task uses [Rustup](https://rustup.rs/) to install the [Rust](https://rust-lang.org/) language.

And adds [cargo-binstall](https://github.com/cargo-bins/cargo-binstall) tool for quick package installation. Because the standard _cargo install_ command downloads source code and compiles it on your machine, which can be slow. So to bypass this and install pre-compiled binaries, use the community-standard tools like cargo-binstall. This is the most popular method. it automatically searches for pre-compiled releases on GitHub or other registries. Usage: Replace `cargo install <package>` with `cargo binstall <package>`

- 📖 [2024/11 Ben Brandt: A Better Cargo Install Workflow: How I manage to keep the tools I've installed with cargo up-to-date](https://benjaminbrandt.com/a-better-cargo-install-workflow/)
- 📖 [2025/12 Sam Schlinkert: A curated list of command-line utilities written in Rust](https://github.com/sts10/rust-command-line-utilities)

#### `install_java`

This task installs one of the Microsoft releases of OpenJDK [Java](.//java.md).

#### `install_homebrew`

This task installs (or updates)
[Homebrew](http://docs.brew.sh/Homebrew-on-Linux) 🍺 software management system.

#### `brew_bundle`

This task uses Homebrew to install packages in the [`Brewfile`](./Brewfile) like

- [Go](https://go.dev/) language
- [Node](https://nodejs.org/) engine

#### `display_environment`

This task displays attributes of the system environment.

#### `display_versions`

This task displays versions of some of the main installed tools,
especially languages or their package managers.

#### `install_code`

This task installs and configures Microsoft VS [Code](https://code.visualstudio.com/)
and configures Code with updates for its _argv.json_ settings file.

#### `install_code_extensions`

This task installs the [extensions](https://marketplace.visualstudio.com/vscode)
of Code listed in the _codeExtensions_ file.

_To maintain workstation integrity, only install extensions from reputable & verified authors that regularly address issues with code updates._

#### `configure_code`

This task updates (doing a shallow merge) Code's user settings.json file.

_Unfortunately (as a consequence of implementation), it erases the comments that were in them._
