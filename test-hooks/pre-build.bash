#!/usr/bin/env bash
set -euo pipefail
errors=0
assert_set() { if [[ -z "${!1:-}" ]]; then echo "FAIL: $1 should be set" >&2; errors=$((errors + 1)); fi; }
assert_not_set() { if [[ -n "${!1:-}" ]]; then echo "FAIL: $1 should NOT be set (got '${!1}')" >&2; errors=$((errors + 1)); fi; }
assert_set REPOSITORY_NAME
assert_set PROJECT_NAME
assert_set CURRENT_BRANCH
assert_not_set VERSION
assert_not_set DOCKER_TAG
if [[ "$errors" -gt 0 ]]; then echo "FAILED: $errors assertion(s) in preBuild" >&2; exit 1; fi
echo "PASSED: preBuild validation"
