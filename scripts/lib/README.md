# lib

This is a directory of the library scripts that help.

- `scripts/json.sh` has function to perform a shallow merge that updates a VS Code settings file with keys/values from a file in this repository. Unfortunately, the cost of this functionality is loss of JSON comments in the files.
- `scripts/platforms.sh` sets vars identifying the platform. If unsupported, exits with a message to stderr saying so.
