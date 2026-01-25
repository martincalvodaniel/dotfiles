
---
name: agent-iteration
description: Run a full feature/change/fix iteration, including implementation, doc sync (README/AGENTS), and conventional commit message options.
argument-hint: Briefly describe the requested change or feature
---

# Agent Iteration (One-Stop)

Use this prompt for any iteration (feat/change/fix). It MUST run the full flow: clarify scope, plan, implement, verify, sync documentation (README.md and AGENTS.md), and produce conventional commit messages in the final response. If documentation updates are truly unnecessary, explicitly state why and confirm the checklist.

## Workflow Overview

1. **Clarify & Scope**: Confirm goal, constraints, acceptance criteria, affected areas, and whether behavior, API, data, or UI changes.
2. **Assess Context**: Inspect relevant files and current behavior. Note dependencies, feature flags, env vars, and tests.
3. **Plan Briefly**: Outline steps (implementation, tests, docs). Keep it concise; ask only if blockers.
4. **Implement**: Make the code change with tests/examples. Prefer small, verifiable steps. Add minimal comments only when non-obvious.
5. **Verify**: Note tests run (or if not run). Call out risks, edge cases, and TODOs if any.
6. **Documentation Sync (MANDATORY STEP)**: Apply the rules below to keep README.md and AGENTS.md aligned with the change. If no doc updates are needed, explain why each checklist item is satisfied.
7. **Commit Message**: Propose a primary conventional commit message plus 2 alternatives (type reflects actual code change, not docs). Always include these in the final answer.

## Documentation Sync & Keep Guidelines Updated

Update and maintain the three documentation files to ensure consistency and clarity for all developers and AI agents.

### Documentation Hierarchy

#### 1. README.md - Project Overview (User-Facing)
**Purpose**: Quick onboarding for new developers joining the project

**Should contain:**
- Clear project description and purpose
- Feature list (what the app does)
- Quick start instructions
- Links to detailed guides (point to AGENTS.md)
- Tech stack overview
- Deployment instructions
- Roadmap/Future plans

**Should NOT contain:**
- Detailed code patterns (→ AGENTS.md)
- Development guidelines (→ AGENTS.md)
- Architecture deep dives (→ AGENTS.md)

#### 2. AGENTS.md - Development Guidelines (Developer-Facing)
**Purpose**: Comprehensive guide for developers and AI agents building features

**Should contain:**
- Architecture patterns and data flow
- Code style conventions (TypeScript, React, API routes)
- Type safety guidelines with examples
- Common tasks & step-by-step patterns
- Database operation patterns
- Form handling patterns
- Validation patterns
- Error handling best practices
- Development workflow and setup
- File access guidelines
- Debugging tips
- Security notes
- Future development patterns for roadmap items

**When to update**: After any architectural decision, code pattern change, or when adding new features to the roadmap.

### Update Workflow

When implementing a new feature or making architectural changes:

1. **If it affects code patterns:**
	- Update AGENTS.md with the new pattern

2. **If it affects user-facing functionality:**
	- Update README.md Features section
	- Update AGENTS.md if implementation patterns changed

3. **If it affects development setup/process:**
	- Update AGENTS.md Development Workflow section
	- Update README.md Getting Started if prerequisites changed

4. **If roadmap item is implemented:**
	- Move from [ ] to [x] in both README.md and AGENTS.md
	- Document new patterns in AGENTS.md if applicable
	- Add to "Future Development Guidelines" section if it becomes a pattern

### Sections Needing Sync

#### Tech Stack Changes
- Update README.md → Tech Stack section
- Update AGENTS.md → Project Overview → Key Characteristics

#### New API Endpoints
- Add to README.md → API Endpoints section (what it does, request/response)
- Add pattern to AGENTS.md → Common Tasks if it's a repeatable pattern

#### New Component Types
- Add to AGENTS.md → Code Style & Conventions if new pattern
- Add example to component structure if applicable

#### New Database Operations
- Document pattern in AGENTS.md → Database Operations
- Add to Code Style & Conventions if it's a common pattern
- Ensure type safety guidelines cover it

#### Build/Development Process Changes
- Update AGENTS.md → Development Workflow
- Update README.md → Getting Started if significant

### Validation Checklist

Before considering documentation complete:

- [ ] README.md matches actual project features and setup
- [ ] AGENTS.md reflects all established patterns in the codebase
- [ ] All code examples in docs are accurate and follow shown patterns
- [ ] Links between documents are correct
- [ ] Roadmap status ([x] vs [ ]) is consistent across files
- [ ] No contradictions between documents
- [ ] New patterns are documented before implementing wide adoption
- [ ] Commit message generated following conventional format with 2-3 alternatives provided

If any item is not applicable, explicitly mark it n/a with a one-line reason.

### Common Scenarios

#### Adding a new validated API endpoint for a different resource
1. Add example to AGENTS.md → Common Tasks & Patterns → Adding a New API Endpoint
2. Document endpoint in README.md → API Endpoints with request/response

#### Implementing a roadmap feature (e.g., edit/delete, authentication)
1. Move checkbox in README.md and AGENTS.md from [ ] to [x]
2. Add pattern documentation to AGENTS.md → Future Development Guidelines (now past work)
3. Update AGENTS.md → Common Tasks if applicable

#### Changing code style/conventions (e.g., new TypeScript constraint)
1. Update all affected sections in AGENTS.md
3. Update README.md only if it's a user-visible change
4. Add before-completing checklist items if it affects all tasks

#### Adding new environment variables or config
1. Update AGENTS.md → Environment Variables section
2. Update README.md → Getting Started if end-user needs to configure it
3. Update AGENTS.md → Setup section in Development Workflow if dev-only

### Key Principles for Documentation

✅ Single source of truth: Don't duplicate patterns - reference instead  
✅ Keep it current: Update immediately after code changes, not later  
✅ Clarity over completeness: Better to be concise and clear than verbose  
✅ Examples matter: Include code examples for abstract patterns  
✅ Link docs together: Users should navigate naturally between files  
✅ Different audiences: README for users, AGENTS.md for builders

### Commit Message Generation (after sync)

After analyzing and updating documentation, generate a clear, professional git commit message following conventional commit format. Focus on the actual feature/code change, not the documentation update itself. Documentation changes are supporting work included in the commit.

#### Task Steps

1. **Identify the Change Type**
	- Determine the primary type based on the actual code/feature change, not the documentation work:
	  - feat: new API endpoint, new component, new pattern
	  - refactor: restructured logic, changed patterns, API redesign
	  - fix: bug fix, corrected behavior
	  - perf: performance improvement
	  - chore: infrastructure, dependencies, build changes
	  - Use docs ONLY if documentation changes exist without any code changes
	- Review what was implemented to assess the primary nature

2. **Extract Key Information**
	- What was the actual problem or goal? (Why was this work done?)
	- What code/feature was added, changed, or fixed?
	- Which files or components were affected by the real work?
	- What is the user-facing or developer-facing impact of the change (not the docs)?
	- Are there any breaking changes to the actual implementation?
	- What documentation was synced to reflect this change?

3. **Draft the Commit Message**
	- Subject line (max 50 characters):
	  - Use the format: type(scope): brief description
	  - Focus on the code change, not documentation
	  - Start with lowercase verb matching the actual work (add, implement, refactor, fix, etc.)
	  - Example: feat(api): add user authentication not docs: document new auth
	- Body (if needed):
	  - Explain why this change was made (business goal, technical need)
	  - Describe what was implemented or changed
	  - Include which documentation was updated to reflect this change
	  - Reference related issues or tickets
	  - List breaking changes explicitly
	- Footer (if needed):
	  - Add issue references: Closes #123
	  - Add co-authors if applicable

4. **Validate Against Standards**
	- Subject line is 50 characters or less
	- Commit type reflects the actual code change, not documentation
	- Scope is clear and specific to the feature/code change
	- Message explains why the feature was built, not just what docs were updated
	- Body mentions synced documentation as supporting context
	- No imperative mood issues or unnecessary details
	- No generic messages like "update docs", "sync files", "WIP"

5. **Provide Alternatives**
	- Offer 2-3 variations if the change spans multiple work areas
	- Label them as "Primary", "Alternative 1", "Alternative 2"
	- Each should reflect different emphasis on the actual work vs. documentation scope

### Success Criteria

✓ Message describes the actual feature/code change, not the documentation update  
✓ Subject line reflects real work type (feat, fix, refactor, etc.)  
✓ Body mentions documentation sync as supporting context  
✓ Explains why the change was made, not just what docs were updated  
✓ Type/scope are accurate and focused on implementation  
✓ No vague or generic terminology  
✓ Professional and ready for production git history

## Final Response Format (Do not skip)

- **Changes**: Brief bullet list of key code changes.
- **Docs**: List doc updates performed with file links; if none, say "None needed" and justify against the checklist.
- **Tests**: Tests run (or "Not run" with reason).
- **Risks**: Known risks/edge cases or "None noted".
- **Commit Messages**: Provide Primary, Alternative 1, Alternative 2 in conventional format reflecting actual code change.

### Examples of Good Commit Messages (Documentation Included)

```
feat(auth): implement user authentication with JWT tokens

Add JWT-based authentication system for user login/logout.
Includes secure token generation, validation, and refresh flow.

Updated AGENTS.md with new authentication patterns and setup
instructions. Updated README.md Quick Start with login examples.

Closes #123
```

```
refactor(database): restructure transaction handling patterns

Replace callback-based transaction handling with async/await pattern.
Improve error recovery and add automatic rollback on failures.

Synced AGENTS.md with new database operation patterns and updated
Common Tasks section with migration examples for existing code.
```

```
fix(api): resolve race condition in concurrent requests

Fix data corruption issue in concurrent request handlers by adding
proper request queuing. New pattern prevents simultaneous writes.

Updated AGENTS.md with corrected concurrency guidelines and added
warning about deprecated parallel processing approach.
```

