# Vendored dependency guidance

The `vendor/websockets` tree is upstream source, not application code.

- Do not patch files under `vendor/websockets` directly.
- Update the dependency only through `scripts/update-websockets-vendor` after
  intentionally changing its pinned version, source URL, and SHA-256.
- Review upstream release notes and security advisories before changing the
  pin. Preserve the pure-Python, offline-import design.
- Keep provenance, omitted-file notes, version, hash, and license synchronized
  in `vendor/README.md`, `THIRD_PARTY_NOTICES.md`, and
  `vendor/LICENSE.websockets`.
- Do not add symlinks, bytecode, native binaries, generated artifacts, upstream
  tests, or undeclared packages to the vendored tree.

After any vendor update, run:

```bash
python3 tests/test_vendor.py
PYTHONNOUSERSITE=1 PYTHONDONTWRITEBYTECODE=1 python3 tests/test_bridge.py
bash -n scripts/update-websockets-vendor
```
