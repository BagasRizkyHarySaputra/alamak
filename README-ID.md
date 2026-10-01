# Tutorial IDA — Instalasi & Perintah `ida` di Windows & Linux + MCP

> Dokumentasi lengkap Bahasa Indonesia. Versi ringkas English ada di [README.md](README.md).

## Daftar isi
- [Kenapa repo ini ada](#kenapa-repo-ini-ada)
- [Yang kamu dapat](#yang-kamu-dapat)
- [Alur 10 menit](#alur-10-menit)
- [Dokumen lengkap](#dokumen-lengkap)
- [Perintah `ida` yang didokumentasikan](#perintah-ida-yang-didokumentasikan)
- [Legal](#legal)

## Kenapa repo ini ada
Di mesin penulis (Kali Linux) sudah ada setup:
- perintah `ida` = file `~/.local/bin/ida` isi 3 baris: `QT_QPA_PLATFORM=xcb`, `DISPLAY=:1`, `exec ~/idapro-9.0/ida64 "$@"`
- IDA Pro 9.0 (Qt5) + IDA Free 9.2 (Qt6)
- `ida-pro-mcp` + `idalib-mcp --stdio` dengan env `IDADIR` dan `TVHEADLESS=1`

Repo ini membedah setup itu jadi tutorial yang bisa dipakai orang lain di Windows & Linux.

## Yang kamu dapat
- Wrapper `ida` cross-platform (`scripts/ida.sh`, `ida.bat`, `ida.ps1`)
- Checker `check-ida.sh` / `Check-Ida.ps1` untuk validasi Python, Qt, DISPLAY, uv, MCP
- Tutorial install Linux, Windows, MCP, troubleshooting, dan audit mesin Kali (`docs/`)

## Alur 10 menit
1. Baca [docs/ANALISIS-SETUP-KALI.md](docs/ANALISIS-SETUP-KALI.md) — paham acuan.
2. Linux → [docs/INSTALL-LINUX-ID.md](docs/INSTALL-LINUX-ID.md). Windows → [docs/INSTALL-WINDOWS-ID.md](docs/INSTALL-WINDOWS-ID.md).
3. Pasang AI bridge → [docs/INSTALL-MCP-ID.md](docs/INSTALL-MCP-ID.md).
4. Error? → [docs/TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md).

## Dokumen lengkap
| File | Isi |
|---|---|
| `docs/INSTALL-LINUX-ID.md` | Install IDA Free/Pro di Kali/Ubuntu, `idapyswitch`, wrapper `~/.local/bin/ida`, Xvfb |
| `docs/INSTALL-WINDOWS-ID.md` | Install `.exe`, PATH, `ida.bat`/`ida.ps1`, VC Redist, ExecutionPolicy |
| `docs/INSTALL-MCP-ID.md` | `ida-pro-mcp --install` (GUI) vs `idalib-mcp` headless + `py-activate-idalib.py` + config Claude/VSCode |
| `docs/TROUBLESHOOTING.md` | Qt xcb, Wayland, DISPLAY, idapython, MCP port, Windows path spasi |
| `docs/ANALISIS-SETUP-KALI.md` | Audit nyata mesin penulis |
| `scripts/README.md` | Cara pakai tiap script |

## Perintah `ida` yang didokumentasikan
Linux (`scripts/ida.sh` meniru `~/.local/bin/ida`):
```bash
export QT_QPA_PLATFORM=xcb
export DISPLAY=${DISPLAY:-:1}
exec "${IDADIR:-$HOME/idapro-9.0}/ida64" "$@"
```
Windows (`scripts/ida.ps1` setara):
```powershell
$env:QT_QPA_PLATFORM = "windows"
& "$env:IDADIR\ida64.exe" $args
```

## Legal
Wajib lisensi resmi Hex-Rays atau IDA Free. Repo ini tidak berisi installer, `.hexlic`, crack, keygen. Jangan commit file sensitif (sudah di `.gitignore`).
