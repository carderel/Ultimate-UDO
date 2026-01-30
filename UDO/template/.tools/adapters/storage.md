# Adapter: storage

## Purpose
Tools that store, retrieve, and manage files and documents.

## Standard Operations

| Operation | Description | Returns |
|-----------|-------------|---------|
| `read(path)` | Retrieve file contents | File content |
| `write(path, content)` | Save content to file | Success/failure |
| `list(path)` | List files in location | File list |
| `delete(path)` | Remove file | Success/failure |
| `exists(path)` | Check if file exists | Boolean |
| `search(query)` | Find files by name/content | Matching files |

## Common Implementations
- Local file system
- Google Drive
- Dropbox
- S3 / Cloud storage
- SharePoint

## When to Use
- Reading project files
- Saving outputs
- Managing documents
- File organization

## Expected Response Format
```
file:
  path: "/path/to/file"
  name: "filename.ext"
  size: 1234
  modified: "2025-01-15T10:00:00Z"
  content: "..." # if requested
```

## Fallback Behavior
If no storage tool available:
1. Output content directly to user
2. Suggest manual file creation
3. Keep content in conversation for copy/paste

## Permissions
Always check:
- Read permission before reading
- Write permission before writing
- Don't assume access exists
