# <figure style="float: right; margin: 0.2ex 0.5em; line-height: 1; text-align: center; font-size: 80px">🍺</figure> Homebrew

<!-- <img src="https://www.google.com/s2/favicons?sz=128&domain=brew.sh" alt="Homebrew logo" align="right" style="max-width: 96px; margin: 0 1em; border: 0.1em solid transparent;"> -->
[Homebrew](http://docs.brew.sh/Homebrew-on-Linux) is an open-source package manager that allows you to easily install and manage software on Linux that might not be available in your distribution's default repositories. Originally created for macOS, it works by installing packages into its own directory without requiring root privileges for most operations. It is particularly useful for developers who want to use the same tooling across different operating systems or need access to the latest versions of specific software.

- ↪️ Run recipe: `just install-homebrew`
- ↪️ Run recipe: `just install-homebrew-packages` on the [bundle](https://docs.brew.sh/Brew-Bundle-and-Brewfile) for your OS family e.g.
    - [`homebrew/debian.Brewfile`](./debian.Brewfile)
    - [`homebrew/fedora.Brewfile`](./fedora.Brewfile)
    - [`homebrew/ublue.Brewfile`](./ublue.Brewfile)
    - &hellip;etc
