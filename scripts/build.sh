#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:-fr57047mm}"
KEY="${GARMIN_DEVELOPER_KEY:-$HOME/.garmin/developer_key.der}"

if ! command -v monkeyc >/dev/null 2>&1; then
  echo "monkeyc not found. Install Garmin Connect IQ SDK and add it to PATH." >&2
  exit 1
fi

if [ ! -f "$KEY" ]; then
  echo "Developer key not found: $KEY" >&2
  echo "Run ./scripts/generate-key.sh once." >&2
  exit 1
fi

mkdir -p bin
monkeyc -d "$TARGET" -f monkey.jungle -o "bin/windsurf-${TARGET}.prg" -y "$KEY"
echo "Built bin/windsurf-${TARGET}.prg"
