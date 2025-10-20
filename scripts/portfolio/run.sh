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
  # Rebuild docs with refined grouping/metadata
  "$python_bin" "$ROOT/scripts/portfolio/build_evidence_index.py" --root "$ROOT" --config "$CONFIG" || true
  "$python_bin" "$ROOT/scripts/portfolio/build_scripts_readme.py" --root "$ROOT" --config "$CONFIG" || true
  # Add CI workflow if missing
  wf="$ROOT/.github/workflows/portfolio-ci.yml"
  mkdir -p "$(dirname "$wf")"
  if [[ ! -f "$wf" ]]; then
    cat > "$wf" <<'YML'
name: Portfolio CI
on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]
jobs:
  link-check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Link Checker
        uses: lycheeverse/lychee-action@v1
        with:
          args: --no-progress --exclude-mail --accept 200,206 --verbose '**/*.md'
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
  shellcheck:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: ShellCheck
        uses: ludeeus/action-shellcheck@master
        with:
          scandir: |
            CC/September 2024/Network Defense - Travis Czech - CSC-7303-002 - 93536/scripts
            CC/September 2024/Network Defense - Travis Czech - CSC-7303-002 - 93536/scripts-extra
YML
  fi
}

run_enhance() {
  "$python_bin" "$ROOT/scripts/portfolio/add_architecture_diagrams.py" --root "$ROOT" --config "$CONFIG" || true
  "$python_bin" "$ROOT/scripts/portfolio/add_learning_reflection.py" --root "$ROOT" --config "$CONFIG" || true
  "$python_bin" "$ROOT/scripts/portfolio/add_root_highlights.py" --root "$ROOT" || true
  "$python_bin" "$ROOT/scripts/portfolio/build_evidence_index.py" --root "$ROOT" --config "$CONFIG" || true
}

case "$phase" in
  immediate) run_immediate ;;
  short) run_short ;;
  followup) run_followup ;;
  polish) run_polish ;;
  enhance) run_enhance ;;
  all)
    run_immediate
    run_short
    run_followup
    run_polish || true
    run_enhance || true
    ;;
  *) echo "Unknown phase: $phase" >&2; exit 2 ;;
esac

# Optional commit/push if requested
if [[ "${PM_COMMIT:-1}" != "0" ]]; then
  cd "$ROOT"
  if ! git diff --quiet; then
    git add -A
    # Compose a more descriptive commit message by phase
    case "$phase" in
      immediate)
        msg_subject="docs(root,course): add Quick Start/Achievements/Navigation/Skills; regenerate assignments index"
        msg_body="Why: Improve recruiter-first scan and navigability.\nPhase: immediate"
        ;;
      short)
        msg_subject="docs(course): add Midterm + Final writeups with metrics and evidence links"
        msg_body="Why: Surface quantified results (grade, remediation) and capstone depth.\nPhase: short"
        ;;
      followup)
        msg_subject="docs(course): add Evidence Index + Scripts README with usage; validate scripts"
        msg_body="Why: Provide context for evidence and executable scripts with usage.\nPhase: followup"
        ;;
      polish)
        msg_subject="docs(course,ci): add Weeks 4–7 summary + References; add CI; rebuild evidence/scripts docs"
        msg_body="Why: Improve completeness and automated validation.\nPhase: polish"
        ;;
      enhance)
        msg_subject="docs(root,course): add architecture diagrams + learning reflection + highlights; expand evidence captions"
        msg_body="Why: Add narrative depth and faster entry points for reviewers.\nPhase: enhance"
        ;;
      *)
        msg_subject="docs(portfolio): update generated artifacts"
        msg_body="Phase: $phase"
        ;;
    esac
    # Append a short list of staged file categories
    changed=$(git diff --cached --name-only | sed -n '1,50p')
    git -c user.email="codex-bot@local" -c user.name="Codex Bot" \
      commit -m "$msg_subject" -m "$msg_body" -m "Files:\n$changed" || true
    if [[ "${PM_PUSH:-0}" == "1" ]]; then
      git push origin "${PORTFOLIO_BRANCH:-main}" || true
    fi
  fi
fi

echo "Phase '$phase' completed."
