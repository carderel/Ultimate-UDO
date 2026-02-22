# Evidence Protocol

## Purpose

When AI generates deliverables with claims, the human receiving them didn't walk the research path. They see conclusions but can't defend them under scrutiny because they don't know the underlying data.

This protocol ensures every claim is traceable to source evidence, closing the gap between "AI said it" and "I can defend it."

---

## When This Protocol Applies

**Required for:**
- Client-facing deliverables
- Audits and analyses
- Strategic recommendations
- Reports with data-driven claims
- Any document that may be challenged or questioned

**Not required for:**
- Internal working documents
- Code files (unless documenting architectural decisions)
- Session logs
- Draft explorations

---

## Requirements

### 1. Evidence Folder Creation

For every deliverable requiring evidence, create:

```
.outputs/.evidence/{deliverable-name}/
├── EVIDENCE_PACKET.md
├── TEACH_BACK.md
└── raw/
    └── {source files, screenshots, exports}
```

### 2. Claim-to-Source Mapping

Every claim in the deliverable MUST have a corresponding entry in EVIDENCE_PACKET.md containing:

| Field | Required | Description |
|-------|----------|-------------|
| Claim statement | Yes | Exact claim as it appears in deliverable |
| Confidence level | Yes | HIGH / MEDIUM / LOW |
| Source | Yes | File, URL, API, interview, document |
| Location | Yes | Line number, timestamp, section, page |
| Raw data | Yes | Exact quote, data snippet, or reference to `raw/` folder |
| Reasoning | Yes | Why this data supports the claim |
| Counterarguments | Yes | What could challenge this claim |

### 3. Raw Evidence Preservation

- Store source material in `.evidence/{deliverable-name}/raw/`
- Include: screenshots, data exports, API responses, document excerpts
- Reference these files in EVIDENCE_PACKET.md

### 4. Confidence Levels

Assign honestly:

| Level | Criteria |
|-------|----------|
| **HIGH** | Multiple corroborating sources, direct data, low ambiguity |
| **MEDIUM** | Single reliable source, or inference with strong support |
| **LOW** | Limited data, assumption-based, requires further validation |

### 5. Gap Acknowledgment

Document in EVIDENCE_PACKET.md:
- Data that was unavailable
- Assumptions made
- Areas needing further investigation

---

## Workflow Integration

1. **During analysis:** Collect evidence as you go, don't backfill
2. **Before deliverable completion:** Create evidence folder and packet
3. **Before handoff:** Verify all claims have evidence entries
4. **Checkpoint requirement:** Evidence packet is part of deliverable completion

---

## Verification Checklist

Before marking a deliverable complete:

- [ ] Evidence folder exists at `.outputs/.evidence/{deliverable-name}/`
- [ ] EVIDENCE_PACKET.md contains entry for every claim
- [ ] All claims have source citations
- [ ] Raw data preserved in `raw/` folder
- [ ] Confidence levels assigned
- [ ] Counterarguments identified for each claim
- [ ] Gaps and limitations documented

---

## Template

Use `.templates/evidence-packet.md` for structure.

---

## Failure Mode

If evidence cannot be gathered for a claim:
1. Do NOT include the claim in the deliverable
2. OR explicitly mark it as "Unverified" with explanation
3. Document the gap in EVIDENCE_PACKET.md

**Never present unsupported claims as conclusions.**
