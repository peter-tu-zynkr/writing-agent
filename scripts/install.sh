#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
TARGET_DIR="${1:-$PWD}"
CLAUDE_DIR="${TARGET_DIR}/.claude"
AGENTS_DIR="${CLAUDE_DIR}/agents"
SKILLS_DIR="${CLAUDE_DIR}/skills"
TARGET_SKILL_DIR="${SKILLS_DIR}/write-article"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"

mkdir -p "${AGENTS_DIR}" "${SKILLS_DIR}"

if [ -e "${TARGET_SKILL_DIR}" ]; then
  BACKUP_DIR="${TARGET_SKILL_DIR}.backup-${TIMESTAMP}"
  mv "${TARGET_SKILL_DIR}" "${BACKUP_DIR}"
  echo "Backed up existing skill to: ${BACKUP_DIR}"
fi

cp -R "${REPO_ROOT}/.claude/skills/write-article" "${TARGET_SKILL_DIR}"

for agent_file in "${REPO_ROOT}"/.claude/agents/*.md; do
  cp "${agent_file}" "${AGENTS_DIR}/"
done

echo "Installed write-article skill into: ${TARGET_DIR}"
echo "Installed 7 supporting agents into: ${AGENTS_DIR}"
echo
echo "Next steps:"
echo "1. cd \"${TARGET_DIR}\""
echo "2. claude"
echo "3. run /write-article"
