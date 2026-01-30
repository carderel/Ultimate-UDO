# Project Catalog

Central repository for project history and artifacts.

---

## Structure

### sessions/
**Session logs** - Record of each work session.
- Use template: .templates/session.md
- MANDATORY: Every session must create a log
- Named: YYYY-MM-DD-HH-MM-session.md

### decisions/
**Decision records** - Major choices and rationale.
- Architecture decisions
- Approach changes
- Trade-off evaluations
- Named: YYYY-MM-DD-[topic]-decision.md

### agents/
**Agent activity logs** - What agents did.
- Agent creation records
- Agent task logs
- Performance notes

### errors/
**Error logs** - Problems encountered.
- Use template: .templates/error.md
- Include root cause analysis
- Track resolution

### handoffs/
**Handoff packets** - Session and mode transitions.
- RC→Persona handoffs
- Session-to-session handoffs
- Use templates in .templates/

### archive/
**Archived items** - Completed or retired content.
- Use template: .templates/archive-summary.md
- Preserves context for future reference
- Reduces active clutter

---

## Maintenance

- Review sessions/ weekly for cleanup
- Archive completed phases
- Purge old errors after resolution confirmed
- Keep decisions/ indefinitely

---

## Search Tips

- Sessions are date-ordered
- Use tags in session logs for filtering
- Decision records explain "why"
- Error logs show "what went wrong"
