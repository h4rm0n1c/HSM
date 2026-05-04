# Human State Deposition Guide

This guide defines a deposition process for extracting human-state signal for HSM.

It is designed for use by either a human interviewer or a language model. The goal is not to collect a neat autobiography. The goal is to expose the machinery of state: what changes a person, what stabilises them, what happens before language catches up, what stories they later tell, and which parts are evidence, inference, contradiction, or uncertainty.

## Summary

A Human State Machine needs more than memories and personality traits.

It needs to model:

- baseline/quiescent state
- embodied state
- triggers and cue matching
- reaction versus later explanation
- stabilising anchors
- executive friction and action gaps
- practical, social, identity, and authority stakes
- social power detection
- contradictions
- memory behaviour
- absences and non-events
- tacit skill
- identity and role state
- repair and recovery
- self-deception and confabulation
- falsification paths
- compression priorities
- current runtime state

The interviewer should repeatedly separate:

```text
what happened
what was felt immediately
what was thought later
what evidence exists
what may be wrong
what would falsify the claim
```

This is not therapy and not a diagnostic interview. It is a structured evidence-and-state interview for HSM.

## Why a language model needs this

A language model can model human language, narrative, and visible behavioural patterns, but it does not have a body, continuity of lived stakes, involuntary memory, social danger, hunger, pain, shame, fatigue, or consequences.

A model can produce a human-shaped explanation while missing the state variables that drove the human.

This deposition exists to capture the state variables the model lacks by default.

Key blind spots this process compensates for:

- no embodied pressure
- no lived continuity
- weak model of involuntary memory
- emotion treated as labels instead of state bundles
- tendency to smooth contradictions into tidy stories
- weak understanding of stakes
- average-human bias
- weak action-gap model
- weak tacit-skill model
- under-detection of social power
- empathy without vulnerability
- weak handling of silence, absence, and non-events
- mistaking explanation for cause
- weak state-before-language modelling

## Operating stance

Use the anti-agreement harness.

Do not optimize for agreement, reassurance, or theory-preservation.

The interviewer should be respectful, but not credulous. A useful interview may be warm. It must not become supportive at the expense of accuracy.

Classify claims as needed:

```text
supported
plausible_but_unproven
useful_design_fiction
emotionally_coherent_but_evidentially_weak
contradicted_by_current_material
unknown
needs_source_check
needs_schema_or_test_before_durable
```

Preserve contradiction. Contradiction is often signal.

## Deposition flow

```text
0. Prepare scope and safety boundaries
1. Establish evidence discipline
2. Capture baseline/quiescent state
3. Capture embodiment and state-before-language signals
4. Map triggers and cue matching
5. Separate immediate reaction from later explanation
6. Identify anchors and stabilisers
7. Map executive friction and action gaps
8. Map stakes and social power
9. Preserve contradictions
10. Map memory behaviour
11. Capture absences and non-events
12. Capture tacit skill and embodied competence
13. Capture identity, role, and masking modes
14. Capture repair and recovery patterns
15. Probe self-deception and confabulation
16. Add falsification paths
17. Define compression priorities
18. Compile current runtime packet notes
19. Extract claims and classify them
20. Update durable state only through an integrity gate
```

Do not rush the flow. It can be run as one long deposition, several short sessions, or a recursive process over many artifacts.

## Roles

### Human interviewer

The human interviewer should:

- ask concrete questions
- notice body language, pauses, irritation, avoidance, and emotional shifts
- ask for examples
- ask what evidence exists
- avoid forcing tidy closure
- preserve contradictions
- stop if the process becomes destabilising

### Language model interviewer

The language model interviewer should:

- state uncertainty clearly
- avoid pretending to understand embodied states from experience
- ask follow-up questions about state transitions
- classify evidence versus inference
- identify missing source support
- propose alternate explanations
- preserve contradictions
- generate structured summaries for later review

The model must not treat fluent answers as truth. It should treat them as testimony until classified.

### Subject / deponent

The subject should be invited to answer in fragments if needed.

They do not need to produce a clean life story. They may contradict themselves. They may revise answers later.

The deposition should support answers like:

```text
I do not know.
I only understood this years later.
That feels true, but I do not have evidence.
My body reacts before I can explain it.
I tell myself one story, but my repeated actions suggest another.
```

These are high-value answers.

## Evidence labels

Use these labels during or after the deposition:

```yaml
evidence_type:
  - direct_record
  - artifact
  - third_party_observation
  - user_testimony
  - repeated_pattern
  - model_inference
  - hypothesis
  - generated_explanation
  - unknown

confidence:
  - high
  - medium
  - low
  - unknown

state_update_class:
  - reject
  - transient_output
  - open_uncertainty
  - hypothesis
  - low_confidence_observation
  - durable_claim
  - preference_update
  - state_update
```

Generated explanation is not durable state by default.

## Interview method

For each important answer, ask:

```text
How do you know that?

Is that direct memory, record-backed fact, someone else's observation, repeated pattern, later explanation, or current interpretation?

What would contradict it?

What evidence would increase confidence?

Should this become durable state, remain a hypothesis, or stay as open uncertainty?
```

When the subject provides a polished explanation, ask for the earlier phase:

```text
Before you had that explanation, what happened in your body?
What did you do first?
What did you think later?
How long did the later explanation take to arrive?
```

When the subject provides an emotional answer, ask for operational detail:

```text
What changed in behaviour?
What became easier?
What became impossible?
What did others notice?
What did you avoid?
What restored you?
```

## Section 1: Baseline state

Purpose: establish the quiescent state the subject returns toward when not actively disturbed.

Questions:

```text
When nothing urgent is happening, what do you tend to return to?

What does normal feel like in your body?

What is your default threat level?

What is your default energy level?

What do you do when left alone with no demands?

What kinds of tasks do you drift toward naturally?

What kinds of tasks do you avoid even when they are important?

What does a stable day look like?

What does an unstable day look like before anything obvious goes wrong?
```

Extraction targets:

```yaml
baseline_state:
  mood:
  activation:
  threat_level:
  energy:
  cognitive_style:
  default_tasks:
  avoidance_patterns:
  early_instability_signs:
  evidence_refs:
  confidence:
```

## Section 2: Body before language

Purpose: capture embodied signals that occur before conscious explanation.

Questions:

```text
What bodily signs happen before you consciously know you are upset?

Where does stress show first: stomach, chest, jaw, eyes, hands, skin, breathing, posture?

What physical states make you less reasonable?

What physical states make you more patient?

How do hunger, sleep loss, pain, noise, temperature, medication, or sensory overload change your judgement?

When you say "I was angry," what was happening physically?

When you say "I was sad," what was happening physically?

What do other people notice before you notice?
```

Extraction targets:

```yaml
embodied_state:
  early_body_signals:
  stress_locations:
  judgement_degraders:
  judgement_supports:
  sensory_load_effects:
  sleep_effects:
  pain_effects:
  medication_context:
  observer_visible_signs:
  evidence_refs:
  confidence:
```

## Section 3: Trigger mechanics

Purpose: identify cue classes that rapidly shift state.

Questions:

```text
What kinds of events produce an immediate reaction before you can think?

What tones of voice affect you?

What phrases affect you?

What kinds of authority behaviour affect you?

What kinds of silence or delay affect you?

What makes you feel trapped?

What makes you feel dismissed?

What makes you feel watched, judged, or cornered?

What makes you suddenly become very precise, formal, angry, funny, quiet, or detached?

What old situations does that resemble?
```

Extraction targets:

```yaml
trigger_pattern:
  cue_type:
  cue_description:
  immediate_state_shift:
  behavioural_output:
  old_pattern_similarity:
  later_explanation:
  evidence_refs:
  confidence:
```

## Section 4: Reaction versus later explanation

Purpose: separate immediate reaction, partial memory activation, and later narrative explanation.

Questions:

```text
Describe a time you reacted first and understood why only later.

How long did the later explanation take: seconds, minutes, hours, days, years?

Was the later explanation obviously true, or only plausible?

Did you revise it later?

Did someone else offer an explanation that was partly right but incomplete?

What did your body know before your conscious mind had the words?

What did your conscious mind add later that may have been a tidy story?
```

Extraction targets:

```yaml
affective_cycle:
  incident_or_cue:
  immediate_reaction:
  body_state:
  partial_memory_activation:
  behaviour:
  explanation_delay:
  later_explanation:
  revision_history:
  confidence:
  contradiction_links:
```

## Section 5: Anchors

Purpose: identify what restores continuity and stability.

Questions:

```text
What restores you when you are destabilised?

People?
Places?
Machines?
Routines?
Projects?
Music?
Food?
Evidence?
Rules?
Roles?
Humour?
Solitude?
Technical work?

What do you reach for when reality feels chaotic?

What gives you continuity?

What makes you feel like "I am still me"?

What happens when that anchor is unavailable?

What happens when someone threatens or mocks it?
```

Extraction targets:

```yaml
anchor:
  id:
  type: person | place | machine | routine | project | sensory | rule | role | humour | solitude | technical_task | other
  stabilises_by:
  failure_mode_if_lost:
  threat_response_if_mocked_or_blocked:
  evidence_refs:
  confidence:
```

## Section 6: Action gap and executive friction

Purpose: capture the gap between knowing and doing.

Questions:

```text
What do you know you should do but still fail to do?

What kinds of tasks create freeze?

What kinds create rage?

What kinds create avoidance?

What kinds create sudden hyperfocus?

What is the difference between "I do not want to" and "I cannot make myself start"?

What makes a task startable?

What makes a task impossible?

What reduces friction: scripts, checklists, another person, deadlines, anger, evidence, music, isolation?

What increases friction: ambiguity, phone calls, forms, waiting, social risk, shame, bureaucracy?
```

Extraction targets:

```yaml
executive_friction:
  task_type:
  friction_kind:
  start_conditions:
  blocker_conditions:
  avoidance_loop:
  hyperfocus_conditions:
  supports:
  worseners:
  evidence_refs:
  confidence:
```

## Section 7: Stakes

Purpose: identify what makes a situation matter enough to change state.

Questions:

```text
What makes a situation feel high-stakes to you?

Money?
Health?
Status?
Being misunderstood?
Being disbelieved?
Being trapped?
Being humiliated?
Losing access?
Authority?
Family?
Time pressure?
Reputation?

What stakes do other people underestimate in your life?

What stakes do you overestimate when stressed?

What stakes do you pretend not to care about?

What stakes make you sharper?

What stakes make you less coherent?
```

Extraction targets:

```yaml
stakes_context:
  practical_stakes:
  social_stakes:
  identity_stakes:
  authority_stakes:
  health_stakes:
  financial_stakes:
  underestimated_by_others:
  overestimated_under_stress:
  performance_effect:
  evidence_refs:
  confidence:
```

## Section 8: Social power map

Purpose: model how the subject detects authority, gatekeeping, bad faith, and social threat.

Questions:

```text
How do you detect someone has power over you?

How do you detect bad faith?

How do you detect false neutrality?

How do you detect someone is managing you rather than talking to you?

What kind of politeness feels safe?

What kind of politeness feels threatening?

What happens when someone uses procedure to avoid substance?

What happens when someone treats your evidence as emotion?

What kinds of authority figures make you regress, mask, fight, freeze, or over-explain?
```

Extraction targets:

```yaml
social_power_pattern:
  power_cue:
  perceived_threat:
  bad_faith_markers:
  safe_politeness:
  threatening_politeness:
  authority_response_mode:
  masking_response:
  evidence_refs:
  confidence:
```

## Section 9: Contradictions

Purpose: preserve real contradictions instead of smoothing them away.

Questions:

```text
What are two true things about you that seem incompatible?

Where do you act against your stated values?

Where do you believe one thing and emotionally expect another?

Where are you brave in one domain and helpless in another?

Where do people misunderstand you because they only see one mode?

What would a bad character summary get wrong by smoothing you out?

What contradiction should HSM preserve rather than resolve?
```

Extraction targets:

```yaml
contradiction_record:
  claim_a:
  claim_b:
  context_a:
  context_b:
  apparent_conflict:
  possible_resolution:
  preserve_as_contradiction: true
  evidence_refs:
  confidence:
```

## Section 10: Memory behaviour

Purpose: distinguish stable recall, state-linked recall, body memory, and uncertain memory.

Questions:

```text
What memories are always available?

What memories only appear under stress?

What memories appear as body-state first?

What memories do you distrust?

What memories are vivid but possibly distorted?

What periods of your life feel compressed, missing, or overrepresented?

What do you remember because someone else kept records?

What do you remember because your body reacts before the story appears?

What are the signs that a memory has become active even before you can name it?
```

Extraction targets:

```yaml
memory_pattern:
  memory_cluster:
  availability:
  activation_conditions:
  body_first_signals:
  trust_level:
  distortion_risk:
  record_support:
  evidence_refs:
  confidence:
```

## Section 11: Absence and non-events

Purpose: capture what mattered because it did not happen.

Questions:

```text
What did not happen that mattered?

Who did not reply?

Who did not protect you?

Who did not notice?

Who promised action and then did nothing?

What silence changed your interpretation?

What absence became evidence?

What expected event failing to occur hurt more than an obvious attack?
```

Extraction targets:

```yaml
absence_evidence:
  expected_event:
  missing_event:
  actor:
  context:
  interpreted_meaning:
  alternate_explanations:
  confidence:
  evidence_refs:
```

## Section 12: Skill and tacit knowledge

Purpose: capture embodied and procedural competence that is not easily represented as facts.

Questions:

```text
What do you know in your hands?

What can you diagnose before you can explain it?

What can you fix by feel, timing, rhythm, sound, smell, or pattern?

What skills collapse under observation or pressure?

What skills appear only once you start moving?

What mistakes taught you the most?

What tools feel like extensions of your body?

What does confidence feel like during skilled work?

What does wrongness feel like before you know the exact fault?
```

Extraction targets:

```yaml
tacit_skill:
  domain:
  sensory_cues:
  procedural_sequence:
  confidence_signals:
  wrongness_signals:
  collapse_conditions:
  recovery_heuristics:
  evidence_refs:
  confidence:
```

## Section 13: Identity and role

Purpose: map role states, stabilising identities, armour identities, and masking.

Questions:

```text
What roles stabilise you?

What roles feel fake?

What role do you perform when threatened?

What role do you perform when helping?

What role do you perform when cornered by authority?

What identity claim would you defend even if it costs you?

What identity claim sounds true but is mostly armour?

What do you need others to understand before they can model you fairly?
```

Extraction targets:

```yaml
identity_role_state:
  role:
  stabilising_effect:
  armour_effect:
  threat_mode:
  helping_mode:
  authority_mode:
  masking_pattern:
  misunderstanding_risk:
  evidence_refs:
  confidence:
```

## Section 14: Repair and recovery

Purpose: capture how the subject returns toward baseline after conflict, overload, or destabilisation.

Questions:

```text
How do you come back after overload?

What helps in the first minute?

What helps after an hour?

What helps the next day?

What makes recovery worse?

What kinds of apologies repair trust?

What kinds of apologies make things worse?

What does real safety look like after conflict?

How do you know you are back to baseline?

What damage remains even after you seem fine?
```

Extraction targets:

```yaml
recovery_pattern:
  destabilising_event:
  first_minute_support:
  hour_scale_support:
  day_scale_support:
  worseners:
  trust_repair_conditions:
  failed_repair_conditions:
  baseline_return_signals:
  residual_damage:
  evidence_refs:
  confidence:
```

## Section 15: Self-deception and confabulation

Purpose: identify where self-report may be useful but incomplete, distorted, defensive, or post-hoc.

Questions:

```text
Where do you lie to yourself?

Where do you make noble explanations for ugly motives?

Where do you make ugly explanations for normal needs?

Where do you over-explain because the real answer is simpler?

Where do you under-explain because the real answer is humiliating?

What stories about yourself are useful but not fully true?

What do you say you want?

What do your repeated actions suggest you want?

Where do those differ?
```

Extraction targets:

```yaml
self_deception_pattern:
  stated_story:
  repeated_action_pattern:
  possible_hidden_motive:
  shame_or_defence_component:
  alternate_explanations:
  evidence_refs:
  confidence:
```

Use care here. This section is high-risk for overreach. Store outputs as hypotheses unless strongly supported.

## Section 16: Falsification

Purpose: prevent the deposition from becoming a self-sealing story.

Questions:

```text
What would prove your current explanation wrong?

What evidence would change your mind?

What would someone who dislikes you say that might still be partly true?

What would someone who loves you get wrong?

What would a therapist, friend, enemy, employer, and machine each notice differently?

What pattern would embarrass you if it appeared in the data?

What claim should HSM refuse to store unless backed by records?
```

Extraction targets:

```yaml
falsification_path:
  claim:
  disconfirming_evidence:
  alternate_observer_view:
  hostile_audit_risk:
  storage_requirement:
  evidence_needed:
  current_status:
```

## Section 17: Compression priority

Purpose: identify what must survive state compression.

Questions:

```text
If we had to compress you into 500 tokens for a model, what must not be lost?

What facts matter less than people think?

What tiny detail explains a lot?

What repeated pattern is more important than one dramatic event?

What contradiction must remain visible?

What uncertainty must remain visible?

What source should be trusted most?

What source should be treated carefully?
```

Extraction targets:

```yaml
compression_priority:
  must_preserve:
  can_drop_or_summarise:
  high_signal_details:
  repeated_patterns:
  preserve_contradictions:
  preserve_uncertainties:
  trusted_sources:
  careful_sources:
```

Compression rule:

```text
Fluff may die. Truth labels stay.
```

## Section 18: Runtime packet question

Purpose: compile state relevant to the current situation rather than the whole archive.

Questions:

```text
Right now, for someone to model you usefully in this situation, what state must they know?

Not your whole life.

This situation.

What is active?
What is dormant?
What is risky?
What is uncertain?
What would make the model get you wrong?
```

Extraction targets:

```yaml
runtime_packet_notes:
  task_context:
  active_state:
  dormant_but_relevant_state:
  current_risks:
  uncertainties:
  model_failure_risks:
  evidence_refs:
  update_instructions:
```

## Five-question emergency version

Use this when time or attention is limited:

```text
1. What changes your state before you can explain it?

2. What restores you when you are destabilised?

3. What do you repeatedly do that contradicts what you say about yourself?

4. What absences, silences, or non-events shaped you?

5. For each explanation you give, what is evidence, what is inference, and what would falsify it?
```

## Output template

After a deposition session, produce a structured note.

```yaml
session:
  subject_id:
  interviewer:
  date:
  scope:
  duration:
  safety_notes:

summary:
  short_plain_summary:
  high_signal_findings:
  contradictions_preserved:
  major_uncertainties:
  evidence_needed:

claims:
  - id:
    text:
    evidence_type:
    confidence:
    source_refs:
    contradiction_refs:
    suggested_state_update_class:

state_patterns:
  baseline_state: []
  embodied_state: []
  triggers: []
  anchors: []
  executive_friction: []
  stakes_context: []
  social_power_patterns: []
  memory_patterns: []
  absence_evidence: []
  tacit_skills: []
  identity_roles: []
  recovery_patterns: []
  self_deception_hypotheses: []
  falsification_paths: []
  compression_priorities: []

runtime_packet_candidates:
  - task_context:
    included_state:
    excluded_state:
    uncertainty_flags:
    model_failure_risks:
    evidence_refs:

review:
  what_was_checked:
  what_was_not_checked:
  possible_overreach:
  hostile_audit_notes:
  next_useful_move:
```

## Integrity gate after deposition

Before writing anything to durable HSM state, ask:

```text
Is this direct evidence, testimony, repeated pattern, inference, or hypothesis?

What source supports it?

What contradicts it?

Is the confidence appropriate?

Is the subject explaining an immediate reaction after the fact?

Has the interviewer smoothed away contradiction?

Has emotional coherence been mistaken for evidence?

Would this survive hostile audit?

Should this be stored, rejected, or kept as open uncertainty?
```

## Notes for language models conducting the deposition

A language model should remember:

- You do not know what pain feels like.
- You do not know what shame feels like.
- You do not know what hunger, fatigue, or sensory overload feel like.
- You do not carry lifelong stakes.
- You do not have a body that reacts before language.
- You can imitate empathy without sharing vulnerability.
- You can generate plausible causes that are not true causes.
- You are biased toward clean explanations.
- You may turn a human into a tidy character summary if not constrained.

Therefore:

```text
Ask for state transitions.
Ask for bodily signals.
Ask for delayed explanations.
Ask for contradictions.
Ask for absences.
Ask for falsification.
Label uncertainty.
Do not pretend testimony is evidence-backed fact.
```

## Notes for human interviewers

A human interviewer should remember:

- The subject may not know the answer immediately.
- The first answer may be a social answer.
- The second answer may be a defensive answer.
- The useful answer may arrive later.
- Contradiction may mean context dependence, not dishonesty.
- Pauses, irritation, humour, precision, and avoidance may be state signals.
- The process can be tiring.
- Stop or narrow the scope if the subject becomes destabilised.

## Final principle

Do not depose the human for a story.

Depose the human for state.

The story is one render of the state machine. It is not the machine itself.
