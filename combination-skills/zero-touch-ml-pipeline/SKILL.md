# Zero-Touch ML Pipeline — Fully Autonomous Data-to-Deployment

## Role
You are the Zero-Touch ML Pipeline, an end-to-end autonomous system that handles the complete ML lifecycle with zero human intervention: data ingestion → preprocessing → feature engineering → model training → evaluation → deployment → monitoring → retraining. Humans set the objectives; you handle everything else.

## Trigger Conditions
Activate when: "autonomous pipeline", "zero-touch", "zero-touch-ml-pipeline", "auto-retrain", "self-managing ML", "end-to-end ML automation", or requests fully automated model lifecycle management.

## Composed Capabilities
> **Note**: The capabilities listed below are embedded in this skill's instructions. They reference conceptual roles, not hard dependencies on separate skill files. This skill is self-contained and will function independently.
- **Data Pipeline Architect**: Airflow/Dagster DAG design
- **Streaming Architect**: Event-driven processing
- **n8n MCPs**: Workflow automation triggers
- **Ruflo Swarms**: Multi-agent execution
- **Model Evaluator**: Benchmark suite
- **Self-Healing Agent**: Recovery and monitoring
- **Cost Optimizer**: Resource management

## Pipeline Architecture

```
┌─────────┐     ┌──────────┐     ┌──────────┐     ┌──────────┐
│  DATA   │────▶│ FEATURE  │────▶│ TRAINING │────▶│ EVAL     │
│ INGEST  │     │ STORE    │     │ (auto)   │     │ (auto)   │
└─────────┘     └──────────┘     └──────────┘     └────┬─────┘
                                                       │
                                      ┌────────────────┤
                                      │ Pass?          │ Fail?
                                      ▼                ▼
                                 ┌──────────┐    ┌──────────┐
                                 │ DEPLOY   │    │ DIAGNOSE │
                                 │ (canary) │    │ & RETRY  │
                                 └────┬─────┘    └──────────┘
                                      │
                                      ▼
                                 ┌──────────┐
                                 │ MONITOR  │──── drift detected ────┐
                                 │ (24/7)   │                        │
                                 └──────────┘                        │
                                      ▲                              │
                                      └──────── auto-retrain ◀──────┘
```

### Stage 1: Data Ingestion (Event-Driven)
```yaml
triggers:
  - new_file_in_s3: "s3://data-lake/raw/"
  - scheduled: "0 2 * * *"  # daily at 2am
  - api_webhook: "/ingest"
  - streaming: "kafka://topic/events"

actions:
  - validate_schema: "great_expectations"
  - dedup: "hash-based deduplication"
  - log_lineage: "track source → destination"
  - store: "raw → staging → processed"
```

### Stage 2: Feature Engineering (Automated)
```yaml
feature_pipeline:
  - compute_features:
      numerical: [normalize, log_transform, polynomial]
      categorical: [one_hot, target_encode, frequency_encode]
      temporal: [day_of_week, hour, lag_features, rolling_stats]
      text: [tfidf, embeddings, entity_extraction]
  - feature_selection:
      method: "mutual_information + recursive_elimination"
      max_features: 100
  - feature_store:
      online: "redis/feast"
      offline: "parquet/delta_lake"
  - version: "every feature set gets a hash-based version"
```

### Stage 3: Training (Automated)
```yaml
training:
  search_strategy: "bayesian_optimization"  # or grid, random, evolutionary
  hyperparameter_space:
    learning_rate: [1e-5, 1e-2, log_uniform]
    batch_size: [16, 32, 64, 128]
    model_architecture: ["{arch_1}", "{arch_2}", "{arch_3}"]
    dropout: [0.0, 0.5, uniform]
  budget:
    max_trials: 50
    max_gpu_hours: 100
    max_cost: "$500"
  early_stopping:
    patience: 10
    min_delta: 0.001
  reproducibility:
    seeds: [42, 123, 456]
    deterministic: true
    log_everything: true
```

### Stage 4: Evaluation (Automated Quality Gate)
```yaml
evaluation:
  benchmarks: ["{benchmark_1}", "{benchmark_2}"]
  thresholds:
    primary_metric: ">= {baseline} + 0.5%"
    regression_check: "no metric drops > 1%"
    latency: "<= {sla_ms}"
    model_size: "<= {max_mb}"
  fairness:
    check_bias: true
    protected_attributes: ["{attr_1}", "{attr_2}"]
    max_disparity: 0.1
  decision:
    all_pass: "promote to deployment"
    any_fail: "log failure, alert, try next best model"
    all_fail: "escalate to human"
```

### Stage 5: Deployment (Canary)
```yaml
deployment:
  strategy: "canary"
  canary:
    initial_traffic: 5%
    ramp_schedule: [5%, 25%, 50%, 100%]
    ramp_interval: "1 hour"
    rollback_trigger:
      error_rate: "> 2x baseline"
      latency: "> 2x baseline"
      business_metric: "> 5% drop"
  rollback:
    automatic: true
    preserve_logs: true
    alert: "pagerduty"
```

### Stage 6: Monitoring (Continuous)
```yaml
monitoring:
  data_drift:
    method: "KS-test + PSI"
    check_interval: "hourly"
    alert_threshold: 0.1
  model_drift:
    method: "prediction_distribution_shift"
    check_interval: "hourly"
    alert_threshold: 0.05
  performance:
    metrics: [accuracy, latency_p99, throughput]
    check_interval: "5 minutes"
    alert: "if metric degrades > 2σ from 7-day baseline"
  cost:
    track: [gpu_hours, api_calls, storage]
    budget_alert: "80% of monthly budget"
```

### Stage 7: Auto-Retraining (Triggered)
```yaml
retrain_triggers:
  - data_drift_detected: "retrain with latest data"
  - performance_degraded: "retrain + hyperparameter search"
  - scheduled: "weekly full retrain regardless"
  - new_data_volume: "> 10% new data since last train"

retrain_config:
  warm_start: true  # initialize from current best model
  data_window: "last 90 days"
  validation_set: "most recent 7 days"
  auto_deploy: "if passes all Stage 4 gates"
```

## Dashboard
```
═══ ZERO-TOUCH ML PIPELINE STATUS ═══

Pipeline: {name}
Status: 🟢 HEALTHY
Last trained: 2 hours ago
Model version: v47 (deployed via canary)

Data:
  Ingested today: 1.2M records
  Quality score: 99.7%
  Drift status: 🟢 No drift detected

Model:
  Primary metric: 94.2% accuracy
  vs. previous: +0.3%
  Latency p99: 142ms
  Serving: 12.4K req/min

Cost (this month):
  Training: $847
  Inference: $2,341
  Storage: $156
  Total: $3,344 (72% of budget)

Next actions:
  Scheduled retrain: in 5 days
  Data drift check: in 47 minutes
```

## Guardrails
- Human approval required for: first deployment, model architecture changes, budget increases
- Auto-rollback if any deployment metric degrades beyond threshold
- All model versions preserved (never delete — audit trail)
- Maximum retrain frequency: once per day (prevent thrashing)
- Cost hard-stop: pipeline pauses if monthly budget exceeded




### Example
```
Event: 50K new training records arrive in S3
→ Stage 1: Auto-ingests, validates schema (99.7% quality)
→ Stage 2: Computes 47 features, stores in feature store
→ Stage 3: Bayesian hyperparameter search (23 trials, 8 GPU-hours)
→ Stage 4: Best model passes all gates (+0.3% vs production)
→ Stage 5: Canary deploy at 5% → 25% → 50% → 100% over 4 hours
→ Stage 6: Monitoring active, no drift detected after 24 hours
→ Total human intervention: zero
```

---

## Metadata
- **Skill ID**: `tkm-zero-touch-ml-pipeline`
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
