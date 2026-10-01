#!/bin/bash
# setup-license.sh — pasang .hexlic ASLI milikmu secara LOKAL (tidak di-commit)
# Cara pakai:
#   ./scripts/setup-license.sh /path/ke/idapro.hexlic [--ida-dir ~/idapro-9.0]
#   ./scripts/setup-license.sh --check   # cek saja, tanpa copy
set -u
SRC="${1:-}"
IDADIR="${IDADIR:-$HOME/idapro-9.0}"
[ "${2:-}" != "" ] && [ "$2" != "--check" ] && IDADIR="$2"
[ "${1:-}" = "--check" ] && SRC=""

echo "== Setup lisensi lokal (TIDAK di-commit) =="
echo "IDADIR=$IDADIR"

if [ -z "$SRC" ]; then
  # mode cek saja
  if [ -f "$IDADIR/ida.hexlic" ]; then
    echo "[OK] lisensi lokal ada: $IDADIR/ida.hexlic ($(wc -c < "$IDADIR/ida.hexlic") bytes)"
    echo "     (isi TIDAK ditampilkan demi keamanan)"
    exit 0
  else
    echo "[FAIL] $IDADIR/ida.hexlic tidak ada."
    echo "  Copy manual: cp /path/ke/idapro.hexlic \"$IDADIR/ida.hexlic\""
    exit 1
  fi
fi

if [ ! -f "$SRC" ]; then echo "[FAIL] sumber $SRC tidak ada." >&2; exit 1; fi
if [ ! -d "$IDADIR" ]; then echo "[FAIL] IDADIR $IDADIR tidak ada." >&2; exit 1; fi
cp "$SRC" "$IDADIR/ida.hexlic"
chmod 600 "$IDADIR/ida.hexlic"
echo "[OK] terpasang: $IDADIR/ida.hexlic (mode 600)"
echo "[INFO] file ini di-ignore git (lihat .gitignore: *.hexlic), aman tidak ke-push."
./scripts/check-legal.sh 2>&1 | tail -n 2
