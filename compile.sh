#!/bin/bash
# run: ./compile.sh main.asm
# run: ./main
set -euo pipefail

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <source-file.asm>"
    exit 1
fi

SRC_PATH="$1"
BASE="${SRC_PATH%.asm}"
OBJ="${BASE}.o"
OUT="${BASE}"

echo "[1/2] Assembling $SRC_PATH"
nasm -f macho64 "$SRC_PATH" -o "$OBJ"

echo "[2/2] Linking $OBJ"
clang -arch x86_64 "$OBJ" -o "$OUT" -mmacosx-version-min=10.13

echo "Build complete: ./$OUT"