# Just migration

This is the author's plan to start migrating this repo into a _Just_ recipes user interface.

## To do

This migration work involves planning, implementing, and documenting the Just way.

### Strategy

- Retain use of `box.sh` as the dispatcher of YAML-defined tasks for now. The just interface should be a compatible addition. The docs for the old way can be moved into the `docs` directory, to let the new way take the spotlight.
- Add pattern for this repo of a user using Just commands at the shell prompt to run simple (or more complex) recipes to accomplish the defined objective(s).

### Tactics & Resources

- Use `bootstrap.yaml` & `code.yaml` & `ansible.yaml` lists of tasks (with argumentes) as resources for creating equivelant Just commands.

### Documentation

- Write a `just.md` file in the `docs` directory with a paragraph summary of what Just is, including a hyperlink to the 📖 [Just Programmer's Manual](https://just.systems/man/en/).
    - Explain how Just is a new best practice for project DevOps that can be used on workstations and in CI/CD workflows (e.g. in Github Actions).
    - Give a short list of good, practical examples of repo's using Just correctly, on Github.
    - Include a Just version of the YAML config's ./docs/README.md instructions
- Add instructions to the repo's main `README.md` guiding the user with options on installing the Just prerequisite.
