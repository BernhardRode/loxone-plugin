# Changelog

## [0.3.0](https://github.com/BernhardRode/dev.ebbo.loxone/compare/dev.ebbo.loxone-v0.2.1...dev.ebbo.loxone-v0.3.0) (2026-08-23)


### ⚠ BREAKING CHANGES

* the plugin now targets a Loxone Miniserver instead of Home Assistant. The plugin id changed from `hass` to `loxone`, IPC commands moved from `omarchy-shell hass ...` to `omarchy-shell loxone ...`, and `bin/hass-bridge` was replaced by `bin/loxone-bridge` with a different NDJSON protocol and entity id scheme. Existing Home Assistant configuration and entity ids are not compatible.

### Features

* add area grouping setting ([125092c](https://github.com/BernhardRode/dev.ebbo.loxone/commit/125092c353e8edc37b26b900c0bb78b7c2ac4005))
* add on/off controls for climate entities ([20fcf6c](https://github.com/BernhardRode/dev.ebbo.loxone/commit/20fcf6c6a58a90f36f3967a96db0a6787d198ba9)), closes [#1](https://github.com/BernhardRode/dev.ebbo.loxone/issues/1)
* convert plugin from Home Assistant to Loxone Miniserver ([5f2feb4](https://github.com/BernhardRode/dev.ebbo.loxone/commit/5f2feb456ed2592ce6dc6522650bd08fc8ea9f54))
* initial Home Assistant panel for Omarchy ([f7a9c75](https://github.com/BernhardRode/dev.ebbo.loxone/commit/f7a9c75ae7aa41eeb9643fa172f1bef21e59d0bd))


### Bug Fixes

* **bridge:** backoff + pubkey caching for LivePushThread reconnects ([bbfe41d](https://github.com/BernhardRode/dev.ebbo.loxone/commit/bbfe41dbe1003e01b933477c7a320968d00cee05))
* **bridge:** cache LivePushThread's RSA public key across reconnects ([925683b](https://github.com/BernhardRode/dev.ebbo.loxone/commit/925683bee7b8c340af95adab855ea015a08c5366))
* **bridge:** exponential backoff + jitter on LivePushThread reconnects ([cae9eed](https://github.com/BernhardRode/dev.ebbo.loxone/commit/cae9eed02d9e4819be1c53cccece380ebf1b1f71))

## [0.2.1](https://github.com/BernhardRode/loxone-plugin/compare/loxone-v0.2.0...loxone-v0.2.1) (2026-08-19)


### Bug Fixes

* **bridge:** backoff + pubkey caching for LivePushThread reconnects ([bbfe41d](https://github.com/BernhardRode/loxone-plugin/commit/bbfe41dbe1003e01b933477c7a320968d00cee05))
* **bridge:** cache LivePushThread's RSA public key across reconnects ([925683b](https://github.com/BernhardRode/loxone-plugin/commit/925683bee7b8c340af95adab855ea015a08c5366))
* **bridge:** exponential backoff + jitter on LivePushThread reconnects ([cae9eed](https://github.com/BernhardRode/loxone-plugin/commit/cae9eed02d9e4819be1c53cccece380ebf1b1f71))

## [0.2.0](https://github.com/BernhardRode/loxone-plugin/compare/loxone-v0.1.0...loxone-v0.2.0) (2026-08-17)


### ⚠ BREAKING CHANGES

* the plugin now targets a Loxone Miniserver instead of Home Assistant. The plugin id changed from `hass` to `loxone`, IPC commands moved from `omarchy-shell hass ...` to `omarchy-shell loxone ...`, and `bin/hass-bridge` was replaced by `bin/loxone-bridge` with a different NDJSON protocol and entity id scheme. Existing Home Assistant configuration and entity ids are not compatible.

### Features

* add area grouping setting ([125092c](https://github.com/BernhardRode/loxone-plugin/commit/125092c353e8edc37b26b900c0bb78b7c2ac4005))
* add on/off controls for climate entities ([20fcf6c](https://github.com/BernhardRode/loxone-plugin/commit/20fcf6c6a58a90f36f3967a96db0a6787d198ba9)), closes [#1](https://github.com/BernhardRode/loxone-plugin/issues/1)
* convert plugin from Home Assistant to Loxone Miniserver ([5f2feb4](https://github.com/BernhardRode/loxone-plugin/commit/5f2feb456ed2592ce6dc6522650bd08fc8ea9f54))
* initial Home Assistant panel for Omarchy ([f7a9c75](https://github.com/BernhardRode/loxone-plugin/commit/f7a9c75ae7aa41eeb9643fa172f1bef21e59d0bd))
