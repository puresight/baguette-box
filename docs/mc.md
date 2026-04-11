# <img src="https://www.google.com/s2/favicons?sz=128&domain=min.io" alt="MinIO logo" align="right" width="96" style="margin-top: -9px; border-left: 0.1em solid transparent;"> Minio Client

> [MinIO Client](https://github.com/minio/mchttps://github.com/minio/mc) (mc) is a command-line tool that provides a modern, Unix-like interface for managing files on both local filesystems and Amazon S3-compatible [cloud](./dev-server.md) **storage services**. It is designed to be a replacement for standard commands like ls, cp, and mkdir, optimized for object storage.

- ↪️ Run recipe to install: `just install-mc`

You can use one tool to manage local files, AWS S3, Google [Cloud](./dev-server.md) Storage, Azure Blob Storage, etc. It has a subset of commands under `mc admin` for managing MinIO server operations like _user management, health checks, and decommissioning nodes._ Built in [Go](./go.md), it is _efficient at handling large-scale data transfers._

The [mc](https://docs.min.io/enterprise/aistor-object-store/reference/cli/)
CLI maps familiar Unix commands to object storage operations:

- `mc ls`: Lists buckets and objects.
- `mc cp`: Copies data between the local system and a server, or between two different [cloud](./dev-server.md) providers.
- `mc mb`: Creates a new bucket (similar to `mkdir`).
- `mc mirror`: Synchronizes content between two locations, similar to `rsync`.
- `mc find`: Searches for objects based on names or attributes.
- `mc alias`: Manages connections to different S3-compatible endpoints by assigning them short names  
  for example `mc alias set my-s3 https://s3.amazonaws.com ACCESS_KEY SECRET_KEY`

## Configuration

The CLI [mc alias](https://docs.min.io/enterprise/aistor-object-store/reference/cli/mc-alias/) `set` command saves your server's endpoint and credentials so you don't have to type them for every command. Once configured, you can test it out on your buckets:

- List Buckets: `mc ls my-s3`
- Server Info: `mc admin info my-s3`

It saves its configuration file, certificates, and Certificate Authorities for deployments:

- `~/.mc/config.json`
- `~/.mc/certs/`
- `~/.mc/certs/CAs/`

## Learn

- 📖 [Scaleway: Setting up MinIO Client](https://www.scaleway.com/en/docs/object-storage/api-cli/installing-minio-client/)
- 📖 [MinIO: Official Client Documentation](https://docs.min.io/enterprise/aistor-object-store/reference/cli/)
- 📺 [How to Install and Run MinIO Linux on Debian-based Systems](https://www.youtube.com/watch?v=EsJHf5nUYyA)
