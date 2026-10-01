# IDA Tutorial — Install & Run IDA Pro / IDA Free on Windows & Linux + MCP

> Tutorial instalasi IDA Pro & IDA Free + command `ida` + integrasi AI (ida-pro-mcp / idalib-mcp) yang bisa dipraktekkan di **Windows & Linux**.
> Bahasa utama:  Indonesia — lihat [README-ID.md](README-ID.md). English version below.

[![Linux](https://img.shields.io/badge/OS-Linux-Kali%20tested-blue)]()
[![Windows](https://img.shields.io/badge/OS-Windows-10%2F11-blue)]()
[![IDA](https://img.shields.io/badge/IDA-Pro%209.0%20%7C%20Free%209.2-tested-green)]()

## Kenapa repo ini ada?

Setup di mesin penulis (Kali Linux):
- `ida` → wrapper `~/.local/bin/ida` berisi `QT_QPA_PLATFORM=xcb`, `DISPLAY=:1`, `exec ~/idapro-9.0/ida64 "$@"`
- IDA Pro 9.0 di `~/idapro-9.0` (Qt5) + IDA Free 9.2 di `~/ida-free-pc-9.2` (Qt6)
- AI bridge `ida-pro-mcp` + `idalib-mcp --stdio` dengan `IDADIR` + `TVHEADLESS=1`

Repo ini mendokumentasikan setup itu agar bisa direplikasi di mesin lain (Windows & Linux) **tanpa membocorkan lisensi/installer**.

## Struktur

```
ida-tutorial-repo/
├── README.md / README-ID.md
├── scripts/
│   ├── ida.sh          # Linux wrapper (pengganti ~/.local/bin/ida)
│   ├── ida.bat         # Windows cmd wrapper
│   ├── ida.ps1         # Windows PowerShell wrapper
│   ├── check-ida.sh    # checker Linux
│   ├── Check-Ida.ps1   # checker Windows
│   └── README.md       # cara pakai scripts
└── docs/
    ├── INSTALL-LINUX-ID.md
    ├── INSTALL-WINDOWS-ID.md
    ├── INSTALL-MCP-ID.md
    ├── TROUBLESHOOTING.md
    └── ANALISIS-SETUP-KALI.md  # audit mesin penulis
```

## Quickstart

### Linux (Kali/Ubuntu/Debian)
```bash
git clone <url-repo-ini>
cd ida-tutorial-repo
chmod +x scripts/*.sh
./scripts/check-ida.sh
IDADIR=$HOME/idapro-9.0 ./scripts/ida.sh /path/to/binary
```

### Windows (PowerShell)
```powershell
git clone <url-repo-ini>
cd ida-tutorial-repo
powershell -ExecutionPolicy Bypass -File scripts\Check-Ida.ps1
scripts\ida.ps1 C:\samples\crackme.exe
```

Detail penuh: [docs/INSTALL-LINUX-ID.md](docs/INSTALL-LINUX-ID.md) · [docs/INSTALL-WINDOWS-ID.md](docs/INSTALL-WINDOWS-ID.md) · [docs/INSTALL-MCP-ID.md](docs/INSTALL-MCP-ID.md)

## Prasyarat

| Kebutuhan | Linux | Windows |
|---|---|---|
| IDA | Download resmi hex-rays.com (Pro) atau Free 9.2 `.run` | Installer resmi `.exe` |
| Python | 3.11+ (`python3 --version`) + `idapyswitch` | 3.11+ + `idapyswitch.exe` |
| Tools | `uv`, `git`, `xvfb-run` (headless) | `uv`, `git`, VC Redist |
| Lisensi | File `.hexlic` milik sendiri, jangan commit! | Sama |

## Disclaimer legal 

- Repo ini **TIDAK** menyediakan installer IDA, file `.hexlic`, keygen, crack, atau bypass lisensi.
- Kamu wajib punya lisensi resmi Hex-Rays atau pakai IDA Free.
- Jangan pernah `git add *.hexlic *.run core.*` — sudah di-block di [.gitignore](.gitignore).

---
English: This repo is a step-by-step IDA install tutorial (Windows & Linux) + `ida` command wrapper + MCP/AI setup, based on a real Kali setup. Full Indonesian docs in `docs/*-ID.md`.
