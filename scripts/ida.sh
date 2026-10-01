#!/bin/bash
# ida.sh — Linux wrapper pengganti ~/.local/bin/ida
# Meniru setup asli: QT_QPA_PLATFORM=xcb, DISPLAY=:1, exec $IDADIR/ida64 "$@"
# Cara pakai: IDADIR=$HOME/idapro-9.0 ./scripts/ida.sh /path/to/binary
set -euo pipefail
IDADIR="${IDADIR:-$HOME/idapro-9.0}"
IDA_BIN="$IDADIR/ida64"
IDA_FREE_FALLBACK="$HOME/ida-free-pc-9.2/ida"

export QT_QPA_PLATFORM="${QT_QPA_PLATFORM:-xcb}"
export DISPLAY="${DISPLAY:-:1}"

if [ ! -x "$IDA_BIN" ]; then
  if [ -x "$IDA_FREE_FALLBACK" ]; then
    echo "[ida.sh] $IDA_BIN tidak ketemu, fallback ke Free: $IDA_FREE_FALLBACK" >&2
    IDA_BIN="$IDA_FREE_FALLBACK"
  else
    echo "[ida.sh] ERROR: tidak ada binary di $IDA_BIN atau $IDA_FREE_FALLBACK" >&2
    echo "  Set IDADIR ke folder IDA kamu, contoh: export IDADIR=/opt/idapro-9.0" >&2
    exit 1
  fi
fi

# Headless hint: kalau DISPLAY tidak bisa dibuka dan ada xvfb-run, beri saran
if ! xdpyinfo >/dev/null 2>&1; then
  if command -v xvfb-run >/dev/null 2>&1; then
    echo "[ida.sh] DISPLAY=$DISPLAY tidak bisa dibuka, memakai xvfb-run -a ..." >&2
    exec xvfb-run -a "$IDA_BIN" "$@"
  else
    echo "[ida.sh] WARNING: DISPLAY=$DISPLAY tidak valid dan xvfb-run tidak ada." >&2
    echo "  Install: sudo apt install xvfb x11-utils  ATAU  export DISPLAY=:0" >&2
  fi
fi

exec "$IDA_BIN" "$@"
