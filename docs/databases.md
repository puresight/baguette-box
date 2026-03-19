# Databases

<!-- --

TODO:
    - Some mentioned tools are not installed
    - others are but need better links
    - GUI note and links to internal docs in flatpak and language ecosystems

<!-- -->

## CLI

In the era of agentic AI and pair programming, the terminal aka Command Line Interface is a bridge between an AI agent and a database. CLI tools allow AI agents to execute precise, piped commands and parse text-based results without the overhead of a heavy graphical wrapper.
A text-heavy approach ensures that a developer can maintain a "low-latency" feedback loop between their code editor and the database engine.

### PostgreSQL

- [psql](https://www.postgresql.org/docs/current/app-psql.html) is the plain [PostgreSQL client](https://www.postgresql.org/docs/current/reference-client.html) that remains a standard due to its scriptability and easy integration with shell scripts; used with `pg_dump` is the standard utility for backing up a database into an archive and `pg_restore` is the companion tool for restoring them; and `createdb` etc commands.
- [pgcli](https://www.pgcli.com/) has auto-completion and syntax highlighting for Postgres

### MySQL etc

- [MariaDB CLI](https://mariadb.com/docs/server/clients-and-utilities/mariadb-client/mariadb-command-line-client) is a plain client for MySQL & MariaDB
- [mycli](https://www.mycli.net/) has auto-completion and syntax highlighting for MySQL & MariaDB
- [SQLite 3 CLI](https://www.sqlite.org/) allows you to manually run SQL queries, create tables, and manage database files

### NoSQL

NoSQL database development, particularly within agentic workflows, relies heavily on CLI tools that can handle JSON or key-value structures with minimal friction.

- [mongosh](https://www.mongodb.com/docs/mongodb-shell/) is the modern shell that replaced the legacy mongo client, offering a powerful _Node.js-based environment_ for manipulating document collections
- [Redis CLI](https://redis.io/docs/latest/develop/tools/) tools for sending requests to the server, indispensable for real-time data debugging and state management

### Script notes

Whether writing commands at the shell prompt or in scripts, these tools are often used with

- [jq](https://jqlang.github.io/jq/), a lightweight command-line JSON processor, to allow developers and AI agents to slice and filter database outputs programmatically.
