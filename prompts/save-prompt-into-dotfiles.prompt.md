```prompt
---
name: save-prompt-into-dotfiles.prompt
description: Generalize and save the current discussion as a reusable prompt into $HOME/.dotfiles/prompts folder.
argument-hint: Optional - specify a custom prompt name or let the system generate one from the task context
tools: [ 'edit', 'search' ]
---

Generalize the current discussion into a reusable prompt that can be saved to the $HOME/.dotfiles/prompts folder.

Think step by step:
1. Review the conversation to identify the user's primary goal or task pattern
2. If there is no conversation present, reply to the user that this prompt expects an active discussion to generalize. Keep the reply concise.
3. Generalize the task into a reusable prompt that could apply to similar scenarios
4. Extract the core intent, removing conversation-specific details (e.g., specific file names, variable names, or project-specific context)
5. Craft the generalized multi-line markdown text prompt, using placeholders where appropriate (e.g., "the selected code", "the current file", "the specified functionality")
6. Create a very concise action-oriented title in hyphen-separated format that will be used for the slash command (1-3 words, e.g., "generate-unit-tests", "refactor-for-performance", "explain-api-design", etc)
7. Write a brief description (1 sentence, max 15 words) explaining the goal of the prompt
8. If applicable, define an argument-hint that describes the expected inputs for the prompt
9. Save the resulting prompt in the `$HOME/.dotfiles/prompts` folder as `${promptFileName}.prompt.md`, where `${promptFileName}` is the concise action-oriented title from step 6

Here's the expected output format:
```
---
name: ${The concise title in hyphen-separated format. You can only use letters, digits, underscores, hyphens, and periods}
description: ${A brief description (1 sentence) explaining the goal of the prompt}
argument-hint: ${A description of the expected inputs for the prompt, if any}
tools: ${An array of tools required for the prompt, e.g., [ 'edit', 'search' ]}
---
${The generalized multi-line markdown text prompt}
```

```
