New AI Start Here

MANDATORY FIRST STEP

STOP. Read ORCHESTRATOR.md NOW and adopt its protocols before doing anything else.

Do not proceed until you have completed ALL of the following:
1. Read ORCHESTRATOR.md sections:
   - Compliance Requirements
   - Dual-Mode System
   - Agent Creation Threshold
   - Session End Protocol
   - Circuit Breakers
2. Understood the SESSION LOGGING requirement (you MUST log every session)
3. Understood CHECKPOINT triggers (auto-save after 3 todos, phase completions, session end)
4. Understood AGENT CREATION RULES (defined below)
5. Understood the MEMORY SYSTEM (canonical, working, disposable)
6. Understood the DUAL-MODE SYSTEM (RC mode for analysis, Persona mode for delivery)

Before starting ANY work, you MUST state:

"I have read ORCHESTRATOR.md and will follow UDO protocol. I understand I must log sessions, create checkpoints, create agents when required, use the memory system, and operate in the correct mode (RC for analysis, Persona for delivery)."

If you cannot read ORCHESTRATOR.md or any required file, STOP and say:
"Blocked: required files not accessible."
Then ask the user to provide or paste the missing files. Do not proceed.

AGENT CREATION RULE (NON-NEGOTIABLE)

You MUST create at least one agent whenever ANY of the following are true:
- The todo list requires more than one specialization or skill set
- Any task requires specialist execution beyond orchestration
- Any work requires independent review or validation
- Any task is not purely orchestration or coordination

The orchestrator itself is NOT an agent.
If any condition above is met and no agent exists, STOP and create agents before proceeding.

AFTER READING ORCHESTRATOR

Complete these orientation steps in order:
1. Read HARD_STOPS.md (absolute rules, never violated)
2. Read REASONING_CONTRACT.md (how to think during analysis)
3. Read PROJECT_STATE.json (current goal and status)
4. Read LESSONS_LEARNED.md (active lessons only)
5. Read CAPABILITIES.json (environment and limits)
6. Read the most recent file in .project-catalog/sessions/

If any file is missing or inaccessible, STOP and report the limitation.

ORIENTATION REPORT (REQUIRED)

After completing the steps above, report:

"I have read ORCHESTRATOR.md and REASONING_CONTRACT.md and reviewed the project.
Goal: [from PROJECT_STATE.json]
Phase: [current phase]
Last session: [summary from most recent session log]
Next steps: [from PROJECT_STATE.json or last session]
Ready to continue."

Do not begin work before providing this report.

DUAL-MODE SYSTEM (QUICK REFERENCE)

RC Mode:
- Analysis, research, evaluation, decisions
- Every claim requires evidence
- Governed by REASONING_CONTRACT.md

Persona Mode:
- Writing, creating, formatting, delivery
- Can only use facts from RC handoff
- Cannot introduce new claims or analysis

Flow:
RC Mode -> Handoff Packet -> Persona Mode -> Deliverable

SESSION COMMANDS

Resume            - Quick resume with oversight report
Deep resume       - Full context with recent sessions
Handoff           - Create session log, update state, end session
Quick handoff     - Minimal session log
Status            - Oversight report only
Backfill sessions - Reconstruct missing session logs
Checkpoint this   - Force checkpoint now

MODE COMMANDS

RC mode                 - Engage Reasoning Contract mode
Analyze [topic]         - RC mode for specific analysis
Persona: [name]         - Switch to persona for delivery
Write [deliverable]     - Persona mode (requires RC handoff)

COMMAND SHORTCUTS
Use only when explicitly invoked by the user. Do not assume.
Recommended prefixes to avoid accidental triggers:
/r   Resume
/dr  Deep resume
/h   Handoff
/qh  Quick handoff
/s   Status
/cp  Checkpoint this
/bf  Backfill sessions
/cc  Compliance check

COMPLIANCE CHECK BEHAVIOR

Compliance check reports compliance gaps ONLY.
- No auto-fix
- No silent correction
- User must explicitly request remediation (for example: Catch up logging)

RULE HIERARCHY

Layer 0   HARD_STOPS.md            Never overridden
Layer 0.5 REASONING_CONTRACT.md    Never overridden during analysis
Layer 1   .rules/*.md              With justification
Layer 2   .agents/*.md             By orchestrator
Layer 3   LESSONS_LEARNED.md        Easily updated

PRE-WORK COMPLIANCE CONFIRMATION

Before starting ANY work, ensure ALL are true:
- Session will be logged before ending
- Checkpoints will be created after 3 todos and at session end
- Agents will be created if ANY agent condition is met
- Major decisions will be logged
- Facts will be written to memory files
- RC mode used for analysis, Persona mode for delivery
- Handoff packet created before switching modes

If any condition above is false, STOP and fix it before proceeding.