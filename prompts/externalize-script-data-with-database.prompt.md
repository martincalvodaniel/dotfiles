---
name: externalize-script-data-with-database
description: Extract hardcoded data from a script into external database files with query methods.
argument-hint: Script file path, data structure description, and desired query patterns
tools: [ 'edit', 'search' ]
---

# Externalize Script Data with Database Query Methods

You have a script with hardcoded data embedded in variables or strings. The goal is to:

1. **Extract the data** into external database files (JSON format) with the following structure:
   - A "flat" database file containing individual records with all attributes (e.g., `repositories.json` with `project` and `repository` fields)
   - A "grouped view" database file organized by a primary attribute (e.g., `repositories-grouped-by-project.json` where projects are keys and repositories are arrays)

2. **Organize the data** such that:
   - All entries in both files are alphabetically ordered
   - Fields within each record are consistent
   - The grouped view uses a clear hierarchical structure

3. **Name the files** following the pattern:
   - Database: `${ENTITY}.json` (e.g., `repositories.json`)
   - Grouped view: `${ENTITY}-grouped-by-${ATTRIBUTE}.json` (e.g., `repositories-grouped-by-project.json`)

4. **Create a query method** in the script named following the grouped view pattern:
   - `get_${ENTITY}_grouped_by_${ATTRIBUTE}()`
   - Accept the grouping attribute value as a parameter
   - Read from the grouped view JSON file using `jq`
   - Handle errors gracefully (missing files, invalid input, jq dependency)
   - Return the queried data or an error code

5. **Integrate the method** into the script by:
   - Adding the database file path as a script configuration variable
   - Implementing the query function with proper error handling
   - Adding command-line options to invoke the query function (e.g., `--project PROJECTNAME`)
   - Updating the help/usage documentation with the new options

## Example Pattern

If you have:
```bash
PROJECTS="
project_a:repo1,repo2
project_b:repo3,repo4
"
```

Extract to:
- `repositories.json` - flat list with `project` and `repository` fields
- `repositories-grouped-by-project.json` - projects as keys with repository arrays
- Add `get_repositories_grouped_by_project()` function to query the database
- Add `-p, --project PROJECT` option to the script

This approach makes the data maintainable, queryable, and decoupled from script logic.
