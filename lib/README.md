# lib

This is a directory of library shell scripts that are sourced by main shell scripts.

- `lib/index.sh` are the functions of the tasks

&mdash;

- `lib/apt.sh` has functions to install additional repository sources for APT to use. Can be run separately.
- `lib/fonts.sh` has function that installs a Nerd Font.
- `lib/java.sh` has function INSTALL\*MS_OPENJDK for installing OpenJDK's, the first of which shall be active.
- `lib/json.sh` has function to perform a shallow merge that updates a VS Code settings file with keys/values from a file in this repository. Unfortunately, the cost of this functionality is loss of JSON comments in the files.
- `lib/platforms.sh` sets vars identifying the platform. If unsupported, exits with a message to stderr saying so.

&hellip;
