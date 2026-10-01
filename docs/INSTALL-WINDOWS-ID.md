# INSTALL WINDOWS 10/11 — Bahasa Indonesia
Estimasi: 15–30 menit.

## 1. Prasyarat
- Python 3.11+ dari python.org (centang **Add to PATH**): `python --version`
- Git: https://git-scm.com/download/win
- uv: `powershell -c "irm astral.sh/uv/install.ps1 | iex"`
- VC Redist X64: https://aka.ms/vs/17/release/vc_redist.x64.exe (wajib, kalau tidak IDA gagal start Qt)

## 2. Download & install IDA (resmi!)
- Pro/Free dari https://hex-rays.com → `.exe` → next-next → default `C:\Program Files\IDA Professional 9.0` atau `C:\Program Files\IDA Free 9.2`
> [!WARNING].forbidden: crack/keygen. Gunakan lisensi resmi atau Free.

## 3. Python untuk IDA
```powershell
& "C:\Program Files\IDA Professional 9.0\idapyswitch.exe"
# pilih Python 3.11+ terbaru
```

## 4. Perintah `ida` di Windows
Repo menyediakan 2 wrapper setara `ida.sh`:
```powershell
# cek dulu
powershell -ExecutionPolicy Bypass -File scripts\Check-Ida.ps1
# pakai PowerShell (disarankan)
$env:IDADIR="C:\Program Files\IDA Professional 9.0"
scripts\ida.ps1 C:\samples\crackme.exe
# atau cmd
scripts\ida.bat C:\samples\crackme.exe
```
Permanen ke PATH: Tambah folder berisi `ida.bat` ke **System Properties → Environment Variables → Path**.

`qt.conf` di Windows sama (`Prefix = .`) — jangan ubah agar Qt load dari folder IDA sendiri, bukan sistem.

## 5. Verifikasi
```powershell
& "$env:IDADIR\ida64.exe" -h
```

## 6. Next
`INSTALL-MCP-ID.md` untuk AI, `TROUBLESHOOTING.md` untuk ExecutionPolicy & path spasi.
