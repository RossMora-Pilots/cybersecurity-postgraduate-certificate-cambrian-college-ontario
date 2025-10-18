import json
from pathlib import Path
from typing import Tuple


def load_config(path: Path) -> dict:
    # YAML subset: store JSON in .yaml file for zero-deps parsing
    data = json.loads(path.read_text(encoding="utf-8"))
    return data


def insert_or_replace_block(text: str, start_marker: str, end_marker: str, body: str) -> Tuple[str, bool]:
    changed = False
    if start_marker in text and end_marker in text:
        pre, rest = text.split(start_marker, 1)
        _, post = rest.split(end_marker, 1)
        new_text = pre + start_marker + "\n" + body.rstrip() + "\n" + end_marker + post
        if new_text != text:
            changed = True
        return new_text, changed
    else:
        new_text = text.rstrip() + "\n\n" + start_marker + "\n" + body.rstrip() + "\n" + end_marker + "\n"
        return new_text, True


def ensure_parent(p: Path):
    p.parent.mkdir(parents=True, exist_ok=True)

