#!/usr/bin/env python3
"""Offline integrity checks for vendored runtime dependencies."""

import json
import os
import subprocess
import sys


ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
VENDOR = os.path.join(ROOT, "vendor")
PACKAGE = os.path.join(VENDOR, "websockets")
BRIDGE = os.path.join(ROOT, "bin", "hass-bridge")
EXPECTED_VERSION = "17.0.1"
EXPECTED_SHA256 = "5baa9bc0dfbae8c507e51c8cf1b6d4628086f7a87bbd3a9952bd5f035451f1cc"

failures = []


def check(name, condition, detail=""):
    if condition:
        print("  ok   %s" % name)
    else:
        print("  FAIL %s %s" % (name, detail))
        failures.append(name)


def main():
    print("vendor: pinned, pure Python, licensed, and selected by the bridge")

    code = (
        "import json,runpy; "
        "data=runpy.run_path(%s, run_name='hass_bridge_test'); "
        "ws=data['websockets']; "
        "print(json.dumps({'version': ws.__version__, 'path': ws.__file__}))"
        % json.dumps(BRIDGE)
    )
    env = os.environ.copy()
    env["PYTHONNOUSERSITE"] = "1"
    env["PYTHONDONTWRITEBYTECODE"] = "1"
    result = subprocess.run(
        [sys.executable, "-I", "-B", "-c", code],
        check=False, capture_output=True, text=True, env=env,
    )
    details = {}
    try:
        details = json.loads(result.stdout.strip())
    except ValueError:
        pass

    check("bridge imports without a system package", result.returncode == 0,
          result.stderr.strip())
    check("expected version is loaded",
          details.get("version") == EXPECTED_VERSION, details)
    loaded_path = os.path.realpath(details.get("path", ""))
    check("import resolves inside vendor/websockets",
          loaded_path.startswith(os.path.realpath(PACKAGE) + os.sep), loaded_path)

    forbidden = []
    links = []
    for dirpath, dirnames, filenames in os.walk(PACKAGE):
        for name in dirnames + filenames:
            path = os.path.join(dirpath, name)
            if os.path.islink(path):
                links.append(os.path.relpath(path, ROOT))
        for name in filenames:
            if name.endswith((".so", ".pyc", ".pyo", ".c")):
                forbidden.append(os.path.relpath(os.path.join(dirpath, name), ROOT))

    check("vendored tree contains no links", links == [], links)
    check("vendored tree contains no binary, bytecode, or C artifacts",
          forbidden == [], forbidden)
    check("optional speedups extension is absent",
          not os.path.exists(os.path.join(PACKAGE, "speedups.c")))

    metadata = open(os.path.join(VENDOR, "README.md"), encoding="utf-8").read()
    updater = open(os.path.join(ROOT, "scripts", "update-websockets-vendor"),
                   encoding="utf-8").read()
    notice = open(os.path.join(ROOT, "THIRD_PARTY_NOTICES.md"),
                  encoding="utf-8").read()
    license_text = open(os.path.join(VENDOR, "LICENSE.websockets"),
                        encoding="utf-8").read()

    check("source archive checksum is documented",
          EXPECTED_SHA256 in metadata and EXPECTED_SHA256 in updater)
    check("version is consistent in metadata and updater",
          EXPECTED_VERSION in metadata and EXPECTED_VERSION in updater)
    check("third-party notice names the BSD license",
          "BSD-3-Clause" in notice)
    check("upstream license text is present",
          "Redistribution and use in source and binary forms" in license_text)

    print()
    if failures:
        print("FAILED: %s" % ", ".join(failures))
        return 1
    print("all vendor checks passed")
    return 0


if __name__ == "__main__":
    sys.exit(main())
