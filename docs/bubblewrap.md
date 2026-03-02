# Bubblewrap

[Bubblewrap](https://github.com/containers/bubblewrap) `bwrap` is a lightweight, unprivileged sandboxing tool that creates isolated environments using Linux namespaces (user/pid/mount/net/etc.), seccomp filters, and mounts — without needing root or setuid. Wrap your risky CLI commands in bwrap to remap filesystem, drop caps, isolate namespaces.

- [2023/12: Sloonz’s Blog: Sandboxing Applications with Bubblewrap: Securing a Basic Shell](https://sloonz.github.io/posts/sandboxing-1/) explains how Bubblewrap creates an empty namespace and how to manually populate it with essential binaries.
- [2024/1: Sloonz’s Blog: Sandboxing Applications with Bubblewrap: A Simple Script](https://sloonz.github.io/posts/sandboxing-3/) demonstrates how to automate these configurations into reusable wrapper scripts.
- [2025/10 Mikael Ståldal: Linux Sandboxing with Bubblewrap](https://www.staldal.nu/tech/2025/10/19/linux-sandboxing-with-bubblewrap/) is a practical, hands-on guide that provides a "boilerplate" command for sandboxing any application. It is particularly useful for modern systems (like Ubuntu 24.04+) because it includes instructions for setting up AppArmor profiles required to allow unprivileged user namespaces.
- [2024/4 Ralf Jung: Sandboxing All The Things with BubbleBox](https://www.ralfj.de/blog/2024/04/14/bubblebox.html) explores the philosophy of using Bubblewrap as an alternative to Flatpak. It introduces BubbleBox, a tool built on top of bwrap to simplify the "incantations" needed for complex GUI apps while maintaining a high level of security.
- [ArchWiki Bubblewrap Examples](https://wiki.archlinux.org/title/Bubblewrap/Examples) page has some recipes like sandboxing a web browser or a DHCP client.
