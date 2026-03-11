# Research

Topics Queue for Research

- [Tailscale](https://tailscale.com/) used to create a secure, private mesh network (a "tailnet") that connects devs devices, servers, and cloud instances as if they were on the same local Wi-Fi, regardless of their actual physical location.
  - Accessing Private Resources without Port Forwarding: Developers use Tailscale to access internal databases (e.g., PostgreSQL, MySQL), staging environments, or **NAS devices** from anywhere without exposing them to the public internet or fiddling with complex firewall/NAT settings.
  - Secure **Remote Development**: It enables connecting a local IDE (like VS Code) to a high-powered remote server or VM, allowing developers to code on a "thin" laptop while leveraging remote hardware.
  - **CI/CD** Pipeline Connectivity: It securely connects CI/CD runners (like GitHub Actions) to internal test databases or private registries that are otherwise hidden behind a firewall.
  - Collaborative Previews (**Tailscale Funnel**): Developers use Tailscale Funnel to temporarily expose a local web server to the public internet, making it easy to share a work-in-progress feature with a client or teammate.
  - **Tailscale SSH** replaces traditional SSH key management by using the developer's existing identity provider (e.g., GitHub, Google, Okta) to authenticate shell access, including features like session recording for compliance.
  - Testing and Localization: By using "exit nodes," developers can route their traffic through a server in a different geographic region to test how their application behaves in different countries.
- [Neon](https://neon.com/) is a serverless, open-source PostgreSQL database platform designed to eliminate the friction of traditional database management.
- [Chezmoi](https://www.chezmoi.io/user-guide/encryption/age/) is a specialized tool for managing "dotfiles" (config files) across multiple machines. For developers who want to sync personalized shell, editor (VS Code/Zed), and tool settings without the overhead of a full configuration management suite. One Go binary, easy secrets, uses templates.
