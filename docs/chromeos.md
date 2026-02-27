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
