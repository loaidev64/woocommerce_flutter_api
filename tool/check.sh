#!/usr/bin/env bash
#
# The full check suite. CI runs exactly this, and you can run it locally.
#
#   tool/check.sh
#
set -euo pipefail
cd "$(dirname "$0")/.."

echo "==> flutter analyze"
flutter analyze

echo "==> flutter test"
flutter test

echo "==> dart format --set-exit-if-changed"
dart format --output=none --set-exit-if-changed lib test example tool
