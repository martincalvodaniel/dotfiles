---
name: git_generate-commit-message
description: Generate a well-structured commit message for recent code changes.
argument-hint: Optional - description of changes made, technologies involved, or specific context. If omitted, analyze git diff or provided context.
---

Generate a clear, professional git commit message following conventional commit format based on the work performed.

## Task Steps

1. **Identify the Change Type**
   - Determine if this is a feature (`feat`), bug fix (`fix`), refactor (`refactor`), documentation (`docs`), style (`style`), test (`test`), chore (`chore`), or performance (`perf`) change
   - Review code modifications or context to assess the primary nature of the work

2. **Extract Key Information**
   - What was the problem or goal? (Why was this work done?)
   - What files or components were affected?
   - What is the user-facing or developer-facing impact?
   - Are there any breaking changes, new dependencies, or significant architectural shifts?

3. **Draft the Commit Message**
   - **Subject line** (max 50 characters):
     - Use the format: `type(scope): brief description`
     - Start with lowercase verb (add, create, implement, refactor, fix, remove, etc.)
     - Be specific and concise
   - **Body** (if needed):
     - Explain the *why* and *what*, not the *how*
     - Reference any related issues or tickets
     - List breaking changes explicitly
   - **Footer** (if needed):
     - Add issue references: `Closes #123`
     - Add co-authors if applicable

4. **Validate Against Standards**
   - Subject line is 50 characters or less
   - Commit type is accurate and conventional
   - Scope is clear and specific (if used)
   - Message explains the change's purpose
   - No imperative mood issues or unnecessary details
   - No generic messages like "update", "fix stuff", "WIP"

5. **Provide Alternatives**
   - Offer 2-3 variations if the context allows multiple interpretations
   - Label them as "Alternative 1", "Alternative 2", etc.

## Success Criteria

✓ Message follows conventional commit format
✓ Subject line is clear, specific, and ≤50 chars
✓ Type/scope are accurate and consistent
✓ Explains *why* the change was made, not just *what*
✓ No vague or generic terminology
✓ Professional and ready for production git history

## Examples of Good Commit Messages

```
feat(repositories): externalize projects data to JSON database

Refactor projects configuration from hardcoded bash variables to
external JSON database files (repositories.json and
repositories-grouped-by-project.json) for improved maintainability
and reusability.

Closes #42
```

```
refactor(sync-workspace): implement interactive confirmation workflow

Add mandatory preview-confirm pattern to all database modifications.
Replace deprecated dry-run flag with consistent interactive flow:
preview changes → ask confirmation → apply only on approval.
```

```
fix(script): resolve database sync race condition in add_repository
```
