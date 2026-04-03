# Docs

To maintain workstation integrity, only install code from reputable & verified authors that regularly address issues with code updates.

## How to Run Recipes

- ↪️ View our menu: `just`
- ↪️ Bootstrap your new Debian system: `just debian`
- ↪️ Setup VS Code: `just code`

Our recipes are idempotent, so you can run them again, anytime.

## System Architecture

Every piece of software you install must be able to receive updates for
bugs or security vulnerabilities. It is always best to pick a
package management system to help with the lifecycle of each program
that you want on your machine. We integrate several including:

- [APT](../apt/README.md) is Debian's Advanced Package Tool
- [Homebrew](../homebrew/README.md) for [Aider](./aider.md)
- [Mise](./mise.md) en place for [Node](./node.md), [Go](./go.md), [Ruby](./ruby.md)
- [Node](./docs/node.md) via [viteplus](./docs/viteplus.md)
- [uv](./uv.md) is the Python package manager

These are availble but not integral:

- [Rustup](./rust.md) for Rust
- [Flatpak](./flatpak.md) for installing GUI apps
- [.NET](../dotnet/README.md)
- [OpenJDK](./java.md)
- [Kotlin](./docs/kotlin.md) & [Scala](./docs/scala.md)
- [Erlang](./docs/erlang.md) & [Elixir](./docs/elixir.md)
- [Haskell](./docs/haskell.md)
- [Dart (Flutter)](./docs/flutter.md) 

CLI:

- [Zsh](https://zsh.sourceforge.io/) & [pwsh](https://learn.microsoft.com/en-us/powershell/) shells
- [Oh My Posh](https://ohmyposh.dev/) prompt _with_ [nerd fonts](./fonts.md)
- [AWS](https://docs.aws.amazon.com/cli/), [Azure](https://learn.microsoft.com/en-us/powershell/azure/), [Google](https://cloud.google.com/cli), [kubectl](https://kubernetes.io/docs/reference/kubectl/) cloud tools
- [MinIO Client](./docs/mc.md), [Rclone](./docs/rclone.md) storage utils
- [Postgres](https://www.postgresql.org/docs/current/reference-client.html), [MariaDB](https://mariadb.com/docs/server/clients-and-utilities/mariadb-client/mariadb-command-line-client), [Redis](https://redis.io/docs/latest/develop/tools/), [SQLite](https://www.sqlite.org/) [database clients](./databases.md)

## Recipes

Find the [just](./just.md) recipe definitions in the justfile.
While precise understanding is in inspecting the bash source of the [scripts](../scripts) that implement them, here is a summary.

### High Level Recipes

High level recipes combine many regular recipes to accomplish an objective for overall system configuration.

#### `bootstrap`

Bootstrap your new system. Installs tons of stuff (essentials and nice to have). But not everything; reference the [justfile](../justfile) for details.

#### `code`

Install VS [Code](../code/README.md).

### Regular Recipes

Regular recipes perform specific & granular tasks for system configuration.

#### `ansible`

uses [UV](./uv.md) to install [Ansible](https://docs.ansible.com/)

#### `install-gomplate`

[Gomplate](https://docs.gomplate.ca/) is a template rendering engine supporting JSON & YAML

#### `configure-apt`

Connects [APT](../apt/README.md) to APT repository sources.

#### `install-apt-packages`

Runs `apt install` on packages listed in the [`apt/apt.Packages`](../apt/apt.Packages)

<!-- --

- [Zsh](https://zsh.sourceforge.io/) shell
- [Rclone](.//rclone.md) is a tool for mounting nearly any cloud service as a local file system
- [aws CLI](https://docs.aws.amazon.com/cli/) ☁ tools
- [gcloud CLI](https://cloud.google.com/cli) ☁ tools
- [kubectl](https://kubernetes.io/docs/reference/kubectl/) tool
- [Github](https://cli.github.com/) tools
- [Google Antigravity](https://antigravity.google/) AI IDE

<!-- -->

#### `configure-flatpak`

installs flatpak and adds the remote source for the Flathub app marketplace.

[Flatpak](./flatpak.md) is the preferred method for installing GUI applications on this system. This approach ensures applications run in isolated environments with their own dependencies, preventing conflicts with system libraries and keeping the host OS clean. It also provides access to the latest versions of applications regardless of the distribution's release cycle. Read the [flatpak.md](./flatpak.md) docs for more info.

#### `install-mc`

installs utilities such as
[MinIO Client](./docs/mc.md) (`mc`), a tool for managing files on S3-compatible cloud storage.

#### `install-uv`

installs [UV](.//uv.md)
(the unified tool for the Python ecosystem)
and Python.

#### `install-rust`

installs [Rust](./rust.md) language.

#### `install-mise`

installs **[Mise](./mise.md)** en place, a tool to manage installations of languages and tools for development.

#### `install-java`

installs an OpenJDK [Java](./java.md) of the Java langauge.

#### `install-kotlin`

installs [Kotlin](./kotlin.md) language.

#### `install-scala`

installs [Scala](./scala.md) language.

#### `install-dotnet`

installs [.NET](../dotnet/README.md) SDK.

#### `install-viteplus`

installs [Node](./node.md)
managed by [Mise](./mise.md).

#### `install-go`

installs [Go](./go.md) language
managed by [Mise](./mise.md).

#### `install-haskell`

installs [Haskell](./haskell.md) language
managed by [Mise](./mise.md).

#### `install-erlang`

installs [Erlang](./erlang.md) language
managed by [Mise](./mise.md).

#### `install-elixir`

installs [Elixir](./elixir.md) language
managed by [Mise](./mise.md).

#### `install-flutter`

installs [Flutter](./flutter.md) toolkit
managed by [Mise](./mise.md).

#### `install-ruby`

installs [Ruby](./ruby.md) language (including RubyGems)
managed by [Mise](./mise.md).

#### `install-rails`

installs the Rails framework using [Ruby](./ruby.md)

#### `install-jekyll`

installs Jekyll static site generator (SSG) using [Ruby](./ruby.md)

#### `install-goose`

installs Block's [Goose](https://block.github.io/goose/docs/category/guides) AI CLI.

#### `install-font`

installs a monospace [font](./fonts.md) needed by the prompt et. al.

#### `configure-shell`

changes the system's default shell to zsh (which was installed in the apt/apt.Packages),
runs a _pwsh_ script to install [Azure PowerShell](https://learn.microsoft.com/en-us/powershell/azure/)
(aka [`Az`](https://www.powershellgallery.com/packages/az)) CLI.

And installs the [Oh My Posh](https://ohmyposh.dev/) prompt
for the zsh and pwsh shells.

#### `install-tools-terminal`

installs [CLI tools](./cli-tools.md) like
[fzf](https://junegunn.github.io/fzf/) & [zoxide](https://zoxide.org/)

#### `configure-podman`

configures [Podman](.//podman.md)

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
[`code/code.Extensions`](../code/code.Extensions) file.

To maintain workstation integrity, only install extensions from reputable & verified authors that regularly address issues with code updates.

#### `configure-code`

updates (doing a shallow merge) Code's user settings json file.
It uses `jq` and Node/npm module `jsonc-cli`.

Unfortunately as a consequence of implementation, it erases the comments that were in them.
