Tools Registry

Central index of all tools and integrations available to this project.
This file defines WHAT tools exist and their readiness. It does not grant permission to use them.
Permission and behavior are governed by ORCHESTRATOR.md, HARD_STOPS.md, and REASONING_CONTRACT.md.

STATUS KEY

Status meanings are operational, not descriptive.

Active        - Configured, tested, approved for use
Available     - Exists but not yet verified in this project
Inactive      - Explicitly disabled or not permitted
Needs Setup   - Required by project but not yet usable

REGISTERED TOOLS

This table is the single source of truth for tool availability.

Tool | Adapter | Status | Last Verified | Notes
---- | ------- | ------ | ------------- | -----
<!-- Add tools here --> | | | |

Example entries (do not assume availability):
web-search | search | Active | 2025-01-15 | Via Claude
google-drive | storage | Active | 2025-01-15 | OAuth configured
google-ads | data | Active | 2025-01-10 | API v14
slack | communication | Available | - | Not tested
database | data | Inactive | - | Not needed

ADAPTER SUMMARY

Adapters describe capability class, not implementation details.

Adapter | Purpose | Active Tools
search | Find information | [count]
storage | Store and retrieve files | [count]
data | Query structured data | [count]
communication | Send messages | [count]
execution | Run code | [count]

Adapter behavior definitions live in:
.tools/adapters/

HEALTH OVERVIEW

Last health check: Never

Tools needing attention:
- Any tool with Status = Available
- Any tool with Status = Needs Setup
- Any tool not verified in the last 30 days
- Any tool with known deprecation risk

Run `Check tool health` to update verification dates.
Health checks must not modify tools, credentials, or project state.

ADDING A NEW TOOL

All steps are mandatory. Do not skip.

1. Identify adapter type (search, storage, data, communication, execution)
2. Create config file: .tools/installed/[tool-name].md
3. Use template: .tools/templates/tool-config.md
4. Add entry to this registry with Status = Available
5. Test tool behavior in a non-destructive way
6. Update Status to Active only after verification
7. Record verification date

REMOVING OR DISABLING A TOOL

1. Update Status to Inactive in this registry
2. Record reason in Notes
3. Remove or revoke credentials if applicable
4. Move config to .tools/archived/ if historical reference is needed

Never delete evidence of prior tool usage without user approval.

TOOL USAGE RULES

- Tools not listed here are considered unavailable
- Tools marked Available or Needs Setup must not be used
- Tools marked Inactive must never be used
- Active tools must still respect HARD_STOPS and REASONING_CONTRACT
- Tool failure must be logged and surfaced, not silently retried

COMMANDS

List tools          - Display this registry
Tool status         - Summary of Active vs non-Active tools
Verify [tool]       - Check configuration and readiness for a single tool
Check tool health   - Verify all Active tools
Add tool [name]     - Guided tool registration flow

OPTIONAL EXTENSIONS

These are architectural enhancements, not defaults.

Watchlist
Track mission-critical tools that require proactive monitoring.
File: .tools/watchlist.md

Health Monitoring
Scheduled verification for Active tools.
Recommended for long-running or production-like projects.

Update Notifications
Track breaking changes or deprecations for critical APIs.

Credential Rotation
Defined protocol for rotating credentials.
Must comply with HARD_STOPS.md.

Fallback Chains
Define secondary tools when primary tools fail.
Fallbacks must also be registered and verified.

These extensions are optional and must be explicitly enabled by the user.