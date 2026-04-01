# Cloud

Cloud ("server-side") development involves building, deploying, and managing software applications that run on remote **servers** hosted on the internet ("the cloud") rather than on a user's local machine. This approach enables massive scalability, high availability, and global reach. Modern [cloud development](./dev-cloudnative.md) relies on a set of core practices and tools that abstract away physical hardware, allowing developers to focus on writing code and delivering value.

## Cloud Providers

The hyperscalers offer a vast suite of services for computing, storage, networking, and more:

1. Amazon Web Services ([AWS](https://aws.amazon.com/)): The oldest and most dominant player, known for its extensive service catalog and mature ecosystem. Managed via the _AWS CLI_.
1. Microsoft [Azure](https://azure.microsoft.com/): A strong competitor with deep integration into the Microsoft enterprise ecosystem. Managed via the _PowerShell_ `Az` modules.
1. Google Cloud Platform ([GCP](https://cloud.google.com/)): Known for its expertise in data analytics, machine learning, and container orchestration (as the original creator of Kubernetes). Managed via the _Google Cloud CLI_.

Many more cloud providers offer affordable alternatives that could be helpful, including: [Cloudflare](https://www.cloudflare.com/), [Linode (Akamai)](https://www.linode.com/), [DigitalOcean](https://www.digitalocean.com/), [Vultr](https://www.vultr.com/), [OVHcloud](https://ovhcloud.com/) (EU), [Vercel](https://vercel.com/), ...

## Cloud Storage

A fundamental component of cloud applications is object storage, which is used for everything from hosting static website assets to storing large datasets.

- **S3-Compatible Storage:** The Amazon S3 API has become the de-facto standard for object storage. Many providers offer S3-compatible services.
- **CLI Tools:** Tools like [MinIO Client](./mc.md) (`mc`) and [Rclone](./rclone.md) provide a powerful, scriptable interface for managing data across various cloud storage providers from the command line.
