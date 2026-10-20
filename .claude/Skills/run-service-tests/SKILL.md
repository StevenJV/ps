---
name: run-service-tests
description: Run a specified set of service tests and report failures in full. Use when the user asks to run, execute, or re-run service tests, check whether service tests pass, or diagnose service-test failures. Triggers include "run the service tests", "run service tests for a given service or contract", "why are the service tests failing", "check service test status", "did my service change break the contract".
allowed-tools: Bash, Read, Glob, Grep
---

# Run Service Tests

Run the service tests the user specifies, then report every failure with enough detail to
act on it immediately. Do not fix code unless the user asks — the job is to run and report.

Service tests exercise a single service at runtime through its public interface (API or UI)
with dependencies mocked. They validate business logic plus the contract: given input X the
service returns output Y. They help pinpoint whether a recent service change is the cause of
downstream integration failures.

## Scope

- Run the tests the user names (a service, a controller/endpoint, or a contract suite).
- If the user does not specify which tests, ask before running the full service suite.
- Dependencies should be mocked. If a "service" test requires a live database or a real
  downstream service to pass, flag it as miscategorized (it is behaving as an integration
  test) rather than treating it as a service test.

## Steps

1. **Locate the tests.** Use `Glob`/`Grep` to find the service-test project or the suite
   that owns the named service/endpoint before running anything. In these repos service
   tests follow the LogCom automation framework in C#/.NET.

2. **Run the specified tests** with a filter scoped to what the user asked for. Examples
   (adjust to the actual project):
   ```bash
   # Filtered to a service or endpoint
   dotnet test --filter "FullyQualifiedName~{ServiceOrEndpointName}"

   # Filtered by trait/category
   dotnet test --filter "Category=Service"
   ```
   Write any large or temporary output to `~/tmp` rather than the repo.

3. **Parse the results.** Capture pass/fail/skip counts and the full failure detail
   (assertion message, expected vs actual response, status codes, and source location) per
   failure. For contract failures, show the expected vs actual request/response shape.

## Report format

Lead with a one-line summary (totals: passed / failed / skipped, and the service under
test). Then list **all failures** as a numbered checklist, **grouped by service / contract
suite**. For each failure include:

1. **Test name + file and line** where the failure occurs (e.g. `QuoteServiceTests.cs:57`).
2. **Cause** — the actual assertion or contract mismatch (expected vs actual response),
   not just "it failed".
3. **Recommended fix.**

If there are zero failures, say so plainly with the totals. Never report success without
the run output backing it up; if a run errored or was skipped before completing, say so.
