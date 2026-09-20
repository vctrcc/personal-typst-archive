#!/usr/bin/env bash

set -Eeuo pipefail

REPO_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd -- "$REPO_ROOT"

COURSES_DIR="courses"
OUTPUT_DIR="outputs"

if ! command -v typst >/dev/null 2>&1; then
  echo "Error: typst is not installed or is not available in PATH." >&2
  exit 1
fi

mapfile -d '' -t sources < <(
  find "$COURSES_DIR" -type f -name '*.typ' -print0 | sort -z
)

if (( ${#sources[@]} == 0 )); then
  echo "Error: no Typst course documents found in $COURSES_DIR." >&2
  exit 1
fi

printf '%s\n' \
  "============================================================" \
  "Typst course compilation" \
  "============================================================" \
  "Repository:       $REPO_ROOT" \
  "Typst version:    $(typst --version)" \
  "Source directory: $COURSES_DIR" \
  "Output directory: $OUTPUT_DIR" \
  "Documents:        ${#sources[@]}" \
  "Failure policy:   Stop immediately on the first error" \
  "" \
  "Compilation plan:"

for source in "${sources[@]}"; do
  relative_path="${source#"$COURSES_DIR/"}"
  printf '  - %s -> %s/%s.pdf\n' \
    "$source" "$OUTPUT_DIR" "${relative_path%.typ}"
done

printf '%s\n' \
  "" \
  "============================================================" \
  "Starting compilation" \
  "============================================================"

mkdir -p "$OUTPUT_DIR"

index=0
for source in "${sources[@]}"; do
  index=$((index + 1))
  relative_path="${source#"$COURSES_DIR/"}"
  output="$OUTPUT_DIR/${relative_path%.typ}.pdf"

  mkdir -p "$(dirname -- "$output")"
  printf '\n[%d/%d] Compiling %s\n' "$index" "${#sources[@]}" "$relative_path"
  typst compile --root . "$source" "$output"
done

printf '\nCompilation complete: %d PDFs written under %s/\n' \
  "${#sources[@]}" "$OUTPUT_DIR"
