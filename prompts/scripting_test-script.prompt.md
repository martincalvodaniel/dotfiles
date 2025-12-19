---
name: scripting_test-script
description: Test all methods shown in script help documentation by executing provided examples
argument-hint: Path to the bash script to test. Optional: specific method name to test in isolation
tools: [ 'read', 'search', 'execute' ]
---

Validate that all methods/options shown in a script's help documentation work correctly by executing the examples provided.

## Task Steps

1. **Extract Help Documentation**
   - Run the script with `-h` or `--help` flag to display available methods and usage examples
   - Identify all OPTIONS listed and their corresponding EXAMPLES section

2. **Parse Examples Section**
   - Extract each example command from the EXAMPLES section
   - Normalize command syntax (remove comments, replace placeholder values with realistic test data if needed)
   - Group examples by method/feature for organized testing

3. **Validate Prerequisites**
   - Check that any required files, directories, or dependencies exist
   - Verify environment setup (workspace paths, configurations, databases, etc.)
   - Ensure script is executable and all dependencies (jq, git, etc.) are available

4. **Execute Each Example**
   - Run each extracted example command sequentially
   - Capture both stdout and stderr output
   - Record the exit code for each execution
   - Note any warnings or errors that occur

5. **Verify Expected Behavior**
   - Confirm that successful examples return exit code 0
   - Validate that output matches documented behavior
   - Check that data integrity is maintained (files unchanged if not expected to modify, databases consistent if modifications occurred)
   - Verify that options work in combination (e.g., `-s --verbose` together)

6. **Test Error Cases**
   - Try examples with invalid arguments (missing required parameters, wrong project names, etc.)
   - Verify that error messages are clear and helpful
   - Confirm error exit codes are non-zero

7. **Report Results**
   - Create a test summary showing:
     - Total examples found
     - Number executed successfully
     - Any failures with details
     - Any edge cases or unexpected behaviors discovered
   - Document which examples could not be tested due to environment limitations

## Success Criteria

✓ All examples from help documentation execute without errors  
✓ Commands produce output consistent with documented behavior  
✓ No data corruption or partial updates occur  
✓ Error handling works correctly for invalid inputs  
✓ Script state is clean after all tests (databases intact, files as expected)

## Example Command

```bash
# Test the sync-workspace script
./sync-workspace -h                    # View help
./sync-workspace --skip-existing       # Test option
./sync-workspace -p devol              # Test project query
./sync-workspace -a test test-repo     # Test add (with confirmation)
```
