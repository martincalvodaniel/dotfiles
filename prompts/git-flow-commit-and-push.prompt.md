---
name: git-flow-commit-and-push
description: Create a feature branch, commit changes with a message, and push to remote.
argument-hint: Commit message options and branch name options to select from
---

# Git Flow: Commit and Push Changes

Follow this workflow to prepare and push your code changes:

1. **Analyze Changes**: Review the current uncommitted changes in the repository to understand what modifications have been made.

2. **Generate Options**: Based on the changes, create 3 options each for:
   - Commit messages (following conventional commits: feat, fix, refactor, docs, etc.)
   - Branch names (following feature naming conventions: `feature/description`)

3. **Present Selections**: Display the options to the user and ask them to select one option for the commit message and one for the branch name.

4. **Execute Git Workflow**:
   - Create a new branch with the selected name
   - Checkout the new branch
   - Stage all changes
   - Commit with the selected message
   - Push the branch to remote

5. **Confirm**: Provide a summary of the completed actions, including:
   - Branch name created
   - Commit message used
   - Push status

**Best Practices**:
- Use conventional commit format for clear, semantic commit messages
- Use descriptive, kebab-case branch names
- Ensure changes are thoroughly reviewed before committing
- Always push to establish the remote tracking branch
