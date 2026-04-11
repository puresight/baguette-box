# <img src="https://www.vectorlogo.zone/logos/google/google-icon.svg" alt="Google logo" align="right" width="96" style="margin-top: 1ex; border-left: 0.1em solid transparent;"> ChromeOS

## Get Started

Crostini is the official, first-party environment that enables Linux application support on [ChromeOS](https://chromeos.dev/en/linux) without requiring users to compromise their device's security by enabling Developer Mode. It functions through a highly secure "defense in depth" architecture that runs a Debian-based Linux container inside a specialized, sandboxed virtual machine (VM) called Termina. This setup allows you to run a wide range of Linux-only command-line tools, code editors, and graphical IDEs that integrate seamlessly with the standard ChromeOS desktop, appearing in the app launcher and sharing files through the native Files app. Crostini provides the flexibility of a Linux workstation while maintaining the speed and security of a standard Chromebook.

- ⚙ Open Settings: Click the time in the bottom-right corner and select the Settings (gear) icon.
- 🐧 Turn on Linux: On the left sidebar, select About ChromeOS > Developers. Next to Linux development environment, select Set up.
- 🖱 Configure: Follow the on-screen prompts to choose a username and disk size (10 GB is the standard recommendation).
- 🖥 Open Terminal: Once finished, a Terminal window will automatically open. You now have a Debian-based environment where you can run commands.
- ⬆ Update System: It is best practice to immediately update your packages by typing the following in the terminal and pressing Enter:  
   `sudo apt update && sudo apt upgrade -y`

To continue, you will need to set a password via `sudo passwd $USER`

## File Storage

Common consumer options:

- 💾 Google Drive: Since it's built into the Chromebook Files app, you can right-click any folder and select "Share with Linux". It will appear in Crostini at `/mnt/chromeos/GoogleDrive/MyDrive/`
- 💾 Microsoft OneDrive: If you use the OneDrive PWA or Android app, you can similarly share folders with Linux from the ChromeOS Files app.
- 💿 External Storage: SD cards, USB drives, DVD drives, etc can also be shared this way too, appearing at `/mnt/chromeos/removable/`

Cloud drives make online storage easy & affordable:

- ↪️ Get [Rclone](./rclone.md) by `just install-apt-packages`
- Nextcloud: Offers a native Linux client that integrates with a file manager on ChromeOS.
- Dropbox: Has a long-standing native client, though it lacks built-in client-side encryption.
- pCloud: Provides an AppImage that creates a virtual drive.
- MEGA: Has a native client with end-to-end encryption and a generous free tier.

## Containers

### About Running [Podman](https://podman.io/) on ChromeOS

⚠ Do not `sudo` for podman commands.

If you want to run Podman in rootless mode on [Crostini](https://www.chromium.org/chromium-os/developer-library/guides/containers/containers-and-vms/) (the Linux environment for ChromeOS), you will encounter challenges, because you're running in a [nested container](https://ntk.me/2021/05/14/podman-in-crostini/), _an LXC container running inside ChromeOS._

- ↪️ Run recipe: `just configure-podman-chromeos`

#### Challenges

- **LXC Nesting Restrictions:** By default, Crostini’s LXC container does not allow further nesting. To run Podman containers inside it, you must enable security nesting by setting `security.nesting` to `true`.
- **Missing User Namespaces:** Rootless Podman relies on User Namespaces to map the container's root user to an unprivileged user on the host. Crostini often lacks the necessary entries in `/etc/subuid` and `/etc/subgid` for the default user, which are required for [UID/GID remapping](https://documentation.suse.com/smart/container/html/rootless-podman/index.html).
- **Kernel Limitations (OverlayFS):** The Linux kernel used in Crostini may not support native OverlayFS in unprivileged modes for older versions. Users often need to switch the storage driver (e.g., to `btrfs` or `vfs`) or use `fuse-overlayfs` to bypass this.
- **Permission Denied Errors:** Without these fixes, you will frequently encounter errors such as mount `proc` to `/proc`: `Operation not permitted` or `OCI runtime error` because the unprivileged user doesn't have the rights to perform necessary [mount operations](https://github.com/containers/podman/issues/9813) within the nested environment.

#### Adjustments

- **Enable Nesting:** Run `lxc config set <container_name> security.nesting true` from the ChromeOS Termina VM.
- **Adjust Storage:** Edit `/etc/containers/storage.conf` to use a compatible driver like Btrfs if OverlayFS fails.
- **Configure Sub-UIDs:** Add a range (e.g., 100000-165535) to `/etc/subuid` and `/etc/subgid` for your username. The fix does this to help with the User Namespaces challenge.

#### Ahead

- **Nesting:** Crostini is already a container (LXC). By default, ChromeOS does not allow a container to start another container inside itself for security reasons. You’ll see errors like `mount: /proc: permission denied` or `failed to mount sysfs`. The fix is to enable _Nested Containers_ from the Crosh terminal.
- **Storage Driver:** Podman usually uses `overlay` to stack file layers. However, the way Crostini mounts its file system often prevents `overlay` from working inside the unprivileged container. You may see errors stating driver "overlay" is not supported. So you typically need to force Podman to use `fuse-overlayfs` or `vfs`.

## Desktop Launcher Integration

How to add Linux app executables to your ChromeOS Launcher: to make applications appear in your Chromebook App Launcher alongside your other apps, you can create a `.desktop` shortcut file.
In a text editor, create the file: `~/.local/share/applications/MyAppName.desktop`
with the following content (updating the Name and Exec path to your actual executable)

```ini
[Desktop Entry]
Type=Application
Name=My App Name
Exec=/home/yourusername/filename.AppImage
Icon=utilities-terminal
Terminal=false
```

After you save the `.desktop` file, the app should appear in your "Linux apps" folder within a few moments.
