# Agents

## Mode

When collaborating on specs, do not switch modes to implement anything, until the user gives clear direction that it is time to implement.

## Style

- Follow the [Google Style Guides](https://google.github.io/styleguide/). Particularly relevant for this repo is the [Shell Style Guide](https://google.github.io/styleguide/shellguide.html).
- DX is a priority.
- Maintain a separation of concerns. And maintain a separation of languages also where appropriate.
- Always end code files with a new line.

## justfile's

Limit shell commands in justfile's to the minimum necessary for invocation. Keep non-trivial scripting in language specific (e.g. bash) files that an IDE shall do syntax highlighting and checking on.

## OS

### Bluefin

Bluefin is a Fedora atomic (immutable) distribution derived from Silverblue.
Using Homebrew is often its recommended way to manage users' system dev dependencies, because it allow users to install toolchains without layering them onto the core system via rpm-ostree -- which keeps system updates fast and the base OS clean.
