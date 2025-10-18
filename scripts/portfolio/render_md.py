#!/usr/bin/env python3
import csv, sys
from pathlib import Path

def main():
    root = Path(__file__).resolve().parents[2]
    csv_path = root / 'portfolio' / 'projects.csv'
    out_path = root / 'docs' / 'Portfolio.md'
    rows = []
    with csv_path.open(newline='', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for r in reader:
            rows.append(r)
    rows.sort(key=lambda r: int(r['id']))
    out_path.parent.mkdir(parents=True, exist_ok=True)
    with out_path.open('w', encoding='utf-8') as out:
        out.write('# Pilot Projects Portfolio\n\n')
        out.write('| ID | Code | Name | Roadmap | Issues | Local Path | Repo |\n')
        out.write('|---:|:-----|:-----|:--------|:-------|:-----------|:-----|\n')
        for r in rows:
            rid = r['id']
            code = r['code']
            name = r['name']
            repo = r['repo']
            local = r['local_path']
            roadmap = r['roadmap_path']
            issues = r['issues_url']
            out.write(f"| {rid} | {code} | {name} | [ROADMAP]({roadmap}) | [Issues]({issues}) | `{local}` | [repo]({repo}) |\n")
    print(f"PORTFOLIO_MD:OK:{out_path}")

if __name__ == '__main__':
    main()

