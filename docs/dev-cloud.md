# Cloud development

Cloud development involves building, deploying, and managing software applications that run on remote servers hosted on the internet ("the cloud") rather than on a user's local machine. This approach enables massive scalability, high availability, and global reach. Modern cloud development relies on a set of core practices and tools that abstract away physical hardware, allowing developers to focus on writing code and delivering value.

## The Cloud Native Approach

Cloud native is an approach to building and running applications that fully leverages the advantages of the cloud computing model. As defined by the Cloud Native Computing Foundation ([CNCF](https://www.cncf.io/)), it's about designing applications as loosely coupled microservices, running them in containers, and managing them with dynamic orchestration. This differs significantly from traditional development.

| Aspect | Traditional (Monolithic) | Cloud Native |
| :--- | :--- | :--- |
| **Architecture** | Large, single-unit applications where all components are tightly coupled. | Small, independent microservices, each responsible for a single business function. |
| **Deployment** | Infrequent, large-scale releases with significant manual effort and downtime. | Frequent, automated releases via CI/CD pipelines, enabling rapid iteration. |
| **Scalability** | Vertical scaling (adding more CPU/RAM to a single server). Expensive and has limits. | Horizontal scaling (adding more instances of a service). Elastic and cost-effective. |
| **Resilience** | A failure in one component can bring down the entire application. | Failures are isolated to individual microservices; the system can remain partially functional. |

This shift enables organizations to build highly scalable, resilient, and agile systems. The key concepts below are the building blocks of this approach.

## Key Concepts

- **Containerization:** Packaging an application and its dependencies into a standardized unit called a container. This ensures the application runs consistently across different environments. [Podman](./podman.md) is a popular, secure tool for managing containers.
- **Orchestration:** Automating the deployment, scaling, and management of containerized applications. [Kubernetes](https://kubernetes.io/) (managed via `kubectl`) is the industry standard for container orchestration.
- **Infrastructure as Code (IaC):** Managing and provisioning infrastructure (like servers, databases, and networks) through machine-readable definition files, rather than manual configuration. Tools like Terraform, Pulumi, and AWS CloudFormation enable repeatable and version-controlled infrastructure setups.

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
