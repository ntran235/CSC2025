#!/bin/bash
set -euo pipefail

# Minimal patch: accept multiple .asm files and link them together.
# Usage:
#   ./build.sh main.asm                 # single file (old behavior)
#   ./build.sh main.asm fibrecurse.asm  # multiple files
#
# Output:
#   ./<first-src-basename>  (e.g., ./main for main.asm)
# first time running: chmod +x build.sh

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <source-file.asm> [extra .asm files...]"
    exit 1
fi

# First positional is still treated as the "main" (for output name)
SRC_PRIMARY="$1"
BASE="${SRC_PRIMARY%.asm}"
OUT="${BASE}"

# Collect all sources from args
SRCS=()
for arg in "$@"; do
    # accept only *.asm to be safe
    if [[ "$arg" == *.asm ]]; then
        SRCS+=("$arg")
    else
        echo "Warning: ignoring non-asm argument: $arg"
    fi
done

if [[ ${#SRCS[@]} -eq 0 ]]; then
    echo "Error: no .asm sources provided."
    exit 1
fi

# Check for nasm (keep your original behavior)
if ! command -v nasm >/dev/null 2>&1; then
    echo "Error: nasm is not installed."
    echo "Please install nasm using your package manager. For example:"
    echo "  brew install nasm        # On macOS with Homebrew"
    echo "  sudo apt-get install nasm # On Debian/Ubuntu"
    echo "  sudo dnf install nasm     # On Fedora"
    exit 1
fi

# Assemble all sources
echo "[1/2] Assembling ${SRCS[*]}"
OBJS=()
for SRC_PATH in "${SRCS[@]}"; do
    OBJ="${SRC_PATH%.asm}.o"
    nasm -f macho64 "$SRC_PATH" -o "$OBJ"
    OBJS+=("$OBJ")
done

# Link all objects (keep your original clang flags/pattern)
echo "[2/2] Linking ${OBJS[*]}"

if command -v clang >/dev/null 2>&1; then
    # If you had custom linker flags before, keep them here.
    # Common macOS x86_64 flags for NASM outputs:
    #   -arch x86_64        -> build for Intel 64-bit
    #   -Wl,-no_pie         -> disable PIE so naked entries work
    #   -mmacosx-version-min=10.13 -> set minimum macOS version (adjust if you had a different one)
    clang -arch x86_64 -Wl,-no_pie -mmacosx-version-min=10.13 \
      -o "$OUT" "${OBJS[@]}"
else
    echo "Error: clang is not installed."
    exit 1
fi

echo "Build complete: ./$OUT"
