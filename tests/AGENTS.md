# Test guidance

Tests are intentionally runnable on a clean checkout without pytest, npm
packages, a real Home Assistant, or network access.

- Python tests use the standard library and executable test modules. JavaScript
  tests run directly with Node and load production QML-library JavaScript after
  removing `.pragma library`.
- Use `FakeHA` for WebSocket integration behavior. Never use real URLs, tokens,
  keyrings, or user configuration in tests.
- Always terminate helper processes and fake servers in `finally` blocks.
- Prefer observable behavioral assertions over matching source text. Contract
  string checks are acceptable only for invariants that cannot reasonably be
  exercised without a Quickshell runtime.
- Security regressions should prove both the unsafe input and the safe outcome:
  no token in output, no plaintext fallback, bounded memory/input handling,
  correct generation, or bounded retry rate.
- Timing tests need generous outer budgets but should assert rate limits or
  state transitions precisely enough to catch reconnect storms and deadlocks.
- Keep TLS fixtures test-only. Do not replace them with production credentials
  or externally issued certificates.
- Keep bridge tests isolated from global packages with `PYTHONNOUSERSITE=1` and
  avoid creating bytecode with `PYTHONDONTWRITEBYTECODE=1`.

When production behavior changes, update the smallest relevant test first, then
run the complete command list from the root `AGENTS.md` before handoff.
