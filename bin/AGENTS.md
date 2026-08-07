# Python bridge guidance

These instructions apply to `bin/hass-bridge` in addition to the repository
rules.

- Keep the bridge a Python 3.11+ executable with no dependency on user or system
  site-packages. It must import `websockets` from the repository's `vendor/`
  directory.
- stdin is the only command channel and stdout is NDJSON only. Send diagnostics
  through structured events or stderr; never print non-JSON text to stdout.
- The stdin reader thread may only parse and enqueue commands. Connection and
  protocol state stays owned by the main loop.
- Every externally visible event must carry `protocolVersion` and the active
  connection generation. Disconnect the old transport before relabeling state
  with a new generation.
- Never accept a token through argv. Redact the active token from all server-
  controlled error messages before emitting or logging them.
- URL parsing must allow only `http`, `https`, `ws`, and `wss`; a missing scheme
  assumes TLS. Never turn a malformed scheme into `ws://`.
- Keep proxy discovery disabled, TLS verification enabled by default,
  compression disabled, and frame/message/queue limits finite.
- Use separate timeouts for ordinary commands and initial synchronization when
  changing timeout policy. A slow snapshot must not create a tight reconnect
  loop.
- Authentication success alone is not readiness. Reset reconnect backoff only
  after subscription and snapshot readiness.
- Treat responses as untrusted JSON: validate object/list shapes, request IDs,
  entity IDs, and error strings before forwarding them.
- Demo mode should exercise the same protocol path as a live connection and
  must stop all ticker output after disconnect.

For any bridge change, run:

```bash
PYTHONNOUSERSITE=1 PYTHONDONTWRITEBYTECODE=1 python3 tests/test_bridge.py
python3 -m py_compile bin/hass-bridge tests/*.py
```

Add a fake-server regression test for authentication, reconnect, timeout,
generation, hostile-input, or service-call behavior changes.
