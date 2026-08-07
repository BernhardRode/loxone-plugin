# QML control guidance

These instructions apply to domain controls under `controls/`.

- Controls receive `hass`, `entityId`, and the current entity. Keep Home
  Assistant protocol details out of these components and call the typed methods
  exposed by `Service.qml`.
- Derive visibility and interactivity from `Model.capabilitiesFor(entity)`.
  Unsupported or unavailable controls must not send a command.
- Keep slider state local while dragging and commit once on release. Clamp and
  validate numeric values again in the service/model layer.
- Do not optimistically invent capabilities from a currently non-null
  attribute when Home Assistant exposes a supported-feature flag.
- Use `Style`, `Color`, and bar-provided colors/fonts. Every raw `Text` must use
  `Text.PlainText` and an explicit font family.
- Keep controls reusable and free of connection, credential, persistence, and
  IPC concerns.

Run `python3 tests/test_qml_style.py`, `node tests/test_model.js`, and QML parser
checks after changing controls.
