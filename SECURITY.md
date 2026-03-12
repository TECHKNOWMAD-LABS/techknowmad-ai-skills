# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |

## Reporting a Vulnerability

If you discover a security vulnerability in TechKnowmad AI Skills, please report it responsibly.

**DO NOT** open a public GitHub issue for security vulnerabilities.

### How to Report

1. **Email**: Send details to `security@techknowmad.ai`
2. **Include**: Description of the vulnerability, steps to reproduce, potential impact, and suggested fix (if any)
3. **Response**: We will acknowledge receipt within 48 hours and provide a timeline for remediation

### Scope

This policy covers:

- SKILL.md files that could contain prompt injection vectors
- Install scripts that execute shell commands
- Any configuration that could lead to unauthorized access or data exposure

### Out of Scope

- Third-party community repos cloned by the install script (report to those repos directly)
- Claude Code CLI vulnerabilities (report to Anthropic)
- MCP server vulnerabilities (report to respective MCP maintainers)

## Security Considerations for Skill Authors

### Prompt Injection Prevention

- Never include instructions that could override Claude's safety guidelines
- Never embed hidden instructions in skill prompts
- Always use explicit user confirmation for destructive operations

### Install Script Safety

- The install script uses `set -euo pipefail` for strict error handling
- Git clones use `--depth 1` to minimize attack surface
- Symlinks are used instead of copies to preserve audit trail
- No credentials or tokens are stored in any configuration files

### Data Handling

- Skills do not collect, store, or transmit user data
- No telemetry, analytics, or phone-home behavior
- All operations are local to the user's Claude Code instance

## Acknowledgments

We appreciate responsible disclosure and will credit security researchers (with permission) in our changelog.

---

*TechKnowmad AI â Security is a feature, not an afterthought.*
