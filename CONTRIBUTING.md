# Contributing to TechKnowmad AI Skills

## Skill Submission Guidelines

### Structure

Every skill must live in its own directory containing a `SKILL.md` file:

```
skills/
└── my-new-skill/
    └── SKILL.md
```

### Required Sections

Your `SKILL.md` must include all of the following:

1. **Title** — `# Skill Name — One-Line Description`
2. **Role** — What the skill does, written as a system prompt
3. **Trigger Conditions** — Keywords and phrases that activate the skill
4. **Workflow / Pipeline** — Step-by-step instructions with YAML configs where applicable
5. **Example** — A concrete input → output walkthrough
6. **Metadata** — Skill ID, version, author, license, last updated, compatibility
7. **Error Handling** — 5-step standard: retry → degrade → log → escalate → never silent
8. **Changelog** — Versioned history of changes

### Quality Bar

- No broken dependencies — skills must be self-contained
- Concrete examples with realistic data flows
- YAML configs for any parameterized behavior
- Integration points listed (MCPs, APIs, tools)
- Guardrails and safety limits defined

### Naming Conventions

- Directory names: `kebab-case`
- Skill IDs: `tkm-{skill-name}`
- Categories: `custom-skills/` or `combination-skills/`

### Submitting

1. Fork this repo
2. Create a branch: `git checkout -b skill/my-new-skill`
3. Add your skill directory and `SKILL.md`
4. Run the installer locally to verify symlinks work
5. Open a PR with a description of the skill's purpose and trigger conditions

### Versioning

Follow semver: `MAJOR.MINOR.PATCH`

- **MAJOR**: Breaking changes to trigger conditions or output format
- **MINOR**: New capabilities, new integration points
- **PATCH**: Bug fixes, documentation improvements
