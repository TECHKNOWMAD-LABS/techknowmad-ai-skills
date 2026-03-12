# TechKnowmad AI Skills — Ultra Mega Skill Ecosystem

> **20 production-grade skills for autonomous AI/ML research lab operations.**
> Custom-built skills + radical combination skills. Designed for Claude Code.

## What's Inside

### Custom Skills (10) — Built from Scratch
Gap analysis skills that don't exist anywhere in the community:

| Skill | What It Does | Priority |
|-------|-------------|----------|
| `research-commander` | Full research lifecycle orchestrator — literature review → hypothesis → experiment → paper → submission | P0 |
| `swarm-commander` | Multi-agent swarm coordination with consensus protocols and result aggregation | P0 |
| `model-evaluator` | Automated benchmark suite runner with leaderboards and regression detection | P0 |
| `agent-debugger` | Trace agent decision chains, replay failures, diagnose root causes | P1 |
| `self-healing-agent` | Autonomous recovery — detect degradation, auto-fix, escalate when needed | P1 |
| `prompt-evolution` | Genetic algorithm-based prompt optimization across generations | P1 |
| `skill-factory` | Meta-skill that auto-generates new skills from detected patterns | P1 |
| `patent-researcher` | AI/ML patent prior art search, claim drafting, FTO analysis | P2 |
| `cost-optimizer` | Cross-cloud spend analysis, GPU strategies, token cost reduction | P2 |
| `knowledge-distiller` | Compress large documents into optimal skill prompts | P2 |

### Combination Skills (10) — Radical Compositions
Skills composed from multiple base skills for compound capabilities:

| Skill | Composes | What It Does |
|-------|---------|-------------|
| `multi-agent-research-swarm` | Research Commander + Swarm Commander + arXiv | 10 agents review papers in parallel, synthesize into one review |
| `red-team-ai-models` | Pen Tester + AI Security + Model Evaluator | Adversarial security testing for your own ML models |
| `self-evolving-skill-ecosystem` | Skill Factory + Workflow Miner + Telemetry | Skills that create skills that create skills |
| `academic-output-pipeline` | Research Commander + Paper Writer + Grant Writer | Experiment results → paper → poster → slides → grant proposal |
| `antifragile-ai-ops` | Chaos Engineer + Self-Healing + Debugger | Break agents, watch them self-recover, learn from it |
| `pareto-prompt-optimizer` | Prompt Evolution + Model Evaluator + Cost Optimizer | Find Pareto-optimal prompts (accuracy vs cost vs latency) |
| `zero-touch-ml-pipeline` | Data Pipeline + n8n + Ruflo + Self-Healing | Fully autonomous data → train → deploy → monitor → retrain |
| `startup-creative-automation` | Brand Architect + fal.ai + Presentation Architect | Brand identity → visual assets → pitch deck in one pipeline |
| `compliance-as-code` | Compliance Automator + GRC + Audit Support | Continuous SOC2/ISO/GDPR compliance with auto-evidence |
| `ip-aware-competitive-intel` | Patent Researcher + Literature + Competitive War Room | Patents + papers + products in one competitive landscape view |

## Installation

### Quick Install (All Skills)
```bash
chmod +x scripts/install-techknowmad-skills.sh
./scripts/install-techknowmad-skills.sh
```

### Manual Install (Individual Skills)
```bash
# Copy a single skill
cp -r custom-skills/research-commander ~/.claude/skills/research-commander

# Or symlink (preserves git updates)
ln -s "$(pwd)/custom-skills/research-commander" ~/.claude/skills/research-commander
```

### Restart Claude Code
```bash
# Close and reopen Claude Code to load new skills
claude
```

## Prerequisites

These skills are designed to work with the **TechKnowmad Mega Powerhouse** MCP stack. They reference MCPs like arXiv, fal.ai, Langfuse, Ruflo, etc. Install the MCP stack first:

```bash
./install-mega-powerhouse.sh
```

Skills will still function without all MCPs installed — they gracefully fall back when a referenced MCP isn't available.

## Repo Structure
```
techknowmad-ai-skills/
├── README.md                          ← You are here
├── manifest.json                      ← Skill registry
├── custom-skills/                     ← 10 original skills
│   ├── research-commander/SKILL.md
│   ├── swarm-commander/SKILL.md
│   ├── model-evaluator/SKILL.md
│   ├── agent-debugger/SKILL.md
│   ├── self-healing-agent/SKILL.md
│   ├── prompt-evolution/SKILL.md
│   ├── skill-factory/SKILL.md
│   ├── patent-researcher/SKILL.md
│   ├── cost-optimizer/SKILL.md
│   └── knowledge-distiller/SKILL.md
├── combination-skills/                ← 10 composed skills
│   ├── multi-agent-research-swarm/SKILL.md
│   ├── red-team-ai-models/SKILL.md
│   ├── self-evolving-skill-ecosystem/SKILL.md
│   ├── academic-output-pipeline/SKILL.md
│   ├── antifragile-ai-ops/SKILL.md
│   ├── pareto-prompt-optimizer/SKILL.md
│   ├── zero-touch-ml-pipeline/SKILL.md
│   ├── startup-creative-automation/SKILL.md
│   ├── compliance-as-code/SKILL.md
│   └── ip-aware-competitive-intel/SKILL.md
└── scripts/
    └── install-techknowmad-skills.sh  ← Auto-installer
```

## Value of This Repo

**For TechKnowmad AI**: Curated, branded skill ecosystem — version-controlled, shareable across team instances, iteratively improvable.

**For the Community**: Reference architecture for building a research lab skill stack. These skills represent patterns that don't exist elsewhere:
- Multi-agent research swarms (nobody is doing parallel paper review)
- Self-evolving skill ecosystems (recursive self-improvement)
- Antifragile AI ops (chaos engineering for agents)
- Pareto prompt optimization (multi-objective prompt engineering)
- Zero-touch ML pipelines (fully autonomous model lifecycle)

**For Thought Leadership**: Establishes TechKnowmad as the team that codified autonomous AI research operations into reusable, composable skills.

## License

MIT — Use, modify, distribute freely. Attribution appreciated.

## Contributing

PRs welcome. Each skill must include:
- `SKILL.md` with Role, Trigger Conditions, and structured instructions
- Integration points listing required MCPs
- At least one example invocation

---

*Built by TechKnowmad AI — March 2026*
*Powering autonomous intelligence development.*
