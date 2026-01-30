# Data Validation Rules

Standards for validating data in this project.

---

## General Principles

1. **Never trust input** - Validate everything from external sources
2. **Fail early** - Catch invalid data as soon as possible
3. **Be specific** - Provide clear error messages
4. **Document expectations** - Make validation rules explicit

---

## Input Validation

### Required Fields
- Check for presence
- Check for non-empty (not just whitespace)
- Provide clear error: "[Field] is required"

### Data Types
- Verify expected type (string, number, date, etc.)
- Handle type coercion explicitly
- Reject invalid types with clear message

### Formats
- Validate format patterns (email, phone, URL, etc.)
- Use standard format validators when available
- Document expected formats

### Ranges
- Check numeric ranges (min/max)
- Check string lengths
- Check date ranges
- Validate against allowed values (enums)

---

## Data Quality

### Consistency
- Cross-field validation (if A then B required)
- Referential integrity
- Business rule compliance

### Completeness
- Required relationships present
- No orphaned records
- All expected fields populated

### Accuracy
- Reasonable values (no impossible dates, etc.)
- Format correctness
- Logical consistency

---

## API Data

- Validate response structure
- Check for required fields
- Handle missing/null values
- Verify data types match expectations
- Log unexpected formats

---

## File Data

- Validate file type/extension
- Check file size limits
- Verify file structure (CSV columns, JSON schema, etc.)
- Handle encoding issues
- Sanitize filenames

---

## Database

- Use constraints at database level
- Validate before insert/update
- Handle constraint violations gracefully
- Log validation failures

---

## Error Handling

### Error Messages Should:
- Identify which field failed
- Explain why it failed
- Suggest how to fix (when possible)
- Not expose sensitive information

### Logging
- Log validation failures
- Include context (what was being validated)
- Track patterns of invalid data

---

## Customization

Add project-specific validation rules below:

### [Specific Data Type]
[Add validation rules here]
