# Emerging Techniques Assessment — AI-Driven Fuzzing

An LLM-assisted fuzz harness was used to generate semantically valid-but-malicious request bodies against the GraphQL schema (introspection enabled — **F-15**), outperforming pure mutation-based fuzzing on business-logic abuse cases (negative-quantity order mutation, cross-tenant object references).

```python
# Harness pattern (simplified) — LLM proposes schema-aware mutations, harness replays + scores responses
for field in graphql_schema.mutations:
    candidate_payloads = llm_propose_edge_cases(field)   # e.g. negative qty, oversized string, type confusion
    for payload in candidate_payloads:
        resp = send_graphql(field, payload)
        score_anomaly(resp)  # 500 errors, auth bypass, data leakage signatures
```

## Finding

**F-16** — AI-assisted fuzzing surfaced a business-logic flaw (negative order quantity → account credit) that 40+ hours of manual testing in the legacy baseline methodology had not covered.

## Detection Logic

```yaml
title: GraphQL Business-Logic Abuse (Negative Quantity Mutation)
logsource: {category: webserver}
detection:
  selection:
    url|contains: '/graphql'
    body|contains: '"quantity":-'
  condition: selection
level: high
```
