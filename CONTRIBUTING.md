# Contributing to TechKnowmad AI Skills

## Skill Submission Guidelines

### Structure
Every skill must live in its own directory containing a SKILL.md file.

### Required Sections
1. **Title** - Skill Name and One-Line Description
2. **Role** - What the skill does, written as a system prompt
3. **Trigger Conditions** - Keywords and phrases that activate the skill
4. **Workflow / Pipeline** - Step-by-step instructions
5. **Example** - A concrete input/output walkthrough
6. **Metadata** - Skill ID, version, author, license
7. **Error Handling** - Standard 5-step: retry, degrade, log, escalate, never silent
8. **Changelog** - Versioned history of changes

### Quality Bar
- No broken dependencies - skills must be self-contained
- Concrete examples with realistic data flows
- YAML configs for any parameterized behavior
- Integration points listed (MCPs, APIs, tools)
- Guardrails and safety limits defined

### Naming Conventions
- Directory names: kebab-case
- Skill IDs: tkm-{skill-name}
- Categories: custom-skills/ or combination-skills/

### Versioning
Follow semver: MAJOR.MINOR.PATCH
