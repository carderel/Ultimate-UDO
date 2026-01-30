# Adapter: communication

## Purpose
Tools that send messages, notifications, and communications.

## Standard Operations

| Operation | Description | Returns |
|-----------|-------------|---------|
| `send(recipient, message)` | Send a message | Confirmation |
| `send(channel, message)` | Post to channel | Confirmation |
| `list_channels()` | Show available channels | Channel list |
| `list_contacts()` | Show available contacts | Contact list |

## Common Implementations
- Slack
- Microsoft Teams
- Email (SMTP, Gmail, etc.)
- SMS/Text
- Discord
- Webhooks

## When to Use
- Notifying team members
- Sending reports
- Alerting on events
- Sharing updates
- Requesting input

## Expected Response Format
```
message:
  status: "sent"
  recipient: "#channel or email"
  timestamp: "2025-01-15T10:00:00Z"
  message_id: "abc123"
```

## Fallback Behavior
If communication tool unavailable:
1. Inform user message could not be sent
2. Provide message content for manual sending
3. Suggest alternative communication method

## Safety Requirements
- **NEVER** send without explicit user approval
- **ALWAYS** show message content before sending
- **CONFIRM** recipient is correct
- **LOG** all sent communications

## Draft vs Send
- Default to drafting messages
- Only send when user explicitly confirms
- "Draft message to..." vs "Send message to..."
