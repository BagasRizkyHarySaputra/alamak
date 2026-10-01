#!/bin/bash
# sync-license.sh — sebarkan ida.hexlic ASLI via SSH/scp (tidak via git)
# Dipakai tim internal repo private.
#   ./scripts/sync-license.sh push user@host [--ida-dir DIR] [--src FILE]
#   ./scripts/sync-license.sh pull user@host [--ida-dir DIR]
set -u
MODE="${1:-}"; REMOTE="${2:-}"
IDADIR="${IDADIR:-$HOME/idapro-9.0}"
SRC_LOCAL="$IDADIR/ida.hexlic"

# parse flags
shift 2 2>/dev/null || { echo "Pakai: $0 push|pull user@host [--ida-dir DIR]"; exit 1; }
while [ $# -gt 0 ]; do
  case "$1" in
    --ida-dir) IDADIR="$2"; SRC_LOCAL="$IDADIR/ida.hexlic"; shift 2;;
    --src) SRC_LOCAL="$2"; shift 2;;
    *) echo "Flag tidak dikenal: $1" >&2; exit 1;;
  esac
done

if [ "$MODE" != "push" ] && [ "$MODE" != "pull" ]; then echo "MODE harus push|pull" >&2; exit 1; fi
if [ -z "$REMOTE" ]; then echo "REMOTE wajib: user@host" >&2; exit 1; fi

if [ "$MODE" = "push" ]; then
  [ -f "$SRC_LOCAL" ] || { echo "[FAIL] $SRC_LOCAL tidak ada di mesin ini." >&2; exit 1; }
  echo "[*] push $SRC_LOCAL -> $REMOTE:$IDADIR/ida.hexlic (via scp, mode 600)"
  ssh "$REMOTE" "mkdir -p '$IDADIR' && chmod 700 '$IDADIR'"
  scp -p "$SRC_LOCAL" "$REMOTE:$IDADIR/ida.hexlic.tmp"
  ssh "$REMOTE" "mv '$IDADIR/ida.hexlic.tmp' '$IDADIR/ida.hexlic' && chmod 600 '$IDADIR/ida.hexlic' && ls -l '$IDADIR/ida.hexlic'"
  echo "[OK] terkirim. Minta rekan jalankan ./scripts/setup-license.sh --check di mesinnya."
else
  echo "[*] pull $REMOTE:$IDADIR/ida.hexlic -> $SRC_LOCAL"
  mkdir -p "$IDADIR"; chmod 700 "$IDADIR"
  scp -p "$REMOTE:$IDADIR/ida.hexlic" "$SRC_LOCAL.tmp"
  mv "$SRC_LOCAL.tmp" "$SRC_LOCAL"; chmod 600 "$SRC_LOCAL"
  echo "[OK] tertarik: $SRC_LOCAL"
  ./scripts/setup-license.sh --check
fi
echo "[INFO] lisensi tidak masuk git. Cek repo tetap bersih: ./scripts/check-legal.sh"
