# Aider

[Aider](https://aider.chat/docs/) is an open-source AI coding assistant designed to function as a pair programmer directly within your terminal. Unlike most AI tools that require you to copy and paste code into a web chat, Aider connects to your _local repository_ to edit files in place and automatically commit changes with descriptive messages.

Aider can understand and modify multiple files simultaneously to complete complex tasks. Aider has broad model support. Aider creates a [repo map](https://aider.chat/docs/repomap.html) of your codebase, which provides the AI with deep context of how functions & classes relate.

## Pairing

For ideas about how to pair with Aider, read [Usage](https://aider.chat/docs/usage.html).

Pairing with Aider requires a shift from traditional manual coding to an "editor-in-chief" mindset. Since **Aider integrates with git,** your main role is to guide its logic and audit its commits.

- **Use Architect Mode:** Start complex tasks with `/architect`. This forces Aider to propose a plan before writing code, allowing you to catch logic errors before they are committed.
- **Curate the Context:** Only `/add` the files directly relevant to the current task. Adding too many files confuses the LLM and increases token costs.
- **Small, Atomic Steps:** Break large features into tiny, testable sub-tasks. Request one change at a time so that Aider’s auto-commits remain focused and easy to revert.
- **Automate Validation:** Use the `--test` and `--lint` flags to make Aider run your test suite after every change. It can then automatically fix any errors it introduced.

### Reviewing tips

- **Quick Undo:** If a commit looks wrong, immediately use the `/undo` command. This reverts the last commit and tells Aider the previous approach failed.
- **Diff-First Review:** Use `/run git diff HEAD~1` to see exactly what changed in the most recent commit within the chat interface.
- **External PR Workflow:** For critical work, use Aider on a feature branch and push to GitHub/GitLab. Reviewing the final diff in a standard Pull Request UI provides a more readable overview than the terminal.
- **Branch Gardening:** Aider sometimes guesses poorly on commit boundaries (e.g., mixing frontend and backend changes). Be prepared to use `git rebase -i` to squash or split Aider's work before merging to main.

## Aider in VS Code

One way to work with VS Code and Aider simultaneously is to run Aier in VS Code's integrated **terminal** panel. When you open the VS Code terminal view, run Aider there.

- Architecting: Run `/architect` in the terminal. As Aider describes the plan, open those files in VS Code tabs to follow along.
- Real-time Audit: As Aider writes code, watch the gutter indicators (blue/green/red bars next to line numbers) in VS Code. If a bar appears in a section Aider shouldn't be touching, interrupt it.
- The "Commit Review" Ritual: Before moving to the next task, click the Git icon in VS Code. Review the auto-generated commit message and the diff. If it’s wrong, type `/undo` in the terminal; if it’s right, keep going.
- If you find Aider’s auto-commits too aggressive for your workflow, you can disable them in your `~/.aider.conf.yml` file. This lets you use Aider to generate code and then use VS Code to manually review and commit the "dirty" files yourself.
  ```yaml
  auto-commits: false
  dirty-commits: false
  ```
