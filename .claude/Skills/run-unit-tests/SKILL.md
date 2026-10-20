---
name: run-unit-tests
description: Run a specified set of unit tests and report failures in full. Use when the user asks to run, execute, or re-run unit tests (XUnit), check whether unit tests pass, or diagnose unit-test failures. Triggers include "run the unit tests", "run unit tests for a given class or method", "why are the unit tests failing", "check unit test status".
allowed-tools: Bash, Read, Glob, Grep
---

# Run Unit Tests

Run the unit tests the user specifies, then report every failure with enough detail to
act on it immediately. Do not fix code unless the user asks — the job is to run and report.

Unit tests are single-function, compile-time tests (XUnit) covering input validation and
business-logic rules. They have no live dependencies and should run fast, so a full run is
usually cheap.

## Scope

- Run the tests the user names (a project, a test class, a method, or a filter).
- If the user does not specify, offer to run the whole unit-test project — unlike
  integration tests this is low-cost, so confirm rather than block.
- Unit tests must not touch live dependencies. If a "unit" test needs a database, network,
  or filesystem to pass, flag it as miscategorized rather than treating it as a unit test.

## Steps

1. **Locate the tests.** Use `Glob`/`Grep` to find the XUnit project or the class/method
   the user named before running anything.

2. **Run the specified tests** with a filter scoped to what the user asked for. Examples
   (adjust to the actual project):
   ```bash
   # Whole unit-test project
   dotnet test path/to/UnitTests.csproj

   # Filtered to a class or method
   dotnet test --filter "FullyQualifiedName~{ClassOrMethodName}"

   # Filtered by trait
   dotnet test --filter "Category=Unit"
   ```
   Write any large or temporary output to `~/tmp` rather than the repo.

3. **Parse the results.** Capture pass/fail/skip counts and the full failure detail
   (assertion message, expected vs actual, stack trace, and source location) per failure.

## Report format

Lead with a one-line summary (totals: passed / failed / skipped). Then list **all
failures** as a numbered checklist, **grouped by test class / category**. For each failure
include:

1. **Test name + file and line** where the failure occurs (e.g. `PriceCalculatorTests.cs:88`).
2. **Cause** — the actual assertion or exception (expected vs actual), not just "it failed".
3. **Recommended fix.**

If there are zero failures, say so plainly with the totals. Never report success without
the run output backing it up; if a run errored or was skipped before completing, say so.
