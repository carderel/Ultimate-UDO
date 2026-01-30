# Adapter: execution

## Purpose
Tools that run code, scripts, or commands.

## Standard Operations

| Operation | Description | Returns |
|-----------|-------------|---------|
| `run(code, language)` | Execute code | Output/result |
| `run_file(path)` | Execute script file | Output/result |
| `list_languages()` | Show available runtimes | Language list |
| `install(package)` | Install dependency | Success/failure |

## Common Implementations
- Python interpreter
- Node.js / JavaScript
- Bash / Shell
- SQL execution
- Jupyter notebooks
- Sandboxed environments

## When to Use
- Data processing
- Calculations
- File transformations
- Automation tasks
- Testing code
- Generating outputs

## Expected Response Format
```
execution:
  language: "python"
  status: "success" | "error"
  output: "..."
  errors: "..." # if any
  runtime: "1.23s"
```

## Fallback Behavior
If execution tool unavailable:
1. Provide code for user to run manually
2. Explain expected output
3. Suggest alternative approaches

## Safety Requirements
- **NEVER** execute destructive commands without confirmation
- **AVOID** commands that modify system state
- **SANDBOX** when possible
- **LOG** all executions
- **REVIEW** code before running in production contexts

## Dangerous Operations (Require Explicit Approval)
- File deletion
- System modifications
- Network requests to unknown endpoints
- Database writes
- Credential access
