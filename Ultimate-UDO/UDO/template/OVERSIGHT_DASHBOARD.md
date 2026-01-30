# Oversight Dashboard

Human oversight interface for UDO projects.

---

## Quick Status

Ask: `Status` or `What's the status?`

The AI will report:
- Current goal and phase
- Active todos and blockers
- Recent completions
- Compliance status

---

## Oversight Commands

| Command | What It Does |
|---------|--------------|
| `Status` | Full oversight report |
| `Show blockers` | List all blockers |
| `Show todos` | List pending work |
| `Show completed` | List finished items |
| `Compliance check` | Verify logging/checkpoints/memory |

---

## Intervention Commands

| Command | When to Use |
|---------|-------------|
| `Pause all work` | Stop immediately |
| `Checkpoint this` | Force a save point |
| `Rollback to [name]` | Restore previous state |
| `Circuit breaker` | Trigger manual halt |

---

## Circuit Breaker Conditions

The AI will auto-halt if:

| Condition | Response |
|-----------|----------|
| Same task fails 3x | Escalate to human |
| 5+ todos without checkpoint | Force checkpoint |
| 5+ todos without session log | Force backfill |
| Context > 80% | Force archive |
| Error rate > 30% | Pause for audit |
