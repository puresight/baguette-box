# Library

The `functions.sh` script has bash functions

- **UPDATE_JSON:** performs a shallow merge that updates a VS Code settings file with keys/values from a file in this repository. Unfortunately, the cost of this functionality is loss of JSON comments in the files!
- **LOG_UNSUPPORTED:** writes a message to stderr saying the host OS is not supported, and exits
