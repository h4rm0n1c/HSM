# HSM State Schemas

This document defines readable v0 schema shapes for HSM records. These are intentionally boring. Start explicit and inspectable before compressing.

## Shared fields

Most durable records should include:

```yaml
id: string
schema_version: string
created_at: iso8601_or_unknown
updated_at: iso8601_or_unknown
status: draft | active | deprecated | rejected
confidence: low | medium | high | unknown
sensitivity: public | personal | sensitive | restricted | unknown
evidence_refs: []
notes: []
```

Use `unknown` when unknown. Do not invent completion.

## Source reference

```yaml
source_ref:
  id: src.example
  type: direct_record | versioned_artifact | third_party_observation | self_report | model_inference | unknown
  location: "repo/path/url/file/ref or description"
  date: unknown
  collected_at: unknown
  summary: "short source summary"
  reliability: low | medium | high | unknown
  access: public | private | local | unknown
```

## Evidence record

```yaml
evidence_record:
  id: ev.example
  source_ref: src.example
  kind: document | repo | message | archive | image | audio | video | testimony | report | other
  subject: "what this evidence is about"
  date_or_period: unknown
  extracted_text: null
  summary: "brief neutral summary"
  claims: []
  sensitivity: unknown
  confidence: unknown
```

## Claim record

```yaml
claim_record:
  id: claim.example
  claim: "plain statement"
  claim_type: event | preference | skill | relationship | constraint | value | pattern | anchor | trigger | uncertainty | other
  source_refs: []
  derived_from: []
  date_or_period: unknown
  confidence: low | medium | high | unknown
  support_level: direct | indirect | inferred | contradicted | unknown
  contradictions: []
  promote_to_state: false
  notes: []
```

## Subject state

```yaml
subject_state:
  id: subject.local
  schema_version: hsm-subject-state-v0.1
  identity:
    stable_traits: []
    values: []
    roles: []
    voice_style: []
  current_projects: []
  skills: []
  preferences: []
  constraints: []
  relationships: []
  open_loops: []
  uncertainties: []
  evidence_refs: []
```

## Quiescent state

```yaml
quiescent_state:
  id: qs.local
  baseline:
    mood: unknown
    activation: unknown
    threat_level: unknown
    cognitive_style: unknown
  preferred_anchors: []
  stabilising_actions: []
  destabilising_cues: []
  avoidance_patterns: []
  recovery_patterns: []
  recovery_time_profile:
    fast: unknown
    medium: unknown
    long: unknown
  evidence_refs: []
```

## Anchor record

```yaml
anchor:
  id: anchor.example
  type: person | role | routine | place | project | tool | sensory | value | narrative | technical_task | archive | other
  description: "what the anchor is"
  stabilises_by: []
  signs_anchor_is_active: []
  failure_mode_if_lost: unknown
  recovery_use: unknown
  confidence: unknown
  evidence_refs: []
```

## Affective pattern

```yaml
affective_pattern:
  id: affect.example
  cue_class: unknown
  immediate_reaction: unknown
  body_or_state_signal: unknown
  behaviour_output: unknown
  later_explanation_pattern: unknown
  usual_delay: seconds | minutes | hours | days | variable | unknown
  linked_memory_clusters: []
  stabilising_response: unknown
  confidence: unknown
  evidence_refs: []
```

## Runtime packet

```yaml
runtime_packet:
  packet_version: hsm-runtime-v0.1
  task:
    kind: unknown
    user_request: "summary"
    success_criteria: []
    constraints: []
  active_state:
    relevant_claims: []
    relevant_preferences: []
    active_projects: []
    open_loops: []
    uncertainties: []
  quiescent_context:
    anchor_status: stable | weakened | lost | restored | unknown
    active_anchors: []
    destabilising_cues: []
  affective_context:
    reaction_phase: baseline | immediate | aftershock | integration | recovery | unknown
    trigger_candidates: []
    explanation_confidence: low | medium | high | unknown
  evidence_refs: []
  output_contract:
    label_uncertainty: true
    separate_fact_from_inference: true
    do_not_promote_output_to_state: true
```

## Integrity result

```yaml
integrity_result:
  id: integrity.example
  output_ref: unknown
  extracted_claims: []
  unsupported_claims: []
  contradictions: []
  inference_mislabeled_as_fact: []
  update_candidates: []
  decision: reject | transient | hypothesis | durable_update | needs_review
  reviewer_notes: []
```

## Rule

Schemas are allowed to evolve. Do not break source provenance when changing them.
