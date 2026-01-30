# Tool: [tool-name]

## Overview

**Adapter:** [search | storage | data | communication | execution]
**Status:** [✅ Active | ⚠️ Available | ❌ Inactive | 🔧 Needs Setup]
**Description:** [One-line description of what this tool does]

---

## Version Info

```yaml
version_info:
  tool_version: "1.0"              # Version of this config
  api_version: ""                   # External API version (if applicable)
  last_verified: "YYYY-MM-DD"       # Last confirmed working
  check_frequency: "monthly"        # How often to verify
  changelog_url: ""                 # Where to check for updates
```

---

## Capabilities

What this tool can do:

- [ ] [Capability 1]
- [ ] [Capability 2]
- [ ] [Capability 3]

## Available Sources / Endpoints

| Source | Description | Example Use |
|--------|-------------|-------------|
| [source1] | [what it provides] | [when to use] |

---

## Authentication

**Type:** [none | api_key | oauth | service_account]
**Credential Reference:** [Environment variable name or description]
**Scopes Required:** [List required permissions]

**Setup Instructions:**
1. [Step 1]
2. [Step 2]
3. [Step 3]

---

## Usage

### Basic Example
```
[Show how to invoke this tool]
```

### Common Operations

**[Operation 1]:**
```
[Example]
```

**[Operation 2]:**
```
[Example]
```

---

## Constraints

| Constraint | Value | Notes |
|------------|-------|-------|
| Rate limit | [e.g., 1000/day] | [what happens when exceeded] |
| Data range | [e.g., 90 days] | [limitations on historical data] |
| Max results | [e.g., 10000 rows] | [pagination if exceeded] |

---

## Error Handling

| Error | Likely Cause | Resolution |
|-------|--------------|------------|
| Auth failed | Token expired | [How to refresh] |
| Rate limited | Too many requests | [Backoff strategy] |
| Not found | Invalid source/ID | [How to validate] |

---

## Fallback

If this tool is unavailable:
1. [Alternative approach 1]
2. [Alternative approach 2]
3. [Manual workaround]

---

## Dependencies

- [Other tools or services this requires]
- [Required packages or libraries]

---

## Notes

[Any additional context, gotchas, or tips]

---

## Changelog

| Date | Change | By |
|------|--------|-----|
| YYYY-MM-DD | Initial setup | [who] |
