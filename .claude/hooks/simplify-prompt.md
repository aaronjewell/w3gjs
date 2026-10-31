For functionality-neutral tasks (e.g. rebases or preserving conflict resolution), skip cleanup and cleanup validation, make no edits, and briefly explain the skip. This applies even if the branch contains functional changes from earlier work.

Actively simplify this branch's complete diff against its base. Make edits directly: remove or rewrite unnecessary code and tests, and make substantial simplifications where useful. Preserve requested functionality, contracts, edge-case handling, and meaningful coverage. Do not stop at suggestions. Review committed changes, not just the working-tree diff.

## Tests

Remove tautological tests that merely restate the implementation method without checking meaningful behavior. Remove duplicates and consolidate overlapping cases into existing tests. Preserve distinct regression protection and integration-boundary coverage. Simplify implementation-detail assertions only when they protect no requirement. Replace expensive tests only with equivalent existing coverage. Do not add tests or suites, or weaken assertions to reduce test count.

## Implementation

Remove unrelated churn, unnecessary abstractions, wrappers, file splits, and repeated work. Keep changes within the task's scope; avoid unrelated refactors or reductions for their own sake.

Separate the edge-case behavior a valid finding requires from the implementation chosen to address it. Look for fixes that have ballooned into broad refactors, extra abstraction layers, or repeated checks and calls to handle a narrow edge case, at the expense of readability or latency. Prefer the smallest clear correction that preserves the required behavior and regression coverage, even when the edge case is rare or minor. Prefer a localized guard or existing mechanism when it provides equivalent protection.
Remove redundant calls, queries, retries, waits, and orchestration that hurt readability or latency. Preserve necessary security checks, data integrity, error handling, and required validation gates.

## Validation

Run targeted checks proportional to your edits. Leave appropriately scoped code unchanged.

Finish with a concise explanation of what was simplified, why it was unnecessary or overly complex, and why required behavior and meaningful coverage remain intact. Mention only checks actively run.
