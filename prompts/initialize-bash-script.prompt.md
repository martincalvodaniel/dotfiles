---
name: initialize-bash-script
description: Initialize a bash script with command line argument parsing, token validation, and environment configuration
argument-hint: Bearer token (required) and environment selection (dev, pre, pro)
---

# Bash Script Initialization

Create a bash script with proper command line argument parsing, validation, and error handling.

## Gather Script Arguments

Ask the user to define all command line arguments for the script. For each argument, gather:

1. **Argument Details**
   - Short flag (e.g., `-t`)
   - Long flag (e.g., `--token`)
   - Description/Purpose
   - Mandatory or Optional
   - Default value (if optional)
   - Possible values/validation rules (if applicable)

2. **Always Include**
   - `-h, --help` flag (always available to display usage information)

3. **Present Options**
   - Show the user a summary of all configured arguments
   - Allow them to add, modify, or remove arguments
   - Confirm the final argument list before code generation

## Generate Script

Once arguments are defined, create a bash script that includes:

1. **Argument Parsing**
   - Implement getopts or getopt for parsing command line arguments
   - Handle all user-defined arguments with their specified flags
   - Support both short and long flag variations

2. **Validation**
   - Validate mandatory arguments are provided
   - Validate optional arguments against their allowed values
   - Display clear error messages for validation failures
   - Exit with appropriate status codes

## Implementation Requirements

1. **Parameter Validation**
   - Validate that required token parameter is provided
   - Validate environment value against allowed options
   - Display clear error messages for validation failures

2. **Best Practices**
   - Follow standard bash script conventions
   - Implement proper exit codes (0 for success, non-zero for errors)
   - Use clear and descriptive variable names
   - Include proper error handling for all operations

3. **Documentation**
   - Include usage examples in help output
   - Document all parameters and their purpose
   - Provide clear, descriptive error messages