---
name: output-files
description: Define standardized naming conventions for script output files to ensure consistency and traceability
argument-hint: Script name and output format
---

# Output File Naming Convention

Define a standardized naming convention for script output files to ensure consistency and traceability.

## File Name Format

Output files should follow this naming pattern:
```
scriptName-YYYYMMDD-HHmm-ITER.format
```

### Components
- `scriptName`: The name of the executing script
- `YYYYMMDD`: Date in the format:
  - YYYY: Four-digit year
  - MM: Two-digit month (01-12)
  - DD: Two-digit day (01-31)
- `HHmm`: Time in 24-hour format:
  - HH: Two-digit hours (00-23)
  - mm: Two-digit minutes (00-59)
- `ITER`: Iteration number of the loop execution
- `format`: File extension matching the output format (e.g., `.json`, `.csv`, `.log`)

## Examples

```bash
# Single execution
myScript-20250403-1430-1.json

# Multiple iterations
myScript-20250403-1430-1.json
myScript-20250403-1430-2.json
myScript-20250403-1430-3.json
```

## Implementation Guidelines

1. **Timestamp Requirements**
   - Always use the full timestamp to ensure unique file names
   - Use leading zeros for single-digit values in dates and times

2. **Iteration Numbering**
   - Keep the iteration number even for single executions
   - Increment for each loop iteration or batch execution

3. **File Format**
   - Match the file extension to the actual output format
   - Use lowercase extensions for consistency

## Implementation Example

When implementing this naming convention in scripts:

```bash
# Bash example
timestamp=$(date '+%Y%m%d-%H%M')
filename="${scriptName}-${timestamp}-${iter}.json"
```