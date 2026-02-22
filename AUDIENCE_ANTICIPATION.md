# Audience Anticipation Protocol

A review process that surfaces the questions, objections, and concerns your audience will have before they have them. This runs after Devil's Advocate and focuses on **reception**, not just **accuracy**.

**Devil's Advocate asks:** "Is this sound?"
**Audience Anticipation asks:** "Will this satisfy them?"

---

## When to Run

**After Devil's Advocate, before final delivery.**

The prompt:

```
Audience Anticipation: How should we review?

1) Standard only - Generic stakeholder questions
2) Standard + Specific - Define key audience(s) for targeted questions  
3) Skip - User accepts risk
```

**Option 2 always includes Option 1.** Specific audiences are additive, not replacement.

---

## Tier 1: Standard Anticipation

These questions cover common stakeholder concerns across most business contexts. Run this unless explicitly skipped.

### Strategic Questions
- What's the expected ROI / payoff?
- What's the timeline?
- Why now? Why not wait?
- What happens if we do nothing?
- How does this align with current priorities?

### Financial Questions
- What does this cost?
- What's the budget impact?
- Are there hidden costs?
- What's the payback period?
- How does this compare to alternatives cost-wise?

### Risk Questions
- What could go wrong?
- What's the worst-case scenario?
- What's the mitigation plan?
- What are we betting on?
- What's the reversibility if it fails?

### Implementation Questions
- Who owns this?
- What resources are required?
- What's the disruption during transition?
- What dependencies exist?
- What's the realistic timeline (not optimistic)?

### Evidence Questions
- How do we know this will work?
- Where has this worked before?
- What's the source of these numbers?
- Is this proven or theoretical?
- What don't we know yet?

### Political Questions
- Who wins and loses from this?
- Who needs to approve?
- Who might block this and why?
- What's the change management challenge?
- How will this be perceived?

---

## Tier 2: Specific Audience Anticipation

When the user chooses to define specific audiences, gather this profile:

### Audience Profile Template

```markdown
## Audience: [Name/Role]

**Role/Title:** [Their position]
**Decision Power:** [Approver / Influencer / Reviewer / Implementer]
**Primary Concerns:** [What keeps them up at night]
**Success Metrics:** [How they're measured/rewarded]
**Typical Objections:** [What they usually push back on]
**Pet Peeves:** [What annoys them or triggers skepticism]
**History/Context:** [Relevant past experiences - burned before? championed similar?]
**Communication Preference:** [Data-driven? Story-driven? Bottom-line-first?]
**Key Question They Always Ask:** [Their signature question]
```

### Generating Niche Questions

Once the profile is defined, generate questions **as that person would ask them**, considering:

1. **Their priorities** - Questions about what they care about
2. **Their fears** - Questions about what could hurt them
3. **Their blind spots** - Questions others forget they'll ask
4. **Their history** - Questions based on past experiences
5. **Their metrics** - Questions about how this affects their scorecard

### Example Niche Profiles

#### CFO Profile
```markdown
## Audience: CFO

**Role/Title:** Chief Financial Officer
**Decision Power:** Approver (budget authority)
**Primary Concerns:** Cash flow, ROI, financial risk, audit compliance
**Success Metrics:** Cost control, margin improvement, accurate forecasting
**Typical Objections:** "The numbers don't add up" / "What's the real cost?"
**Pet Peeves:** Vague financials, optimistic projections without basis
**History/Context:** [User fills in]
**Communication Preference:** Bottom-line first, data-driven, show the math
**Key Question They Always Ask:** "What's the payback period?"
```

**Generated CFO Questions:**
- Walk me through the financial model assumptions
- What's not included in this cost estimate?
- How sensitive is the ROI to timeline slippage?
- What's the impact on this quarter's numbers?
- Have you stress-tested these projections?

#### Legal/Compliance Profile
```markdown
## Audience: General Counsel

**Role/Title:** General Counsel / Legal
**Decision Power:** Blocker (can veto on compliance grounds)
**Primary Concerns:** Liability, regulatory compliance, contract risk
**Success Metrics:** Zero regulatory issues, contract clarity
**Typical Objections:** "This exposes us to..." / "We need to run this by..."
**Pet Peeves:** Surprises, commitments made without legal review
**History/Context:** [User fills in]
**Communication Preference:** Precise language, documented risks
**Key Question They Always Ask:** "What's our exposure?"
```

**Generated Legal Questions:**
- What regulatory requirements apply here?
- Who's liable if this fails?
- What contractual commitments does this create?
- Has this been reviewed for [relevant compliance area]?
- What's the IP situation?

---

## Multiple Audiences

Users can define multiple specific audiences. Each gets their own section:

```
Standard Anticipation: [Questions]

Audience 1 - CFO: [Questions from CFO perspective]
Audience 2 - Legal: [Questions from Legal perspective]  
Audience 3 - Operations: [Questions from Ops perspective]
```

**Recommended limit:** 3-4 specific audiences. More becomes unwieldy.

---

## Output Format

```markdown
# Audience Anticipation Review

**Document:** [What was reviewed]
**Date:** [YYYY-MM-DD]

---

## Standard Stakeholder Questions

These questions may come from various readers:

### Strategic
- [Question 1]
- [Question 2]

### Financial
- [Question 1]
- [Question 2]

### Risk
- [Question 1]
- [Question 2]

### Implementation
- [Question 1]
- [Question 2]

### Evidence
- [Question 1]
- [Question 2]

[Include only categories relevant to the document]

---

## Specific Audience: [Role Name]

**Profile Summary:** [One line]
**Their Core Question:** [What they most want answered]

### Anticipated Questions from [Role]
1. [Question in their voice]
2. [Question in their voice]
3. [Question in their voice]

### Likely Objections
- [Objection they might raise]
- [Objection they might raise]

### What Would Satisfy Them
- [What they need to see to approve/accept]

[Repeat for each specific audience]

---

## Gap Analysis

Questions the document **does not currently answer**:

| Question | Source | Severity | Recommendation |
|----------|--------|----------|----------------|
| [Question] | [Standard/Specific audience] | [High/Med/Low] | [Add content / Acknowledge gap / Out of scope] |

---

## Recommendations

1. [Specific recommendation to address gaps]
2. [Specific recommendation to address gaps]

Or: "Document adequately addresses anticipated questions."
```

---

## Integration with UDO Flow

```
RC Mode (Analysis)
       ↓
Handoff Packet
       ↓
Persona Mode (Writing)
       ↓
Draft Output
       ↓
Devil's Advocate Review    ← "Is this sound?"
       ↓
Audience Anticipation      ← "Will this satisfy them?"
       ↓
[Output + DA Report + AA Report] → User
       ↓
User Decision
```

---

## Commands

| Command | What It Does |
|---------|--------------|
| `Audience check` | Run standard anticipation |
| `AA review` | Same as above |
| `Who will ask what?` | Same as above |
| `Define audience` | Add specific audience profile |
| `Add audience: [role]` | Quick add specific audience |
| `Full review` | DA + Standard AA + any defined audiences |

---

## Quick Audience Anticipation

For lower-stakes outputs:

```markdown
## Quick Audience Anticipation

**Top 3 questions they'll ask:**
1. [Question]
2. [Question]
3. [Question]

**Most likely objection:** [One sentence]

**What's missing that they'll want:** [One sentence]
```

---

## Saving Audience Profiles

Frequently-used audience profiles can be saved to:

`.memory/canonical/audience-profiles.md`

This allows reuse across sessions:

```markdown
# Saved Audience Profiles

## Profile: CFO-Generic
[Full profile template]

## Profile: Legal-Generic  
[Full profile template]

## Profile: [Client Name]-CEO
[Customized profile for specific client]
```

Invoke saved profiles with: `Add audience: [profile name]`

---

## Remember

- Standard runs unless skipped (covers broad audience)
- Specific audiences are **additive** (enhance, don't replace standard)
- The goal is **anticipation**, not **perfection** - you can't predict everything
- User context matters - they may know things that resolve anticipated questions
- Some gaps are acceptable - not every question needs answering in the document
