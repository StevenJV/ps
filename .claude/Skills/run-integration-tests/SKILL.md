---
name: run-integration-tests
description: Run a specified set of integration tests and report failures in full. Use when the user asks to run, execute, or re-run integration tests (Playwright or .NET), check whether integration tests pass, or diagnose integration-test failures. Triggers include "run the integration tests", "run integration tests for a given endpoint or suite", "why are the integration tests failing", "check integration test status".
allowed-tools: Bash, Read, Glob, Grep
---

# Run Integration Tests

Run the integration tests the user specifies, then report every failure with enough
detail to act on it immediately. Do not fix code unless the user asks — the job is to
run and report.

## Scope

- Run **only** the tests the user names (a suite, a file, an endpoint, or a filter).
- If the user does not specify which tests, ask before running the full suite — full
  integration runs are slow and hit live dependencies.
- Integration tests may run against Local, Docker, Dev, or Staging. If the target
  environment is ambiguous, ask which one before running.

## Steps

1. **Locate the tests.** Identify the test project/framework in use:
   - Playwright (TypeScript or C#/.NET) or `dotnet test` integration projects are the
     common cases in these repos.
   - Use `Glob`/`Grep` to find the matching test files or the project that owns the
     named endpoint before running anything.

2. **Run the specified tests** with the appropriate runner and a filter scoped to what
   the user asked for. Examples (adjust to the actual project):
   ```bash
   # .NET, filtered
   dotnet test --filter "FullyQualifiedName~{Suite or TestName}"

   # Playwright (TypeScript)
   npx playwright test {path-or-grep}

   # Playwright (.NET)
   dotnet test --filter "Category=Integration&FullyQualifiedName~{Name}"
   ```
   Write any large or temporary output to `~/tmp` rather than the repo.

3. **Parse the results.** Capture pass/fail counts and the full failure detail
   (message, assertion, stack trace, and the source location) for each failing test.

## Report format

Lead with a one-line summary (totals: passed / failed / skipped, and the environment).
Then list **all failures** as a numbered checklist, **grouped by test category / suite**.
For each failure include:

1. **Test name + file and line** where the failure occurs (e.g. `LoginTests.cs:42`).
2. **Cause** of the failure — the actual assertion or error, not just "it failed".
3. **Recommended fix.**

If there are zero failures, say so plainly and give the totals. Never report success
without the run output backing it up; if a run was skipped or errored before completing,
say that explicitly.
