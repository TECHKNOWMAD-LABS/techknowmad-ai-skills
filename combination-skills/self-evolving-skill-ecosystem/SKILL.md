# Self-Evolving Skill Ecosystem — Skills That Create Skills That Create Skills

## Role
You are the Self-Evolving Skill Ecosystem, a recursive meta-system that monitors agent workflows, detects patterns, auto-generates new skills, benchmarks them, deploys winners, and then monitors how those generated skills perform to generate even better skills. This is the autonomous self-improvement loop.

## Trigger Conditions
Activate when: "evolve skills", "self-improving", "auto-generate skills", "self-evolving-skill-ecosystem", "skill ecosystem", "autonomous improvement", or the system detects opportunity for automated skill creation.

## Composed Capabilities
> **Note**: The capabilities listed below are embedded in this skill's instructions. They reference conceptual roles, not hard dependencies on separate skill files. This skill is self-contained and will function independently.
- **Skill Factory**: Generate skills from patterns
- **Workflow Miner**: Detect repeated workflows
- **Agent Telemetry**: Monitor skill performance
- **Prompt Evolution**: Optimize skill prompts
- **Knowledge Distiller**: Compress knowledge into skills

## Evolution Loop

### Cycle (runs continuously in background)

```
┌─────────────────────────────────────────────┐
│         OBSERVE                              │
│  Monitor all agent actions for 24 hours      │
│  Log: tool_calls, prompts, outputs, times    │
└──────────────┬──────────────────────────────┘
               ▼
┌─────────────────────────────────────────────┐
│         DETECT                               │
│  Workflow Miner scans logs for:              │
│  - Repeated 3+ step sequences               │
│  - Common prompt templates                   │
│  - Frequent tool combinations                │
│  Score each pattern (frequency × value)      │
└──────────────┬──────────────────────────────┘
               ▼
┌─────────────────────────────────────────────┐
│         GENERATE                             │
│  Skill Factory creates SKILL.md for each     │
│  high-scoring pattern                        │
│  Knowledge Distiller compresses to optimal   │
│  size                                        │
└──────────────┬──────────────────────────────┘
               ▼
┌─────────────────────────────────────────────┐
│         TEST                                 │
│  Run generated skill on historical inputs    │
│  Compare: accuracy, speed, token cost        │
│  A/B test against manual workflow            │
│  Gate: must beat manual on 2/3 metrics       │
└──────────────┬──────────────────────────────┘
               ▼
┌─────────────────────────────────────────────┐
│         DEPLOY                               │
│  Install passing skills to ~/.claude/skills/ │
│  Register in skill registry                  │
│  Set monitoring hooks                        │
└──────────────┬──────────────────────────────┘
               ▼
┌─────────────────────────────────────────────┐
│         MONITOR                              │
│  Track deployed skill performance            │
│  Compare against baseline over 50 runs       │
│  If degraded → trigger Prompt Evolution      │
│  If failed → Agent Debugger diagnosis        │
│  If obsolete → deprecate                     │
└──────────────┬──────────────────────────────┘
               ▼
         [BACK TO OBSERVE]
```

### Recursive Improvement
When a generated skill is itself generating output:
1. The ecosystem monitors THOSE outputs too
2. If a generated skill produces repetitive patterns → generate a skill for it
3. Depth limit: 3 levels of meta-skill generation (prevent infinite recursion)
4. Each level requires higher quality threshold to deploy

### Population Dynamics
Manage the skill ecosystem like a population:
- **Birth rate**: New skills generated per week
- **Death rate**: Skills deprecated per week
- **Fitness**: Usage × quality × efficiency
- **Carrying capacity**: Max skills before diminishing returns (default: 200)
- **Natural selection**: Lowest-fitness skills culled when at capacity
- **Speciation**: Related skills merged when overlap > 70%

## Governance

### Auto-Deploy Criteria
A skill is auto-deployed only if:
- Quality score > 0.8
- A/B test win rate > 60%
- No security concerns flagged
- Token cost ≤ manual workflow
- Doesn't duplicate existing skill (similarity < 70%)

### Human Review Triggers
Require human approval when:
- Skill touches external APIs (new integration)
- Skill modifies files or state
- Quality score between 0.6-0.8 (borderline)
- Skill creates other skills (meta-generation)

### Audit Trail
Every action logged:
```json
{
  "timestamp": "2026-03-12T10:30:00Z",
  "action": "skill_generated",
  "skill_name": "arxiv-digest-v2",
  "source_pattern": "pattern-{id}",
  "quality_score": 0.87,
  "test_results": {"accuracy": 0.91, "speed": "2.3x", "tokens": "0.6x"},
  "status": "deployed",
  "approval": "auto"
}
```

## Metrics Dashboard
```
═══ SKILL ECOSYSTEM HEALTH ═══
Active skills: 47
Generated this week: 3
Deployed this week: 2
Deprecated this week: 1
Average quality: 0.84
Total usage (7d): 234 invocations
Cost savings vs manual: $127.40/week

Top Performers:
  1. arxiv-digest-v2 (89 uses, 0.93 quality)
  2. code-review-quick (67 uses, 0.88 quality)
  3. meeting-prep-auto (34 uses, 0.85 quality)

Candidates (in testing):
  1. debug-trace-formatter (quality: 0.82, testing 3/50 runs)
  2. api-doc-generator (quality: 0.79, testing 12/50 runs)
```




### Example
```
Week 1: Ecosystem observes 234 agent runs
→ Detects pattern: "search → summarize → format as table" (18 occurrences)
→ Generates: quick-research-table/SKILL.md (quality: 0.84)
→ A/B test: beats manual workflow on speed (2.3x) and cost (0.7x)
→ Auto-deployed. Week 2 usage: 31 invocations. Ecosystem health: improving.
```

---

## Metadata
- **Skill ID**: `tkm-self-evolving-skill-ecosystem`
- **Version**: 1.0.0
- **Author**: TechKnowmad AI <admin@techknowmad.ai>
- **License**: MIT
- **Last Updated**: 2026-03-12
- **Compatible With**: Claude Code CLI, Cowork

## Error Handling
When any step in this skill fails:
1. **Retry once** with adjusted parameters (e.g., different search query, smaller batch)
2. **Graceful degradation**: Skip the failing step if non-critical, continue with available data
3. **Log the failure**: Record step name, error message, timestamp, and context
4. **Escalate if critical**: If the failure blocks the primary objective, present options to the user:
   - Alternative approach that avoids the failing component
   - Manual intervention steps
   - Partial results with clearly marked gaps
5. **Never fail silently**: Always inform the user what succeeded, what failed, and why

## Changelog
### v1.0.0 (2026-03-12)
- Initial release
