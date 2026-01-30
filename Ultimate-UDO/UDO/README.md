UDO - Universal Dynamic Orchestrator

Version 4.x

A file based system for AI project management with context continuity across sessions.

Works with any LLM. Claude, GPT, Gemini, or others can be swapped mid project without losing state, rules, or history.

--------------------------------
INSTALLATION
--------------------------------

Option 1: One line install (recommended)

Navigate to your project folder first, then run:

Mac Linux WSL Git Bash
curl -fsSL https://raw.githubusercontent.com/carderel/UDO-universal-orchestrator-v4b/main/install.sh | bash

Windows PowerShell
irm https://raw.githubusercontent.com/carderel/UDO-universal-orchestrator-v4b/main/install.ps1 | iex

Option 2: Manual setup

1. Download or clone this repository
2. Copy the contents of the template folder to your project directory
3. Configure your AI as described below

--------------------------------
QUICK START
--------------------------------

Step 1. Install UDO using one of the methods above

Step 2. Configure your AI

Add the following instruction to your AI system prompt or custom instructions:

Before responding to any request, read START_HERE.md and follow its instructions exactly.

Step 3. Begin work

The AI must:
- Read START_HERE.md
- Read ORCHESTRATOR.md in full
- Adopt UDO protocol before performing any task

--------------------------------
WHAT UDO DOES
--------------------------------

UDO provides enforced structure for long running AI assisted projects.

Core capabilities:

- Session continuity
  Every session is logged so work can resume without loss of context

- Checkpoints
  Automatic save points after every 3 completed todos and at phase boundaries

- Memory system
  Facts and discoveries are stored explicitly as canonical, working, or disposable

- Agent management
  Specialized agents are created when work requires 2 or more distinct personas or competencies

- Decision logging
  Major architectural or strategic decisions are recorded with rationale

- Compliance tracking
  Built in checks surface protocol violations instead of silently ignoring them

--------------------------------
KEY COMMANDS
--------------------------------

Resume or r
Start a session with an oversight report

Deep resume or dr
Load full context including recent sessions

Handoff or h
End session with mandatory logging and checkpoint

Quick handoff or qh
Minimal session log and state update

Status or s
Report current goal, phase, todos, blockers, and compliance gaps

Checkpoint this or cp
Force an immediate checkpoint

Backfill sessions or bf
Reconstruct missing session logs

Compliance check or cc
Report compliance gaps only. Does not auto fix.

--------------------------------
PROJECT STRUCTURE
--------------------------------

your-project/
START_HERE.md            Entry point. Always read first
ORCHESTRATOR.md          Core operating rules
COMMANDS.md              Command reference
HARD_STOPS.md            Absolute prohibitions
LESSONS_LEARNED.md       Situational corrections
PROJECT_STATE.json       Current status and todos
PROJECT_META.json        Project metadata
CAPABILITIES.json        AI environment capabilities
.agents/                 Specialist agent definitions
.checkpoints/            Saved snapshots
.memory/                 Canonical working and disposable facts
.outputs/                Final deliverables
.project-catalog/        Session logs and decisions
.rules/                  Quality and process standards
.templates/              File templates

--------------------------------
PROTOCOL ENFORCEMENT
--------------------------------

UDO halts work when these conditions occur:

- 5 or more todos completed without a session log
- 5 or more todos completed without a checkpoint
- Task requires 2 or more personas and no agents exist
- Same task fails 3 times
- Context usage exceeds 80 percent

Halting is intentional. It forces correction before damage accumulates.

--------------------------------
REPOSITORY STRUCTURE
--------------------------------

UDO-universal-orchestrator-v4b/
install.sh        Bash installer
install.ps1       PowerShell installer
README.md         This file
LICENSE
template/         Files copied into your project

--------------------------------
LICENSE
--------------------------------

MIT License
Use freely. Modify as needed.

--------------------------------
NOTES ON SCOPE
--------------------------------

This file describes WHAT UDO is and HOW to start.
It does not define how to think, how to analyze, or how to write.

Those responsibilities are defined in:
- ORCHESTRATOR.md
- REASONING_CONTRACT.md
- HARD_STOPS.md

END OF FILE