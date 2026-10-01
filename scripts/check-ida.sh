#!/bin/bash
# check-ida.sh — validasi setup IDA di Linux (Bahasa Indonesia)
set -u
ok=1
say_ok(){ echo "[OK] $1"; }
say_bad(){ echo "[FAIL] $1 -- $2"; ok=0; }

IDADIR="${IDADIR:-$HOME/idapro-9.0}"
[ -x "$IDADIR/ida64" ] && say_ok "IDA Pro di $IDADIR/ida64" || say_bad "IDA Pro di $IDADIR/ida64" "set IDADIR atau install dari hex-rays.com"
[ -x "$HOME/ida-free-pc-9.2/ida" ] && say_ok "IDA Free di ~/ida-free-pc-9.2/ida" || echo "[INFO] IDA Free tidak ada (opsional)"
python3 --version 2>&1 | grep -qE "3\.(11|12|13)" && say_ok "$(python3 --version 2>&1)" || say_bad "python3" "butuh 3.11+, lalu jalankan $IDADIR/idapyswitch"
command -v uv >/dev/null && say_ok "uv $(uv --version 2>&1)" || say_bad "uv" "install: curl -LsSf astral.sh/uv/install.sh | sh"
command -v xvfb-run >/dev/null && say_ok "xvfb-run ada" || echo "[INFO] xvfb-run tidak ada (perlu untuk headless): sudo apt install xvfb"
[ -n "${DISPLAY:-}" ] && say_ok "DISPLAY=$DISPLAY" || say_bad "DISPLAY" "export DISPLAY=:1 (atau :0)"
[ "${QT_QPA_PLATFORM:-}" = "xcb" ] && say_ok "QT_QPA_PLATFORM=xcb" || echo "[INFO] QT_QPA_PLATFORM=${QT_QPA_PLATFORM:-<kosong>} (disarankan xcb di Linux/X11)"
command -v idalib-mcp >/dev/null && say_ok "idalib-mcp ada" || echo "[INFO] idalib-mcp belum ada (lihat docs/INSTALL-MCP-ID.md)"
command -v ida-pro-mcp >/dev/null && say_ok "ida-pro-mcp ada" || echo "[INFO] ida-pro-mcp belum ada"

if [ $ok -eq 1 ]; then echo "== SEMUA CEK PENTING LULUS =="; else echo "== ADA YANG GAGAL, lihat docs/TROUBLESHOOTING.md =="; exit 1; fi
