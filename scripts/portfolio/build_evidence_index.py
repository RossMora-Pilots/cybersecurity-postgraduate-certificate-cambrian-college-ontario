#!/usr/bin/env python3
import argparse
import re
from collections import defaultdict
from pathlib import Path
from scripts.portfolio._util import load_config, ensure_parent


def humanize_topic(topic: str) -> str:
    t = topic.replace('_', ' ').replace('-', ' ').strip()
    return t.capitalize()


def group_screenshots(screenshots_dir: Path):
    groups = defaultdict(list)
    if not screenshots_dir.exists():
        return groups
    pat = re.compile(r"^wk(\d+)_([a-z0-9\-]+)_", re.IGNORECASE)
    for p in sorted(screenshots_dir.glob('*')):
        if not p.is_file() or p.suffix.lower() not in {'.png', '.jpg', '.jpeg'}:
            continue
        name = p.name
        m = pat.match(name)
        if m:
            week = m.group(1)
            topic = humanize_topic(m.group(2))
            key = f"Week {week} — {topic}"
        elif name.lower().startswith('screenshot'):
            key = 'General — Screenshots'
        else:
            key = 'Miscellaneous'
        groups[key].append(name)
    return groups


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--root", required=True)
    ap.add_argument("--config", required=True)
    args = ap.parse_args()

    root = Path(args.root)
    cfg = load_config(Path(args.config))
    course_path = cfg.get("course_path")
    screenshots = root / course_path / "screenshots"
    out = root / course_path / "EVIDENCE_INDEX.md"

    lines = [
        "# Evidence & Screenshots Index",
        "",
        "This guide groups screenshots by week/topic and points to their location.",
        "",
    ]

    groups = group_screenshots(screenshots)
    if not groups:
        lines.append("_No screenshots directory found._")
    else:
        for section in sorted(groups.keys(), key=lambda s: (s.startswith('Misc'), s)):
            lines.append(f"## {section}")
            for name in groups[section]:
                lines.append(f"- {name} — see `screenshots/{name}`")
            lines.append("")

    ensure_parent(out)
    out.write_text("\n".join(lines) + "\n", encoding="utf-8")


if __name__ == "__main__":
    main()
