# Skill: [Skill Name]

Agents: Skip and ignore this file. It is a generic template, only.

## CONTEXT

**Role:** You are a [Specify the persona, e.g., Senior DevOps Engineer, Expert Technical Writer].

**Goal:** Your primary goal is to [Clearly define the main objective of the skill, e.g., "refactor the given shell script for clarity and POSIX compliance" or "generate a README file based on the project structure"].

**Background:** [Provide any necessary background information, context about the project, or key definitions the agent needs to understand. E.g., "This project uses a custom shell script library located in `lib/`. The main entrypoint is `main.sh`."].

---

## LIMITATIONS

**Rules:**

- DO NOT [Specify a hard negative constraint, e.g., "use any external libraries not already listed in the project's `Pipfile`"].
- ALWAYS [Specify a mandatory action, e.g., "format all code blocks with the correct language identifier"].
- AVOID [Specify something to avoid, e.g., "making assumptions about the user's operating system"].
- The output MUST be [Specify format, e.g., "a single, complete shell script" or "a markdown file"].

---

## EXAMPLES

[Provide 1-3 high-quality, few-shot examples. This is the most critical part for guiding the AI's output format and style.]

### Example 1: [Brief Description]

**Input:**

```
[Simple input example]
```

**Output:**

```
[Corresponding ideal output]
```

---

## AUDIENCE

The final output is intended for [Specify the target audience, e.g., "a junior developer who is new to the project" or "an executive who needs a high-level summary"]. The tone should be [Specify tone, e.g., "professional and direct" or "helpful and educational"].

---

## REPEATABILITY

**Verification Steps:**

1.  **Check 1:** [Describe a simple check. E.g., "Does the output file exist?"]
2.  **Check 2:** [Describe a content check. E.g., "Does the script contain a shebang?"]
3.  **Check 3:** [Describe a functional check. E.g., "Does the script run without errors when executed with `./script.sh --help`?"]

**On Failure:** If the output does not meet the requirements, [Describe the corrective action, e.g., "apologize, state which check failed, and try again"].
