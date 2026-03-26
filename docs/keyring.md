# Keyring

[GNOME Keyring](https://wiki.gnome.org/Projects/GnomeKeyring) is a collection of components in the Linux environment that securely stores secrets, making them available to applications.
Since VS Code is going to use this system anyway, you might as well use it, too. Secrets include credentials for apps, virtual private networks, shared drives, databases, signed messaging, secure tunnels, SSL/TLS certificates, etc. How to:

<!-- --
It was designed to run as a daemon, automatically unlocking stored secrets when a user logs into their session.
<!-- -->

- ↪️ Recipe to install: `just install-apt-packages`
- **View:** [`seahorse` aka "Passwords and Keys"](https://wiki.gnome.org/Apps/Seahorse) is a graphical frontend for the GNOME Keyring system; helpful for inspection or verification
- **Store:** `echo -n "YOUR_ACTUAL_API_KEY" | secret-tool store --label="Gemini API Unbilled Key" service google-ai account unbilled-gemini-key`
- **Retrieve:** `export GEMINI_API_KEY=$(secret-tool lookup service google-ai account unbilled-gemini-key)`
