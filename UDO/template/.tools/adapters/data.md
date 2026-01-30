# Adapter: data

## Purpose
Tools that query, retrieve, and analyze structured information from data sources.

## Standard Operations

| Operation | Description | Returns |
|-----------|-------------|---------|
| `query(source, params)` | Retrieve data matching criteria | Data results |
| `list_sources()` | Show available data sources | Source list |
| `describe(source)` | Get schema/field definitions | Schema info |
| `aggregate(source, metrics, dimensions)` | Summarize data | Aggregated results |

## Common Implementations
- Google Ads API
- Google Analytics
- Search Console
- Databases (SQL, NoSQL)
- CRM systems
- Custom APIs
- Spreadsheets

## When to Use
- Pulling performance metrics
- Analyzing trends
- Retrieving records
- Generating reports
- Data-driven decisions

## Expected Response Format
```
data:
  source: "google-ads"
  query: "campaign performance last 30 days"
  rows: 
    - campaign: "Brand"
      clicks: 1234
      cost: 567.89
  metadata:
    row_count: 50
    date_range: "2025-01-01 to 2025-01-30"
```

## Fallback Behavior
If data tool unavailable:
1. Inform user which data source is inaccessible
2. Suggest manual export if possible
3. Work with cached/provided data if available
4. Note data gap in analysis

## Constraints to Document
- Rate limits
- Date range limitations
- Required permissions/scopes
- Data freshness (real-time vs delayed)
