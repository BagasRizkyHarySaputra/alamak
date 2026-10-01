# QUICKSTART 3 Skenario — Bahasa Indonesia

## Skenario A — Belum punya IDA sama sekali
**Tujuan:** dari nol sampai bisa `ida sample` + lolos checker.

Linux:
```bash
# 1. Download resmi (jangan bajakan): hex-rays.com → ida-free-pc_92_x64linux.run
chmod +x ida-free-pc_92_x64linux.run && sudo ./ida-free-pc_92_x64linux.run
# 2. Python + wrapper + cek:
~/ida-free-pc-9.2/idapyswitch   # pilih 3.11+ (kalau pakai Free, path-nya folder Free)
chmod +x scripts/*.sh
./scripts/check-ida.sh          # awalnya FAIL di Pro itu wajar, yang penting Free OK
export IDADIR=$HOME/ida-free-pc-9.2
./scripts/ida.sh /path/to/sample
```
Windows:
```powershell
# 1. Install IDA Free .exe → C:\Program Files\IDA Free 9.2
# 2. idapyswitch.exe + VC Redist + uv (lihat INSTALL-WINDOWS-ID.md)
powershell -ExecutionPolicy Bypass -File scripts\Check-Ida.ps1
$env:IDADIR="C:\Program Files\IDA Free 9.2"
scripts\ida.ps1 C:\samples\sample.exe
```
Docs: `INSTALL-LINUX-ID.md` / `INSTALL-WINDOWS-ID.md`. MCP opsional (`INSTALL-MCP-ID.md`, Free = GUI plugin saja).

## Skenario B — Sudah ada IDA Free, belum ada Pro
**Tujuan:** pasang Pro berdampingan TANPA menimpa Free, bisa ganti-ganti via `IDADIR`.

```bash
# 1. Install Pro ke folder BEDA (default ~/idapro-9.0, jangan timpa ida-free-pc-9.2)
chmod +x ida-pro_90_x64linux.run && sudo ./ida-pro_90_x64linux.run
ls ~/idapro-9.0/ida64 ~/ida-free-pc-9.2/ida   # keduanya harus ada

# 2. Python untuk Pro (wajib ulang, beda folder):
~/idapro-9.0/idapyswitch

# 3. Lisensi Pro (lokal, tidak di-commit):
./scripts/setup-license.sh /path/ke/idapro.hexlic
./scripts/setup-license.sh --check

# 4. Pilih varian tiap run:
IDADIR=$HOME/idapro-9.0 ./scripts/ida.sh sample      # Pro
IDADIR=$HOME/ida-free-pc-9.2 ./scripts/ida.sh sample # Free
./scripts/check-ida.sh   # harus OK semua (Pro + Free)
```
Windows: install Pro ke `C:\Program Files\IDA Professional 9.0` (biarkan Free), lalu `$env:IDADIR=...` ganti-ganti. Detail: `PRIVATE-SETUP.md` (dapat hexlic via `sync-license.sh pull`) + `INSTALL-MCP-ID.md` (Pro = headless OK, Free = tidak).

## Skenario C — Sudah ada IDA Pro tapi lisensi belum dipasang
**Tujuan:** pasang `.hexlic` lokal + verifikasi, tanpa masuk git.

```bash
# 1. Dapat file asli (Hex-Rays / admin tim via scp — JANGAN via git):
./scripts/sync-license.sh pull user@mesin-yang-sudah-ada   # tim private
# atau kalau file sudah di tangan:
./scripts/setup-license.sh /path/ke/idapro.hexlic

# 2. Verifikasi:
./scripts/setup-license.sh --check   # OK: .../ida.hexlic (2085 bytes), isi tidak ditampilkan
./scripts/check-ida.sh               # IDA Pro OK
./scripts/check-legal.sh             # LEGAL CLEAN (repo tetap bersih)
QT_QPA_PLATFORM=xcb DISPLAY=:1 ida sample &
```
Windows:
```powershell
scripts\Setup-License.ps1 -Src "C:\path\to\idapro.hexlic"
scripts\Setup-License.ps1            # cek
powershell -ExecutionPolicy Bypass -File scripts\Check-Ida.ps1
```

## Tabel putus cepat
| Kondisi | Jalankan | Bukti sukses |
|---|---|---|
| Nol IDA | download resmi → install → `idapyswitch` → `check-ida.sh` → `ida.sh sample` | `check-ida` OK, IDA terbuka |
| Free ada, Pro belum | install Pro folder beda → `idapyswitch` Pro → `setup-license.sh SRC` → `check-ida.sh` | `ls` kedua binary ada, Pro OK |
| Pro ada, license belum | `sync-license.sh pull` ATAU `setup-license.sh SRC` → `--check` → `check-legal.sh` | `--check` OK + LEGAL CLEAN |

> Setelah semua OK → lanjut `INSTALL-MCP-ID.md` untuk AI bridge. Error? `TROUBLESHOOTING.md`.
