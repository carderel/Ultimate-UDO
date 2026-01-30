# Adapter: search

## Purpose
Tools that find and retrieve information from various sources.

## Standard Operations

| Operation | Description | Returns |
|-----------|-------------|---------|
| `search(query)` | Find information matching query | Results list |
| `search(query, filters)` | Filtered search | Filtered results |

## Common Implementations
- Web search (Google, Bing, DuckDuckGo)
- Internal document search
- Code search
- Knowledge base search

## When to Use
- Finding external information
- Research tasks
- Fact verification
- Discovering resources

## Expected Response Format
```
results:
  - title: "Result title"
    snippet: "Preview text..."
    source: "URL or reference"
    relevance: high/medium/low
```

## Fallback Behavior
If no search tool available:
1. Inform user search is unavailable
2. Suggest manual search
3. Work with information already in context

## Quality Indicators
- Number of relevant results
- Source reliability
- Result freshness
