#!/usr/bin/env python3
import argparse
from pathlib import Path
from scripts.portfolio._util import load_config, ensure_parent


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--root", required=True)
    ap.add_argument("--config", required=True)
    ap.add_argument("--force", action="store_true")
    args = ap.parse_args()

    root = Path(args.root)
    cfg = load_config(Path(args.config))
    course_path = cfg.get("course_path")
    out = root / course_path / "FINAL_EXAM_VULNERABILITY_ASSESSMENT.md"
    if out.exists() and not args.force:
        return

    tpl = (root / "templates" / "FINAL_EXAM_VULNERABILITY_ASSESSMENT.md.tpl").read_text(encoding="utf-8")
    metrics = cfg.get("metrics", {})
    content = tpl.replace("{{REMEDIATION_RATE}}", str(metrics.get("remediation_rate", "N/A")))
    ensure_parent(out)
    out.write_text(content, encoding="utf-8")


if __name__ == "__main__":
    main()

