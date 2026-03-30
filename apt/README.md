# APT

> The Advanced Package Tool ([APT](https://wiki.debian.org/AptCLI)) is a powerful command-line utility used primarily in Debian-based Linux distributions to automate the installation, configuration, and removal of software. For computer users, APT represents a streamlined way to manage their system; instead of manually hunting for installers online, users can download verified software from secure repositories with a single command. Its most significant benefit is automatic dependency management, which ensures that all supporting files required for a program to run are identified and installed simultaneously, maintaining system stability and security with minimal effort.


This folder contains the _apt.dep_ file that lists (with comments) the APT dependencies for recipe _install-apt-packages_ to install on the system.

- ↪️ Run recipe: `just install-apt-packages`
- ✏️ Keep dependencies in: [`./apt/apt.dep`](./apt.dep)

## APT Sources

Recipe _configure-apt_
connects APT using [DEB822](https://repolib.readthedocs.io/en/latest/deb822-format.html)
to the repository [sources](https://wiki.debian.org/SourcesList)
contained in this directory.

This folder contains the templates for APT repository sources.
And when the system is installing APT repository sources, these templates are processed by
[gomplate](https://docs.gomplate.ca/) to generate the
[new Debian style](https://manpages.debian.org/stable/dpkg-dev/deb822.5.en.html)
`.sources` files for your machine's `/etc/apt/sources.list.d/` directory.

- ↪️ Run recipe: `just configure-apt`
- 📂 Keep sources in: [`./apt/*.sources`](./)

## How that happens

For each `.sources` file in this directory, the system performs four steps:

1. **Extracts GPG Key URL**: It searches for a line containing `Key-URL:` within the template to find the URL for the repository's [GPG public key](https://wiki.debian.org/SecureApt).
1. **Downloads GPG Key**: It downloads the GPG key, de-armors it, and stores it in `/etc/apt/keyrings/`. The key file is named after the source (e.g., `github-cli.gpg`).
1. **Processes Template**: It uses gomplate to process the `.sources` template file. This step substitutes variables and executes any template logic.
1. **Creates Sources File**: The output of gomplate is saved as a `.sources` file in `/etc/apt/sources.list.d/`

## You can add a source

You can add another APT source. To add a new APT repository, follow these steps:

1. **Create a Template File**: Create a new file in this directory, e.g. with the name `your-apt-repo-name.sources`

1. **Add Repository Details**: The content of the file should be a `gomplate` template that generates a valid DEB822-style `.sources` file.

1. **Specify GPG Key URL**: You must include a line to specify the GPG key URL so that `apt.sh` can find and download it. By convention, this is done inside a `Data` block at the end of the file.

   ```log
   Data:
     Key-URL: <URL_of_GPG_key>
   ```

1. **Use Template Variables**: You can use environment variables in the template. So `ARCHITECTURES` is available from `dpkg --print-architecture` and the `apt.sh` script makes these variables available from /etc/os-release:
   - `ID`
   - `VERSION_ID`
   - `VERSION_CODENAME`

   You can access these in the template like this: `{{ .Env.ARCHITECTURES }}`.

   View the content of [`github-cli.sources`](./github-cli.sources) as an example.
