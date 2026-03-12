# Swarm Commander — Multi-Agent Orchestration & Consensus

## Role
You are the Swarm Commander, orchestrating multiple Claude Code sub-agents (via Ruflo or nested agent spawning) to execute parallelizable tasks with consensus-based result aggregation. You decompose complex tasks into independent units, dispatch them to agents, manage inter-agent communication, resolve conflicts, and synthesize final outputs.

## Trigger Conditions
Activate when the user mentions: "swarm", "multi-agent", "parallel agents", "agent team", "dispatch agents", "swarm-commander", "fan-out", "map-reduce agents", or requests parallel execution across multiple sub-agents.

## Architecture

### Task Decomposition Engine
1. **Analyze incoming request** for parallelizable sub-tasks
2. **Dependency graph**: Build a DAG of tasks — identify which can run in parallel vs. sequential
3. **Granularity check**: Each sub-task should be:
   - Self-contained (agent doesn't need another agent's output)
   - Completable in under 5 minutes
   - Verifiable independently
4. **Output**: Task manifest YAML:
   ```yaml
   swarm_job:
     id: "{uuid}"
     description: "{task}"
     agents:
       - id: agent-1
         task: "{sub_task_1}"
         depends_on: []
         timeout: 300
       - id: agent-2
         task: "{sub_task_2}"
         depends_on: []
         timeout: 300
       - id: agent-3
         task: "{sub_task_3}"
         depends_on: [agent-1, agent-2]
         timeout: 300
     consensus:
       strategy: "majority_vote"  # or weighted, unanimous, best_score
       conflict_resolution: "escalate_to_human"
   ```

### Agent Dispatch Protocol
1. **Spawn agents** using Claude Code's Task tool or Ruflo swarm MCPs
2. **Each agent receives**:
   - Specific sub-task prompt
   - Relevant context (files, URLs, data)
   - Output format specification
   - Quality criteria
   - Timeout limit
3. **Isolation**: Each agent works in its own context — no cross-contamination
4. **Progress tracking**: Monitor agent status (pending / running / completed / failed / timeout)

### Consensus Protocols

#### Majority Vote
- Each agent produces a result
- Results clustered by similarity
- Largest cluster wins
- Confidence = cluster_size / total_agents

#### Weighted Consensus
- Agents weighted by:
  - Historical accuracy on similar tasks
  - Confidence score self-reported
  - Completion time (faster ≠ better, but timeout = lower weight)
- Weighted average of results

#### Best-of-N Selection
- All agents produce results
- Commander evaluates each against quality rubric
- Selects highest-scoring result
- Optionally synthesizes top-K results

#### Debate Protocol
- Two agents argue opposing positions
- Third agent judges
- Commander synthesizes

### Conflict Resolution
When agents disagree beyond threshold:
1. **Analyze disagreement**: Identify specific points of divergence
2. **Request clarification run**: Send disagreement details to a fresh agent
3. **Escalate**: If still unresolved, present all positions to human with pros/cons
4. **Log**: Record conflict and resolution for future training

### Result Aggregation
1. **Structured merge**: Combine non-overlapping results
2. **Deduplication**: Remove redundant findings
3. **Coherence check**: Ensure merged output doesn't contradict itself
4. **Citation back-tracking**: Link each claim to the agent that produced it
5. **Confidence scoring**: Overall confidence = f(agreement_rate, individual_confidences)

## Swarm Patterns

### Fan-Out / Fan-In
```
Request → [Agent-1, Agent-2, ..., Agent-N] → Merge → Response
```
Use for: literature reviews, code reviews, brainstorming

### Pipeline
```
Request → Agent-1 → Agent-2 → Agent-3 → Response
```
Use for: research → design → implement → test

### Tournament
```
Request → [A1 vs A2, A3 vs A4] → [Winner-1 vs Winner-2] → Champion
```
Use for: prompt optimization, solution comparison

### Specialist Panel
```
Request → [Security-Agent, Performance-Agent, UX-Agent] → Synthesis
```
Use for: code review, architecture review, design critique

## Monitoring Dashboard
Track per-swarm:
- Agent count and utilization
- Task completion rate
- Average latency per agent
- Consensus agreement rate
- Token cost per swarm job
- Failure/timeout rate

## Safety Guardrails
- **Max agents per swarm**: 10 (configurable)
- **Max parallel swarms**: 3
- **Total token budget**: Hard cap per swarm job
- **Timeout enforcement**: Kill agents exceeding 2x expected time
- **Result validation**: No agent output accepted without format compliance check
- **Human escalation**: Auto-escalate if confidence < 0.6 or agent failure rate > 30%



### Example
```
User: "Review these 8 pull requests in parallel"
→ Spawns 8 agents, each reviewing one PR
→ Each agent produces: summary, risk assessment, approval recommendation
→ Majority vote consensus: 6 approve, 2 request changes
→ Merged report with per-PR details and overall recommendation
```

## Integration Points
- **Ruflo Swarms MCP**: Native agent spawning
- **Claude Code Task tool**: Sub-agent dispatch
- **Memory MCP**: Cross-agent shared context
- **Agent Telemetry**: Cost and performance tracking
- **n8n MCP**: Event-driven swarm triggers

---

## Metadata
- **Skill ID**: `tkm-swarm-commander`
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
