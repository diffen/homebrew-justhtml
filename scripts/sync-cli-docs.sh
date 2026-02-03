#!/usr/bin/env bash
set -euo pipefail

root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
readme="$root/README.md"
start="<!-- CLI_DOCS_START -->"
end="<!-- CLI_DOCS_END -->"
source="${CLI_DOCS_SOURCE:-https://raw.githubusercontent.com/diffen/justhtml-php/main/CLI.md}"

tmp="$(mktemp)"
cleaned="$(mktemp)"

cleanup() {
  rm -f "$tmp" "$cleaned"
}
trap cleanup EXIT

if [[ "$source" =~ ^https?:// ]]; then
  curl -fsSL "$source" > "$tmp"
elif [[ -f "$source" ]]; then
  cat "$source" > "$tmp"
else
  echo "CLI docs source not found: $source" >&2
  exit 1
fi

sed -e 's#php bin/justhtml#justhtml#g' \
    -e 's#vendor/bin/justhtml#justhtml#g' \
    "$tmp" > "$cleaned"

awk -v start="$start" -v end="$end" -v docs_file="$cleaned" '
  BEGIN {
    while ((getline line < docs_file) > 0) {
      docs = docs line "\n"
    }
    close(docs_file)
  }
  $0 == start {
    found_start = 1
    print
    printf "%s", docs
    inblock = 1
    next
  }
  inblock {
    if ($0 == end) {
      found_end = 1
      print
      inblock = 0
    }
    next
  }
  {
    print
  }
  END {
    if (!found_start || !found_end) {
      exit 1
    }
  }
' "$readme" > "$readme.tmp"

mv "$readme.tmp" "$readme"
