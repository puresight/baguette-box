# ChromeOS

## File Storage

- **Google Drive:** Since it's built into the Chromebook Files app, you can right-click any folder and select "Share with Linux". It will appear in Crostini at `/mnt/chromeos/GoogleDrive/MyDrive/`
- **Microsoft OneDrive:** If you use the OneDrive PWA or Android app, you can similarly share folders with Linux from the ChromeOS Files app.
- **External Storage:** SD cards, USB drives, DVD drives, etc can also be shared this way too, appearing at `/mnt/chromeos/removable/`

### Cloud Storage

Cloud drives make object storage easy & affordable.

- See [Rclone](./rclone.md)
- Nextcloud: The gold standard for self-hosting. It offers a native Linux client that integrates perfectly with Crostini's file manager.
- pCloud: Widely considered the most Linux-friendly option; it provides an AppImage that creates a virtual drive.
- MEGA: Offers a robust native client with end-to-end encryption and a generous 20GB+ free tier.
- Dropbox: Has a long-standing native client, though it lacks built-in client-side encryption.
- Insync: $ A popular paid third-party tool specifically designed to sync Google Drive and OneDrive to Linux with a full GUI.

## Podman

### About Running Podman on ChromeOS

⚠ Do not `sudo` for podman commands.

If you want to run Podman in rootless mode on [Crostini](https://www.chromium.org/chromium-os/developer-library/guides/containers/containers-and-vms/) (the Linux environment for ChromeOS), you will encounter challenges, because you're running in a [nested container](https://ntk.me/2021/05/14/podman-in-crostini/), _an LXC container running inside ChromeOS._

#### Challenges

- **LXC Nesting Restrictions:** By default, Crostini’s LXC container does not allow further nesting. To run Podman containers inside it, you must enable security nesting by setting `security.nesting` to `true`.
- **Missing User Namespaces:** Rootless Podman relies on User Namespaces to map the container's root user to an unprivileged user on the host. Crostini often lacks the necessary entries in `/etc/subuid` and `/etc/subgid` for the default user, which are required for [UID/GID remapping](https://documentation.suse.com/smart/container/html/rootless-podman/index.html).
- **Kernel Limitations (OverlayFS):** The Linux kernel used in Crostini may not support native OverlayFS in unprivileged modes for older versions. Users often need to switch the storage driver (e.g., to `btrfs` or `vfs`) or use `fuse-overlayfs` to bypass this.
- **Permission Denied Errors:** Without these fixes, you will frequently encounter errors such as mount `proc` to `/proc`: `Operation not permitted` or `OCI runtime error` because the unprivileged user doesn't have the rights to perform necessary [mount operations](https://github.com/containers/podman/issues/9813) within the nested environment.

#### Adjustments

- **Enable Nesting:** Run `lxc config set <container_name> security.nesting true` (requires access to the ChromeOS Termina VM).
- **Adjust Storage:** Edit `/etc/containers/storage.conf` to use a compatible driver like Btrfs if OverlayFS fails.
- **Configure Sub-UIDs:** Add a range (e.g., 100000-165535) to `/etc/subuid` and `/etc/subgid` for your username. The `bootstrap.sh` fix does this to help with the User Namespaces challenge.

#### Ahead

- **Nesting:** Crostini is already a container (LXC). By default, ChromeOS does not allow a container to start another container inside itself for security reasons. You’ll see errors like `mount: /proc: permission denied` or `failed to mount sysfs`. The fix is to enable _Nested Containers_ from the Crosh terminal.
- **Storage Driver:** Podman usually uses `overlay` to stack file layers. However, the way Crostini mounts its file system often prevents `overlay` from working inside the unprivileged container. You may see errors stating driver "overlay" is not supported. So you typically need to force Podman to use `fuse-overlayfs` or `vfs`.
