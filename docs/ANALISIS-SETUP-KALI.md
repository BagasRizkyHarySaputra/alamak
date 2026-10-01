# ANALISIS SETUP KALI (mesin penulis) — 1 Okt 2026

## Ringkasan
| Item | Fakta |
|---|---|
| OS | Kali 2025.4, kernel 6.18.9+kali-amd64, x86_64 |
| DISPLAY | `:1`, `QT_QPA_PLATFORM` unset di env tapi `xcb` di wrapper |
| Wrapper `ida` | `/home/debugging/.local/bin/ida` (100 bytes): `export QT_QPA_PLATFORM=xcb`, `export DISPLAY=:1`, `exec /home/debugging/idapro-9.0/ida64 "$@"` |
| IDA Pro 9.0 | `~/idapro-9.0`: `ida64` 6.4MB, `idat64` 2.3MB, `libida64.so` 6.2MB, Qt5 (`libQt5*.so`), `plugins/idapython3_64.so` 1.4MB, hex decompilers `hexarc/arm/mips/ppc/rv/x64.so` ~4MB, `cfg/` 85MB, `qt.conf` Prefix=. |
| IDA Free 9.2 | `~/ida-free-pc-9.2`: `ida` 8.1MB, `libida.so` 55MB, Qt6 (`libQt6*.so`), installer `~/Downloads/ida-free-pc_92_x64linux.run` |
| MCP | `~/ida-pro-mcp` (git repo, plugin v2.0.0, `idaVersions >=8.3`), wrapper `idalib-mcp-wrapper`: `IDADIR=~/idapro-9.0`, `TVHEADLESS=1`, `exec idalib-mcp --stdio`. Proses hidup: `idalib_server --port 51297`, `--port 36873`, `idalib-mcp --stdio` via miniconda python 3.13.11 |
| Python | `python3` 3.13.11 (miniconda), `README_python3.txt` → wajib `idapyswitch` |
| Anomali | `*.bak` (`idat64.bak2`, `libida64.so.bak`, `libida.so.bak`) + `core.28926/28947/29093/31983/37461` (13–47MB) → indikasi pernah patch + crash Juni 2025. Saran: backup bersih, hapus core, `ulimit -c 0` sementara |
| Lisensi | `ida.hexlic` ada (tidak ditampilkan isinya di sini demi legalitas). Jangan commit! |

## Perbedaan Windows vs Linux dari setup ini
- Linux butuh `DISPLAY` + `xcb` + `xvfb-run` untuk headless; Windows pakai `QT_QPA_PLATFORM=windows` dan tidak butuh DISPLAY.
- Path Linux `$HOME/idapro-9.0` vs Windows `%PROGRAMFILES%\IDA Professional 9.x`.
- `idapyswitch` (Linux, tanpa ext) vs `idapyswitch.exe` (Windows, run as admin).
- `uv run ".../py-activate-idalib.py"` path POSIX vs Windows quoted path.

## Yang direplikasi ke repo
- `scripts/ida.sh` = versi robust dari `~/.local/bin/ida` + fallback Free + xvfb.
- `scripts/ida.bat`/`ida.ps1` = padanan Windows.
- `check-*.sh/ps1` = validasi fakta di atas (binary ada, python 3.11+, uv, DISPLAY, MCP).
