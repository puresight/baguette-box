# Flatpak

[Flatpak](https://flathub.org/) is a Linux package management system that bundles an app with all its necessary dependencies in a container, allowing isolation from the rest of the system. Flatpak is the preferred method for installing GUI applications on this system. This approach ensures applications run in isolated environments with their own dependencies, preventing conflicts with system libraries and keeping the host OS clean. It also provides access to the latest versions of applications regardless of the distribution's release cycle.

## Applications

**[Flathub](https://flathub.org/)** lists 3300+ applications

[Slack](https://slack.com/resources/why-use-slack/what-is-slack-and-how-does-it-work) is a communication platform that connects people to the information they need. It brings team communication and collaboration into one place so you can get more work done. `flatpak install flathub com.slack.Slack`

[Insomnia](https://developer.konghq.com/insomnia/) is an open-source API client for GraphQL, REST, WebSockets, Server-sent events (SSE), and gRPC. It allows you to debug APIs, design APIs using OpenAPI, and test APIs. `flatpak install flathub rest.insomnia.Insomnia`

[Bruno](https://www.usebruno.com/) is a local-first API client that stores collections as plain text files directly on your filesystem. It is designed for Git-based collaboration, allowing you to version control your API requests alongside your code. (And the Bruno CLI can run collections, switch environments, and integrate tests into CI/CD pipelines.) `flatpak install flathub com.usebruno.Bruno`

[DbGate](https://docs.dbgate.io/) is smart, open-source database client that works with MySQL, PostgreSQL, SQL Server, and MongoDB. It's lightweight, open-source database manager with good support for PostgreSQL, MariaDB/MySQL, Redis (and MongoDB, etc.). Has a tabbed interface, query builder, data grids, SSH tunnels. Works well via Flatpak on GNOME. Simpler than DBeaver but still multi-DB capable. `flatpak install flathub org.dbgate.DBGate`

[Beekeeper Studio](https://www.beekeeperstudio.io/) is a modern, easy-to-use SQL editor and database manager that is well-regarded for its clean UI and cross-platform support. It's clean, modern, intuitive interface focused on simplicity. Excellent table data browsing/editing (spreadsheet-like), SQL editor, schema navigation. Strong PostgreSQL and MariaDB/MySQL support; solid Redis client (browse keys, edit values/TTLs, run commands with completions). GNOME-friendly design. Best for clean browsing/editing of remote tables/keys without overwhelming features. `flatpak install flathub io.beekeeperstudio.Studio`

[DBeaver](https://dbeaver.io/) (community edition) is a comprehensive universal database tool for developers and database administrators. It's a universal database manager with excellent support for PostgreSQL (including extensions like pgvector), MariaDB/MySQL, Redis, and dozens more. Tree-based browser for schemas/tables/keys, powerful SQL editor with autocompletion, data viewer/editor, ER diagrams, export/import, SSH tunneling for secure remote access. It's Java-based but runs smoothly via Flatpak, with a modern dark mode support and doesn't feel out of place. Best for multi-database workflows, heavy Postgres/MariaDB use + occasional Redis. `flatpak install flathub io.dbeaver.DBeaverCommunity`

<sup>&dagger;</sup>[DB Browser for SQLite](https://sqlitebrowser.org/) (formerly SQLiteBrowser) is a high-quality visual tool to create, design, and edit database files compatible with SQLite. It provides a visual, spreadsheet-like interface for managing databases without requiring complex SQL commands. Caveat: Since it is built using the Qt framework, the initial installation may trigger a download of the KDE Application Platform runtime (approx. 700MB) if you don't already have it installed. `flatpak install flathub org.sqlitebrowser.sqlitebrowser`

[Android Studio](https://developer.android.com/studio/) is Google's IDE for [Android app development](https://developer.android.com/) (based on IntelliJ IDEA), providing the best tools for building apps on every type of [Android](https://www.android.com/new-features-on-android/featured/) device. `flatpak install flathub com.google.AndroidStudio`

<sup>&dagger;</sup>[KDevelop](https://kdevelop.org/) is a feature-rich, plugin-extensible IDE for (C++ and other) programming languages. `flatpak install flathub org.kde.kdevelop`

&mdash;&mdash;  
<sup>&dagger;</sup>Qt KDE applications sometimes require manual tweaking of environment variables (like `QT_AUTO_SCREEN_SCALE_FACTOR`) to size correctly on high-resolution screens.
