#!/usr/bin/env python3
import argparse
from pathlib import Path
from scripts.portfolio._util import load_config, ensure_parent


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
        "This index maps screenshots to a short description and their location.",
        "",
    ]
    if screenshots.exists():
        for p in sorted(screenshots.glob("*")):
            if p.suffix.lower() in {".png", ".jpg", ".jpeg"}:
                name = p.name
                lines.append(f"- {name} — Evidence screenshot (see `screenshots/{name}`)")
    else:
        lines.append("_No screenshots directory found._")

    ensure_parent(out)
    out.write_text("\n".join(lines) + "\n", encoding="utf-8")


if __name__ == "__main__":
    main()

