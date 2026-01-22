---
name: analyze_project-context
description: Examine any software project and create comprehensive context documentation.
argument-hint: The path to the project directory
tools: [ 'read', 'search' ]
---

Analyze the software project at the specified path and create a comprehensive project context summary.

## Task Overview

Examine the structure and contents of a software project (Terraform module, Node.js application, Kotlin library, etc.). Extract key information and generate a detailed markdown documentation file that serves as project context for understanding the project's purpose, architecture, and usage.

## Steps to Follow

1. **Explore Project Structure**: List and understand the directory hierarchy and identify key files

2. **Read Core Documentation**:
   - `README.md` or `README.adoc` - Purpose, overview, and usage
   - `CONTRIBUTING.md` or `DEVELOPMENT.md` - Development guidelines and processes
   - `CHANGELOG.md` or `HISTORY.md` - Version history and changes

3. **Analyze Project Configuration** (identify and read relevant files):
   - **For Terraform**: `main.tf`, `variables.tf`, `outputs.tf`, `versions.tf`
   - **For Node.js**: `package.json`, `tsconfig.json`, `src/index.js/ts`
   - **For Kotlin**: `build.gradle.kts`, `pom.xml`, `src/main/kotlin`
   - **For Python**: `setup.py`, `requirements.txt`, `pyproject.toml`
   - **For General**: Configuration files, dependency manifests, main source entry points

4. **Review Examples and Tests** (if available):
   - `examples/`, `test/`, `tests/`, `spec/` directories
   - Sample configurations or usage patterns
   - Testing frameworks and approach

5. **Extract Key Information**:
   - Project purpose and primary functionality
   - Core features and capabilities
   - Technology stack and dependencies
   - Input/configuration parameters and their types
   - Output values, exports, or deliverables
   - Dependencies on other projects or services
   - Multi-environment or multi-target support
   - Testing and quality assurance approach
   - Version history and release process
   - Naming conventions used
   - Build/deployment requirements

6. **Create Comprehensive Documentation** in a `PROJECT_CONTEXT.md` file containing:
   - Executive summary (project type, purpose, technology stack)
   - Core functionality and key features
   - Architecture and dependencies
   - Configuration/input parameters documentation
   - Project directory structure with descriptions
   - Build, test, and deployment instructions
   - Version history in tabular format
   - Available APIs, resources, or exports
   - Contributing guidelines
   - Integration points and related projects
   - Technology and runtime requirements

## Output Format

Generate a well-structured markdown file that includes:
- Clear hierarchical sections with proper heading levels
- Tables for data summary (dependencies, versions, features)
- Code blocks for configuration examples
- Bullet points and lists for features and requirements
- File paths and descriptions for the project structure

## Documentation Should Answer

- What is this project and what does it do?
- What are its core responsibilities and features?
- How is it configured or used?
- What inputs/parameters does it accept?
- What does it produce or export?
- How is it tested and validated?
- How does it integrate with other systems?
- What are the constraints and requirements?
- How is it versioned and released?
- What technology stack does it use?
