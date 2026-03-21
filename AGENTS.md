# Agents

## Mode

When collaborating on specs, do not switch modes to implement anything, until the user gives clear direction that it is time to implement.

## Style

DX is a priority.

Maintain a separation of concerns. And maintain a separation of languages also where appropriate.

Always end code files with a new line.

## justfile's

Limit shell commands in justfile's to the minimum necessary for invocation. Keep non-trivial scripting in language specific (e.g. bash) files that an IDE shall do syntax highlighting and checking on.
