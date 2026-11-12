#!/usr/bin/env python3
"""Validate the OKF bundle under ``semantics/``.

Checks the v0.2 conformance rules that matter for this project:
- every non-reserved ``.md`` file has parseable YAML frontmatter with a non-empty ``type``;
- internal markdown links resolve to an existing file;
- reserved filenames (``index.md``, ``log.md``) are only used for indexes/logs.

Usage:
    python scripts/validate_okf.py
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

import yaml

ROOT = Path(__file__).resolve().parents[1]
BUNDLE = ROOT / "semantics"
SKIP = {"index.md", "log.md"}
LINK_RE = re.compile(r"\[[^\]]*\]\(([^)]+)\)")


def split_frontmatter(text: str) -> tuple[dict | None, str]:
    match = re.match(r"^---\n(.*?)\n---\n?", text, re.S)
    if not match:
        return None, text
    try:
        data = yaml.safe_load(match.group(1))
    except yaml.YAMLError:
        return None, text
    return (data if isinstance(data, dict) else None), text[match.end() :]


def validate() -> list[str]:
    errors: list[str] = []
    if not BUNDLE.is_dir():
        return [f"bundle not found: {BUNDLE}"]

    for path in sorted(BUNDLE.rglob("*.md")):
        rel = path.relative_to(ROOT)
        if path.name in SKIP:
            continue
        data, body = split_frontmatter(path.read_text())
        if data is None:
            errors.append(f"{rel}: missing or unparseable YAML frontmatter")
            continue
        if not str(data.get("type") or "").strip():
            errors.append(f"{rel}: frontmatter has no non-empty 'type'")

        for target in LINK_RE.findall(body):
            target = target.split("#", 1)[0].strip()
            if not target or target.startswith(("http://", "https://", "mailto:")):
                continue
            resolved = (BUNDLE / target[1:]) if target.startswith("/") else (path.parent / target)
            if not resolved.resolve().exists():
                errors.append(f"{rel}: broken link -> {target}")

    index = BUNDLE / "index.md"
    if index.is_file():
        data, _ = split_frontmatter(index.read_text())
        if data and str(data.get("okf_version", "")).strip() not in ("", "0.2"):
            errors.append(f"semantics/index.md: unsupported okf_version {data.get('okf_version')!r}")

    return errors


def main() -> None:
    errors = validate()
    metrics = len([p for p in (BUNDLE / "metrics").glob("*.md") if p.name != "index.md"]) if (BUNDLE / "metrics").is_dir() else 0
    dimensions = len([p for p in (BUNDLE / "dimensions").glob("*.md") if p.name != "index.md"]) if (BUNDLE / "dimensions").is_dir() else 0
    if errors:
        print(f"OKF validation failed ({len(errors)} error(s)):")
        for error in errors:
            print(f"  - {error}")
        sys.exit(1)
    print(f"OKF bundle valid: {metrics} metrics, {dimensions} dimensions (index.md + log.md present)")


if __name__ == "__main__":
    main()
