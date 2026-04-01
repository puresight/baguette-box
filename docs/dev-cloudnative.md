# Cloud Native Development

Cloud native is an approach to building and running applications that fully leverages the advantages of the cloud computing model. As defined by the [<abbr title="Cloud Native Computing Foundation">CNCF</abbr>](https://www.cncf.io/), it's about designing applications as loosely coupled microservices, running them in containers, and managing them with dynamic orchestration. This differs significantly from traditional development.

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
- **Infrastructure as Code (IaC):** Managing and provisioning infrastructure (like servers, databases, and networks) through machine-readable definition files, rather than manual configuration. Tools like [Terraform](https://www.terraform.io/), [Pulumi](https://www.pulumi.com/), & [AWS CloudFormation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/quickref.html) enable repeatable and version-controlled infrastructure setups.

<!-- --
[Ansible](https://www.ansible.com/), 
<!-- -->

## Twelve Factors

The [12 Factor App](https://12factor.net/) methodology is a set of principles for building software-as-a-service applications that are designed for modern cloud platforms. Adhering to these factors helps create applications that are portable, resilient, and scalable—all hallmarks of a cloud-native architecture. They provide a blueprint for building applications that can be deployed automatically, scaled elastically, and managed efficiently in dynamic environments.

1. **Codebase:** A _unified codebase_ tracked in version control, which can be deployed to _multiple environments_ (dev, staging, production).
1. **Dependencies:** Explicitly declare and isolate all dependencies (e.g., via `package.json` or `requirements.txt`), rather than relying on system-wide packages.
1. **Config:** Store all _configuration_ (credentials, hostnames, etc.) in the environment, separate from the code. This allows the same application image to be used across different deploys.
1. **Backing Services:** Treat all backing services (databases, message queues, caches) as attached resources, accessible via a URL or other locator stored in the config.
1. **Build, release, run:** Strictly separate the build stage (compiling code), release stage (combining the build with config), and run stage (executing the app).
1. **Processes:** Execute the application as one or more stateless, "share-nothing" processes. Any state that needs to persist must be stored in a stateful backing service.
1. **Port Binding:** Export services by binding to a port and listening for incoming requests. The application is self-contained and does not rely on a runtime-injected webserver.
1. **Concurrency:** Scale the application horizontally by adding more processes. This model is simple and reliable for handling increased load.
1. **Disposability:** Maximize robustness with fast startup and graceful shutdown. Processes should be disposable and able to be started or stopped at a moment's notice.
1. **Dev/prod parity:** Keep development, staging, and production environments as similar as possible to reduce unexpected bugs and enable continuous delivery.
1. **Logs:** Treat logs as _event streams_. The application should not manage log files but instead write its event stream to standard output, letting the execution environment handle collection and routing.
1. **Admin processes:** Run administrative or management tasks (like database migrations) as one-off processes, using the same codebase and release as the main application.

### Continued

While the original twelve factors provide a robust foundation, the evolution of cloud-native practices has led some architects to propose additional principles. These factors address modern challenges in areas like API design and security.

13. **API First:** Design APIs as first-class artifacts. Define contracts (e.g., using OpenAPI) before implementation, as opposed to generating documentation from code. This contract-first approach enables parallel development, provides clear boundaries between microservices, and ensures the API is a stable, well-documented product.
14. **Authentication & Authorization:** Treat identity as a first-class concern. Applications should not embed their own authentication logic but instead delegate it to centralized identity services (e.g., via OAuth2/OIDC). Authorization rules should be externalized and managed centrally where possible, rather than being hardcoded into the application.
