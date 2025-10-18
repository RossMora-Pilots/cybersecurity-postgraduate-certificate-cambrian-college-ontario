#!/usr/bin/env bash
set -euo pipefail

# Portfolio automation runner
# Usage: scripts/portfolio/run.sh <immediate|short|followup|polish|all>

HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$HERE/../.." && pwd)"
CONFIG="$ROOT/portfolio/config.yaml"

phase="${1:-}"
if [[ -z "${phase}" ]]; then
  echo "Usage: $0 <immediate|short|followup|polish|all>" >&2
  exit 2
fi

python_bin="python3"
if ! command -v "$python_bin" >/dev/null 2>&1; then
  echo "python3 not found in PATH" >&2
  exit 2
fi

run_immediate() {
  "$python_bin" "$ROOT/scripts/portfolio/update_main_readme.py" --root "$ROOT" --config "$CONFIG"
  "$python_bin" "$ROOT/scripts/portfolio/index_assignments.py" --root "$ROOT" --config "$CONFIG"
}

run_short() {
  "$python_bin" "$ROOT/scripts/portfolio/create_midterm_summary.py" --root "$ROOT" --config "$CONFIG"
  "$python_bin" "$ROOT/scripts/portfolio/create_final_assessment.py" --root "$ROOT" --config "$CONFIG"
}

run_followup() {
  "$python_bin" "$ROOT/scripts/portfolio/build_evidence_index.py" --root "$ROOT" --config "$CONFIG"
  "$python_bin" "$ROOT/scripts/portfolio/build_scripts_readme.py" --root "$ROOT" --config "$CONFIG"
}

run_polish() {
  "$python_bin" "$ROOT/scripts/portfolio/create_weeks_summary.py" --root "$ROOT" --config "$CONFIG" || true
  "$python_bin" "$ROOT/scripts/portfolio/add_references.py" --root "$ROOT" --config "$CONFIG" || true
  # CI and repo metadata are optional and skipped if tools are missing
}

case "$phase" in
  immediate) run_immediate ;;
  short) run_short ;;
  followup) run_followup ;;
  polish) run_polish ;;
  all)
    run_immediate
    run_short
    run_followup
    run_polish || true
    ;;
  *) echo "Unknown phase: $phase" >&2; exit 2 ;;
esac

# Optional commit/push if requested
if [[ "${PM_COMMIT:-1}" != "0" ]]; then
  cd "$ROOT"
  if ! git diff --quiet; then
    git add -A
    msg="docs(portfolio): automated updates for phase '$phase'"
    git -c user.email="codex-bot@local" -c user.name="Codex Bot" commit -m "$msg" || true
    if [[ "${PM_PUSH:-0}" == "1" ]]; then
      git push origin "${PORTFOLIO_BRANCH:-main}" || true
    fi
  fi
fi

echo "Phase '$phase' completed."

