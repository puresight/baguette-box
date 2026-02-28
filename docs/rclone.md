# Rclone

[Rclone](https://rclone.org/docs/) is a Swiss Army Knife for mounting nearly any cloud service as a local file system in Linux. It is broadly compatibile, supporting Dropbox, pCloud, MEGA, S3-compatible storage, yada yada.

- Run `rclone config` to link your accounts
- Mount drive: `rclone mount remote:path /home/username/mountpoint --vfs-cache-mode writes`

## Popular Uses

### **S3**-compatible storage

- [IDrive e2](https://www.idrive.com/s3-storage-e2/): ~$4/TB/month (1st year $25).
- [Backblaze B2](https://www.backblaze.com/cloud-storage/pricing): Reliable at $6/TB/month with free egress to 3x storage.
- [Hetzner Object Storage](https://www.hetzner.com/storage/object-storage): Competitive **European** provider at €5/TB/month.

### Proton Drive

For [Proton Drive](https://proton.me/drive)

- Configure a new remote by selecting `protondrive` (type 39) in `rclone config`, authentication requires your Proton username, password, and 2FA code.
- Use `rclone mount` with `--vfs-cache-mode full` for best compatibility, but disable external cache updates
  - e.g. `rclone mount remote_name: /path/to/local/mount --vfs-cache-mode full`

## Articles

- [2026/1 IBM Cloud: Using rclone](https://cloud.ibm.com/docs/cloud-object-storage?topic=cloud-object-storage-rclone)
- [2023/7 Akamai Cloud: Use Rclone to Sync Files to Linode Object Storage](https://www.linode.com/docs/guides/rclone-object-storage-file-sync/)
