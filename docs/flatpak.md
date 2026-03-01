# Flatpak

[Flatpak](https://flathub.org/) is a Linux package management system that bundles an app with all its necessary dependencies in a container, allowing isolation from the rest of the system. [Flathub](https://flathub.org/) lists 3300+ applications.

## Applications

[DbGate](https://docs.dbgate.io/) is smart, open-source database client that works with MySQL, PostgreSQL, SQL Server, and MongoDB. It's lightweight, open-source database manager with good support for PostgreSQL, MariaDB/MySQL, Redis (and MongoDB, etc.). Has a tabbed interface, query builder, data grids, SSH tunnels. Works well via Flatpak on GNOME. Simpler than DBeaver but still multi-DB capable. `flatpak install flathub org.dbgate.DBGate`

[Beekeeper Studio](https://www.beekeeperstudio.io/) is a modern, easy-to-use SQL editor and database manager that is well-regarded for its clean UI and cross-platform support. It's clean, modern, intuitive interface focused on simplicity. Excellent table data browsing/editing (spreadsheet-like), SQL editor, schema navigation. Strong PostgreSQL and MariaDB/MySQL support; solid Redis client (browse keys, edit values/TTLs, run commands with completions). GNOME-friendly design. Best for clean browsing/editing of remote tables/keys without overwhelming features. `flatpak install flathub io.beekeeperstudio.Studio`

[DBeaver](https://dbeaver.io/) (community edition) is a comprehensive universal database tool for developers and database administrators. It's a universal database manager with excellent support for PostgreSQL (including extensions like pgvector), MariaDB/MySQL, Redis, and dozens more. Tree-based browser for schemas/tables/keys, powerful SQL editor with autocompletion, data viewer/editor, ER diagrams, export/import, SSH tunneling for secure remote access. It's Java-based but runs smoothly via Flatpak, with a modern dark mode support and doesn't feel out of place. Best for multi-database workflows, heavy Postgres/MariaDB use + occasional Redis. `flatpak install flathub io.dbeaver.DBeaverCommunity`

[DB Browser for SQLite](https://sqlitebrowser.org/) (formerly SQLiteBrowser) is a high-quality visual tool to create, design, and edit database files compatible with SQLite. It provides a visual, spreadsheet-like interface for managing databases without requiring complex SQL commands. Caveat: Since it is built using the Qt framework, the initial installation may trigger a download of the KDE Application Platform runtime (approx. 700MB) if you don't already have it installed. `flatpak install flathub org.sqlitebrowser.sqlitebrowser`

[KDevelop](https://kdevelop.org/) is a feature-rich, plugin-extensible IDE for (C++ and other) programming languages. `flatpak install flathub org.kde.kdevelop`

&hellip;
