# AppArmor

[AppArmor](https://apparmor.net/) is a Linux kernel security module that provides Mandatory Access Control (MAC) by confining programs to a limited set of resources. Using path-based security profiles, it restricts an application's capabilities &mdash; such as file access or networking &mdash; to prevent damage even if the app is compromised.

Confines programs via per-application profiles — text files defining allowed files, capabilities, network, etc. How it works for CLIs: Create/load a profile for a binary (e.g., `/usr/bin/curl` or a custom script wrapper) that denies access to sensitive paths like ~/.ssh/, ~/.config/ (with tokens), /etc/, home dirs beyond necessities.

- [AppArmor Wiki Documentation](https://gitlab.com/apparmor/apparmor/-/wikis/Documentation) is the central hub for profile language guides, configuration layouts, and core policy references.
- [Ubuntu AppArmor Server Guide](https://documentation.ubuntu.com/server/how-to/security/apparmor/) is a practical manual for managing profiles, checking status, and implementing security on one of its primary host distributions.
