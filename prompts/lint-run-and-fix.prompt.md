---
name: lint-run-and-fix
description: Run linter and systematically fix all warnings and errors.
argument-hint: Optional - specify custom lint command (defaults to `pnpm lint`)
---

Run the linter and fix any warnings or errors that are reported.

## Task Steps

1. **Run the Linter**
   - Execute the lint command (default: `pnpm lint`, or custom command if specified)
   - Capture all warnings and errors with their file paths and line numbers

2. **Analyze Issues**
   - For each warning/error, identify:
     - The file path and exact line location
     - The specific rule violation or issue
     - The root cause
     - The appropriate fix

3. **Apply Fixes**
   - Read the affected source files to understand context
   - Apply corrections systematically using multi-operation replacements when possible
   - Ensure fixes are idiomatic and follow the project's conventions

4. **Verify Resolution**
   - Run the linter again to confirm all issues are resolved
   - No warnings or errors should remain
   - All changes should be focused only on fixing the reported issues

## Success Criteria

✓ All linter warnings and errors have been resolved
✓ Linter runs cleanly with no output (or only informational messages)
✓ Changes are minimal and targeted to reported issues
✓ Code style and conventions are maintained
