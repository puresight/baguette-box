# `apt_sources`

This directory contains templates for [APT repository sources](https://wiki.debian.org/SourcesList).
The templates are processed by [gomplate](https://docs.gomplate.ca/) to generate standard [Debian 822-style `.sources` files](https://manpages.debian.org/stable/dpkg-dev/deb822.5.en.html) in `/etc/apt/sources.list.d/`.

## How it Works

For each `*.sources.gomplate` file in this directory, the script performs the following process:

1. **Extracts GPG Key URL**: It searches for a line containing `Key-URL:` within the template to find the URL for the repository's [GPG public key](https://wiki.debian.org/SecureApt).
1. **Downloads GPG Key**: It downloads the GPG key, de-armors it, and stores it in `/etc/apt/keyrings/`. The key file is named after the source (e.g., `github-cli.gpg`).
1. **Processes Template**: It uses gomplate to process the template file. This step substitutes variables and executes any template logic.
1. **Creates Sources File**: The output of gomplate is saved as a `.sources` file in `/etc/apt/sources.list.d/`. For example, `github-cli.sources.gomplate` becomes `github-cli.sources`.

## Adding a New APT Source

To add a new APT repository, follow these steps:

1. **Create a Template File**: Create a new file in this directory with the name `your-repo-name.sources.gomplate`.

1. **Add Repository Details**: The content of the file should be a `gomplate` template that generates a valid DEB822-style `.sources` file.

1. **Specify GPG Key URL**: You must include a line to specify the GPG key URL so that `apt.sh` can find and download it. By convention, this is done inside a `Data` block at the end of the file.

   ```
   Data:
     Key-URL: <URL_of_GPG_key>
   ```

1. **Use Template Variables**: You can use environment variables in the template. The `apt.sh` script makes the following variables available from `/etc/os-release`:
   - `ID`
   - `VERSION_ID`
   - `VERSION_CODENAME`

   Additionally, `ARCHITECTURES` is available from `dpkg --print-architecture`. You can access these in the template like this: `{{ .Env.ARCHITECTURES }}`.

### Example

Here is the content of `github-cli.sources.gomplate` as an example:

```
Types: deb
URIs: https://cli.github.com/packages
Suites: stable
Components: main
Architectures: {{ .Env.ARCHITECTURES }}
Signed-By: /etc/apt/keyrings/github-cli.gpg
Description: GitHub CLI
Origin: GitHub
Data:
  Key-URL: https://cli.github.com/packages/githubcli-archive-keyring.gpg
```
