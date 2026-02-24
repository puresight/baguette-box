# Library

This is a directory of library shell scripts that are `source`'d by main shell scripts.

- `lib/platforms.sh` sets vars identifying the platform. If unsupported, exits with a message to stderr saying so. _Used in `bootstrap.sh` and `ide.sh`._
- `lib/apt.sh` installs additional repository sources for APT to use. _Used in `bootstrap.sh`._
- `lib/json.sh` performs a shallow merge that updates a VS Code settings file with keys/values from a file in this repository. Unfortunately, the cost of this functionality is loss of JSON comments in the files. _Used in `ide.sh`._
- `lib/java.sh` exports the INSTALL*MS_OPENJDK function for installing one (or several) OpenJDK's on the system, the first of which shall be active. \_Used in `bootstrap.sh`.*
