---
name: sync-documentation
description: This prompt is used to synchronize and update project documentation files to ensure consistency between README.md and AGENTS.md.
---

# Sync Documentation & Keep Guidelines Updated

Update and maintain the three documentation files to ensure consistency and clarity for all developers and AI agents.

## Documentation Hierarchy

### 1. **README.md** - Project Overview (User-Facing)
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

### 2. **AGENTS.md** - Development Guidelines (Developer-Facing)
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

## Update Workflow

When implementing a new feature or making architectural changes:

1. **If it affects code patterns:**
   - Update `AGENTS.md` with the new pattern

2. **If it affects user-facing functionality:**
   - Update `README.md` Features section
   - Update `AGENTS.md` if implementation patterns changed

3. **If it affects development setup/process:**
   - Update `AGENTS.md` Development Workflow section
   - Update `README.md` Getting Started if prerequisites changed

4. **If roadmap item is implemented:**
   - Move from `[ ]` to `[x]` in both `README.md` and `AGENTS.md`
   - Document new patterns in `AGENTS.md` if applicable
   - Add to "Future Development Guidelines" section if it becomes a pattern

## Sections Needing Sync

### Tech Stack Changes
- Update `README.md` → Tech Stack section
- Update `AGENTS.md` → Project Overview → Key Characteristics

### New API Endpoints
- Add to `README.md` → API Endpoints section (what it does, request/response)
- Add pattern to `AGENTS.md` → Common Tasks if it's a repeatable pattern

### New Component Types
- Add to `AGENTS.md` → Code Style & Conventions if new pattern
- Add example to component structure if applicable

### New Database Operations
- Document pattern in `AGENTS.md` → Database Operations
- Add to Code Style & Conventions if it's a common pattern
- Ensure type safety guidelines cover it

### Build/Development Process Changes
- Update `AGENTS.md` → Development Workflow
- Update `README.md` → Getting Started if significant

## Validation Checklist

Before considering documentation complete:

- [ ] `README.md` matches actual project features and setup
- [ ] `AGENTS.md` reflects all established patterns in the codebase
- [ ] All code examples in docs are accurate and follow shown patterns
- [ ] Links between documents are correct
- [ ] Roadmap status (`[x]` vs `[ ]`) is consistent across files
- [ ] No contradictions between documents
- [ ] New patterns are documented before implementing wide adoption
- [ ] Commit message generated following conventional format with 2-3 alternatives provided

## Common Scenarios

### Adding a new validated API endpoint for a different resource
1. Add example to `AGENTS.md` → Common Tasks & Patterns → Adding a New API Endpoint
2. Document endpoint in `README.md` → API Endpoints with request/response

### Implementing a roadmap feature (e.g., edit/delete, authentication)
1. Move checkbox in `README.md` and `AGENTS.md` from `[ ]` to `[x]`
2. Add pattern documentation to `AGENTS.md` → Future Development Guidelines (now past work)
3. Update `AGENTS.md` → Common Tasks if applicable

### Changing code style/conventions (e.g., new TypeScript constraint)
1. Update all affected sections in `AGENTS.md`
3. Update README.md only if it's a user-visible change
4. Add before-completing checklist items if it affects all tasks

### Adding new environment variables or config
1. Update `AGENTS.md` → Environment Variables section
2. Update `README.md` → Getting Started if end-user needs to configure it
3. Update `AGENTS.md` → Setup section in Development Workflow if dev-only

## Key Principles for Documentation

✅ **Single source of truth**: Don't duplicate patterns - reference instead  
✅ **Keep it current**: Update immediately after code changes, not later  
✅ **Clarity over completeness**: Better to be concise and clear than verbose  
✅ **Examples matter**: Include code examples for abstract patterns  
✅ **Link docs together**: Users should navigate naturally between files  
✅ **Different audiences**: README for users, AGENTS.md for builders

## Commit Message Generation (after sync)

After analyzing and updating documentation, generate a clear, professional git commit message following conventional commit format to document the sync work.

### Task Steps

1. **Identify the Change Type**
   - Choose `docs` (default for documentation sync)
   - Alternative types only if significant beyond docs: `chore` (tooling changes), `refactor` (restructure), `feat` (new guidance)
   - Review what was modified to assess the primary nature across all files

2. **Extract Key Information**
   - What was the problem or goal? (Why was sync needed?)
   - Which documentation files were affected? (README.md, AGENTS.md, both)
   - What sections were updated or added?
   - What is the user-facing or developer-facing impact?
   - Are there any breaking changes to documented patterns or guidelines?

3. **Draft the Commit Message**
   - **Subject line** (max 50 characters):
     - Use the format: `type(scope): brief description`
     - Start with lowercase verb (sync, update, refactor, add, clarify, document, etc.)
     - Be specific: name the scope if possible (e.g., `README`, `AGENTS`, `documentation`)
     - Be concise and clear
   - **Body** (if needed):
     - Explain the *why* and *what*, not the *how*
     - List which docs were synchronized and what changed
     - Reference related issues or feature implementations
     - Explicitly list breaking changes if documented patterns changed
   - **Footer** (if needed):
     - Add issue references: `Closes #123`
     - Add co-authors if applicable

4. **Validate Against Standards**
   - Subject line is 50 characters or less
   - Commit type is `docs` or justified alternative
   - Scope clearly identifies which docs (if applicable)
   - Message explains *why* sync was needed, not just *what* changed
   - No imperative mood issues or unnecessary details
   - No generic messages like "update docs", "sync files", "WIP"

5. **Provide Alternatives**
   - Offer 2-3 variations if the sync spans multiple kinds of changes
   - Label them as "Primary", "Alternative 1", "Alternative 2"
   - Each should reflect slightly different emphasis or scope focus

### Success Criteria

✓ Message follows conventional commit format  
✓ Subject line is clear, specific, and ≤50 chars  
✓ Type/scope are accurate (docs scope is clear)  
✓ Explains *why* documentation was synced, not just *what* changed  
✓ References specific files or sections updated  
✓ No vague or generic terminology  
✓ Professional and ready for production git history  

### Examples of Good Commit Messages for Doc Sync

```
docs(README): clarify quick start and add deployment section

Update README.md to include step-by-step quick start instructions
and add comprehensive deployment guidelines. Reorganize sections for
better onboarding of new developers.
```

```
docs(AGENTS): document new database operation patterns

Sync AGENTS.md with newly established patterns for database
operations, transaction handling, and error recovery. Add code
examples for common use cases and best practices.

Addresses improved developer guidance for data layer work.
```

```
docs: synchronize README and AGENTS after API refactor

Update both README.md and AGENTS.md to reflect new API endpoint
structure and deprecated patterns. Move old patterns to archived
section and document migration path for existing consumers.

Breaking change: Old API endpoint format no longer documented.
```

