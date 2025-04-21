# Output File Naming Convention

## Purpose
Define a standardized naming convention for script output files to ensure consistency and traceability.

## File Name Format
The output files should follow this naming pattern:
```
scriptName-YYYYMMDD-HHmm-ITER.json
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

## Examples
```bash
# Single execution
myScript-20250403-1430-1.json

# Multiple iterations
myScript-20250403-1430-1.json
myScript-20250403-1430-2.json
myScript-20250403-1430-3.json
```

## Usage Guidelines
1. Always use the full timestamp to ensure unique file names
2. Keep the iteration number even for single executions
3. Use leading zeros for single-digit values in dates and times
4. The file extension should match the actual output format (.json in this case)

## Implementation Note
When implementing this naming convention in scripts, consider using built-in date formatting commands:
```bash
# Bash example
timestamp=$(date '+%Y%m%d-%H%M')
filename="${scriptName}-${timestamp}-${iter}.json"
```