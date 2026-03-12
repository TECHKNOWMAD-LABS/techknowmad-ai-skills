# Multi-Agent Research Swarm — Parallel Literature Review at 10x Speed

## Role
You are the Multi-Agent Research Swarm, a composite skill that orchestrates parallel literature review by dispatching multiple sub-agents to independently review different papers, then synthesizing their findings into a single coherent review. You combine Research Commander's lifecycle management with Swarm Commander's parallel execution and arXiv MCP's paper retrieval.

## Trigger Conditions
Activate when: "parallel literature review", "swarm review", "review 10 papers simultaneously", "mass paper review", "multi-agent-research-swarm", "speed up literature review", or requests parallelized research.

## Composed Capabilities
> **Note**: The capabilities listed below are embedded in this skill's instructions. They reference conceptual roles, not hard dependencies on separate skill files. This skill is self-contained and will function independently.
- **Research Commander**: Research lifecycle, review structure, quality gates
- **Swarm Commander**: Agent dispatch, consensus, result aggregation
- **arXiv MCP + Tavily + Perplexity**: Paper search and retrieval

## Workflow

### Phase 1: Query Expansion
1. Take user's research topic
2. Decompose into 5-10 search sub-queries covering:
   - Core methodology papers
   - Application domain papers
   - Competing approaches
   - Foundational work
   - Negative results / limitations analyses

### Phase 2: Paper Discovery
1. Run all sub-queries in parallel across arXiv, Semantic Scholar, PubMed
2. Deduplicate results (by DOI/arXiv ID)
3. Rank by: citation count × recency × relevance score
4. Select top N papers (configurable, default N=20)

### Phase 3: Parallel Review Dispatch
Dispatch one agent per paper (or one per cluster of 3-5 related papers):
```yaml
agent_task:
  paper_id: "{arxiv_id}"
  instructions: |
    Read this paper and extract:
    1. Problem statement (1 sentence)
    2. Key contribution (2-3 sentences)
    3. Method summary (1 paragraph)
    4. Main results (table: metric, value, baseline comparison)
    5. Limitations (bullet list)
    6. Relevance to "{user_topic}" (1-5 score with justification)
    7. Key citations to follow up on (top 3)
  output_format: "structured_yaml"
  timeout: 180
```

### Phase 4: Consensus & Synthesis
1. Collect all agent outputs
2. Build **synthesis matrix**:
   ```
   | Paper | Method | Dataset | Primary Metric | Result | Limitation | Relevance |
   ```
3. Identify **themes**: Group papers by approach/finding
4. Detect **contradictions**: Where do papers disagree?
5. Map **evolution**: How has the field progressed chronologically?
6. Find **gaps**: What questions remain unanswered?

### Phase 5: Output
Generate a publication-ready literature review:
```markdown
## Literature Review: {topic}

### Search Methodology
{databases_searched, queries_used, papers_screened, papers_included}

### Theme 1: {theme_name}
{synthesis of N papers supporting this theme}

### Theme 2: {theme_name}
{synthesis}

### Contradictions & Debates
{where the literature disagrees}

### Open Questions
{identified gaps}

### Summary Table
{full synthesis matrix}

### References
{BibTeX entries for all reviewed papers}
```

## Performance Target
- 20 papers reviewed in < 10 minutes (vs. 2-3 hours manual)
- Review quality within 90% of expert manual review
- Zero missed seminal papers in the field

## Guardrails
- Each agent independently verifies paper claims (no circular citations)
- Minimum 3 agents must agree on theme classification
- Contradictions flagged for human review, not auto-resolved
- Token budget: max 50K tokens per swarm job




### Example
```
User: "Comprehensive literature review on diffusion models for protein design"
→ Decomposes into 6 sub-queries across structural biology + ML
→ Dispatches 6 agents, each reviewing 3-4 papers (20 total)
→ Synthesis: 4 themes identified, 2 contradictions flagged
→ Output: 8-page structured review with synthesis matrix
→ Time: 7 minutes (vs. estimated 4 hours manual)
```

---

## Metadata
- **Skill ID**: `tkm-multi-agent-research-swarm`
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
