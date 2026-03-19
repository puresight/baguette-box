# APT

Task `install_apt_packages`
connects [APT](https://wiki.debian.org/AptCLI)
using [DEB822](https://repolib.readthedocs.io/en/latest/deb822-format.html)
to the repository [sources](https://wiki.debian.org/SourcesList)
contained in this directory.

So this folder contains the templates for
[APT repository sources](https://wiki.debian.org/SourcesList).

And when the system is installing APT repository sources, these templates are processed by
[gomplate](https://docs.gomplate.ca/) to generate new
[Debian](https://manpages.debian.org/stable/dpkg-dev/deb822.5.en.html) style
`.sources` files for your machine's `/etc/apt/sources.list.d/` directory.

After the APT repo sources are ready, then it installs packages in the `apt.dep` file: which is merely a list of the APT dependencies to install (with comments).

## How that happens

For each `*.sources.gomplate` file in this directory, the system performs four steps:

1. **Extracts GPG Key URL**: It searches for a line containing `Key-URL:` within the template to find the URL for the repository's [GPG public key](https://wiki.debian.org/SecureApt).
1. **Downloads GPG Key**: It downloads the GPG key, de-armors it, and stores it in `/etc/apt/keyrings/`. The key file is named after the source (e.g., `github-cli.gpg`).
1. **Processes Template**: It uses gomplate to process the template file. This step substitutes variables and executes any template logic.
1. **Creates Sources File**: The output of gomplate is saved as a `.sources` file in `/etc/apt/sources.list.d/`. For example, `github-cli.sources.gomplate` becomes `github-cli.sources`.

## You can add a source

You can add another APT source. To add a new APT repository, follow these steps:

1. **Create a Template File**: Create a new file in this directory with the name `your-repo-name.sources.gomplate`.

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

   View the content of [`github-cli.sources.gomplate`](./github-cli.sources.gomplate) as an example.
