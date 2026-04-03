# Databases

<!-- --

TODO:
    - Some mentioned tools are not installed
    - others are but need better links
    - GUI note and links to internal docs in flatpak and language ecosystems

<!-- -->

🚧 Note: This section is under construction. There is not a decent correlation between the programs mentioned on this page and implemented recipes or support, yet.

## CLI

In the era of agentic AI and pair programming, the terminal aka Command Line Interface is a bridge between an AI agent and a database. CLI tools allow AI agents to execute precise, piped commands and parse text-based results without the overhead of a heavy graphical wrapper.
A text-heavy approach ensures that a developer can maintain a "low-latency" feedback loop between their code editor and the database engine.

- ↪️ Run recipe: `just install-apt-packages`
- ✏️ Specify CLI tool packages in: [`apt/apt.Packages`](../apt/apt.Packages)

### Tools

[Harlequin](https://harlequin.sh/) is an open-source, terminal-based SQL Integrated Development Environment (IDE) that allows users to interact with various databases directly from their command line interface (CLI). It runs in any shell and provides features typically found in graphical IDEs, such as a data catalog browser, query editor with autocomplete, syntax highlighting, and a results viewer. 

### PostgreSQL

- [psql](https://www.postgresql.org/docs/current/app-psql.html) is the plain [PostgreSQL client](https://www.postgresql.org/docs/current/reference-client.html) that remains a standard due to its scriptability and easy integration with shell scripts; used with `pg_dump` is the standard utility for backing up a database into an archive and `pg_restore` is the companion tool for restoring them; and `createdb` etc commands.
- [pgcli](https://www.pgcli.com/) has auto-completion and syntax highlighting for Postgres

### Relational databases

- [MariaDB CLI](https://mariadb.com/docs/server/clients-and-utilities/mariadb-client/mariadb-command-line-client) is a plain client for MySQL & MariaDB
- [mycli](https://www.mycli.net/) has auto-completion and syntax highlighting for MySQL & MariaDB
- [SQLite 3 CLI](https://www.sqlite.org/) allows you to manually run SQL queries, create tables, and manage database files

### NoSQL

NoSQL database development, particularly within agentic workflows, relies heavily on CLI tools that can handle JSON or key-value structures with minimal friction.

- [mongosh](https://www.mongodb.com/docs/mongodb-shell/) is the modern shell that replaced the legacy mongo client, offering a powerful _Node.js-based environment_ for manipulating document collections
- [Redis CLI](https://redis.io/docs/latest/develop/tools/) tools for sending requests to the server, indispensable for real-time data debugging and state management

### Microsoft SQL (MSSQL)

[sqlcmd (Go)](https://learn.microsoft.com/en-us/sql/tools/sqlcmd/sqlcmd-utility?view=sql-server-ver17&tabs=go%2Cwindows-support&pivots=cs1-bash)
is a modern, cross-platform version of the classic Microsoft sqlcmd utility. Unlike the original version which relies on ODBC drivers, this version is written in the Go language and uses the go-mssqldb driver to connect to SQL databases. It is a standalone command-line tool used to run T-SQL queries and scripts. It is designed for modern workflows, running natively on Windows, macOS, Linux, and within containers.

[DBAtools](https://dbatools.io/) is a free, open-source _PowerShell_ module designed for Microsoft SQL Server automation. "The PowerShell toolkit for SQL Server professionals. Automate administration, migrations, disaster recovery, compliance." It is community-driven and contains over 700 commands that allow SQL professionals to manage, migrate, and automate SQL Server instances at scale. Unlike Microsoft’s built-in modules, DBAtools is often cited by the community as easier to use, and more powerful for daily DB administration. It has over 700 commands covering backups, restores, migrations, and instance configurations. Effortlessly manages one or hundreds of SQL instances from a single console. Can migrate entire SQL Server instances, including logins and jobs, in minutes rather than days. Runs on your workstation (like SSMS) and connects remotely; no installation is required on the SQL Server itself. Has Azure Trusted Signing, reducing antivirus false positives.

### Script notes

Whether writing commands at the shell prompt or in scripts, these tools are often used with

- [jq](https://jqlang.github.io/jq/) is a lightweight command-line JSON processor to enable you to slice & filter database outputs programmatically.
