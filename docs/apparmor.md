# AppArmor

[AppArmor](https://apparmor.net/) is a Linux kernel security module that provides Mandatory Access Control (MAC) by confining programs to a limited set of resources. Using path-based security profiles, it restricts an application's capabilities &mdash; such as file access or networking &mdash; to prevent damage even if the app is compromised.

Confines programs via per-application profiles — text files defining allowed files, capabilities, network, etc. How it works for CLIs: Create/load a profile for a binary (e.g., `/usr/bin/curl` or a custom script wrapper) that denies access to sensitive paths like ~/.ssh/, ~/.config/ (with tokens), /etc/, home dirs beyond necessities.

- 📖 [AppArmor Wiki Documentation](https://gitlab.com/apparmor/apparmor/-/wikis/Documentation) is the central hub for profile language guides, configuration layouts, and core policy references.
- 📖 [Ubuntu AppArmor Server Guide](https://documentation.ubuntu.com/server/how-to/security/apparmor/) is a practical manual for managing profiles, checking status, and implementing security on one of its primary host distributions.
- 📖 [2025/10 Mikael Ståldal: Linux Sandboxing with Bubblewrap](https://www.staldal.nu/tech/2025/10/19/linux-sandboxing-with-bubblewrap/) is a practical, hands-on guide that provides a "boilerplate" command for sandboxing any application. It is particularly useful for debian-derived systems because it includes _instructions for setting up AppArmor profiles required to allow unprivileged user namespaces._
