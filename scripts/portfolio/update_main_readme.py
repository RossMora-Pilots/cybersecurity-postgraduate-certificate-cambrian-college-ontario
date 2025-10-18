#!/usr/bin/env python3
import argparse
from pathlib import Path
from scripts.portfolio._util import load_config, insert_or_replace_block, ensure_parent


def build_quick_start(course_path: str) -> str:
    return f"""
🚀 QUICK START FOR HIRING MANAGERS

If you have 5 minutes:
→ Read: Key Achievements (below)
→ View: 2–3 screenshots in `{course_path}/screenshots/`

If you have 15 minutes:
→ Explore: Midterm and Final writeups in `{course_path}`
→ Review: Scripts in `{course_path}/scripts/`

If you have 30 minutes:
→ Deep dive: Weeks 4–7 hardening, Week 10–12 SIEM/vuln work
""".strip()


def build_achievements(cfg: dict) -> str:
    m = cfg.get("metrics", {})
    lines = [
        "**Quantified Results:**",
        "",
        f"• Course Grade: {m.get('grade','N/A')}/100",
        f"• Vulnerability Remediation Rate: {m.get('remediation_rate','N/A')}%",
        f"• Systems Hardened: {m.get('systems_hardened','N/A')} VMs",
        f"• GPO Policies Configured: {m.get('gpo_count','N/A')}+",
        "",
        "Tools: Nessus, Nmap, Wazuh, AD/GPO, OPNsense, Bash, PowerShell",
    ]
    return "\n".join(lines)


def build_navigation(course_path: str) -> str:
    return f"""
📁 How to Review This Portfolio

Network Defense Course → `{course_path}`
• Start Here: `{course_path}/README.md`
• Assignments: `{course_path}/assignments/` (PDFs)
• Scripts: `{course_path}/scripts/` and `scripts-extra/`
• Evidence: `{course_path}/screenshots/`
""".strip()


def build_skills(cfg: dict) -> str:
    skills = cfg.get("skills", [])
    if not skills:
        skills = [
            "Network Security", "Active Directory/GPO", "Vulnerability Management",
            "SIEM (Wazuh)", "Bash", "PowerShell",
        ]
    return "\n".join(f"- {s}" for s in skills)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--root", required=True)
    ap.add_argument("--config", required=True)
    args = ap.parse_args()

    root = Path(args.root)
    cfg = load_config(Path(args.config))
    course_path = cfg.get("course_path", "CC/September 2024/Network Defense - Travis Czech - CSC-7303-002 - 93536")

    readme = root / "README.md"
    if not readme.exists():
        ensure_parent(readme)
        readme.write_text("# Cybersecurity Portfolio\n\n", encoding="utf-8")

    text = readme.read_text(encoding="utf-8")

    sections = [
        ("<!-- PORTFOLIO: QUICK_START START -->", "<!-- PORTFOLIO: QUICK_START END -->", build_quick_start(course_path)),
        ("<!-- PORTFOLIO: ACHIEVEMENTS START -->", "<!-- PORTFOLIO: ACHIEVEMENTS END -->", build_achievements(cfg)),
        ("<!-- PORTFOLIO: NAVIGATION START -->", "<!-- PORTFOLIO: NAVIGATION END -->", build_navigation(course_path)),
        ("<!-- PORTFOLIO: SKILLS START -->", "<!-- PORTFOLIO: SKILLS END -->", build_skills(cfg)),
    ]

    changed = False
    for start, end, body in sections:
        text, c = insert_or_replace_block(text, start, end, body)
        changed = changed or c

    if changed:
        readme.write_text(text, encoding="utf-8")


if __name__ == "__main__":
    main()

