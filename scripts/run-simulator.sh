#!/usr/bin/env bash
set -euo pipefail
TARGET="${1:-fr57047mm}"
./scripts/build.sh "$TARGET"
monkeydo "bin/windsurf-${TARGET}.prg" "$TARGET"
