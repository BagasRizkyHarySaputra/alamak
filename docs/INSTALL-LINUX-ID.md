# INSTALL LINUX (Kali/Ubuntu/Debian) — Bahasa Indonesia
Estimasi: 15–30 menit. Diuji di Kali (IDA Pro 9.0 + Free 9.2).

## 1. Prasyarat
```bash
sudo apt update && sudo apt install -y python3 python3-pip git curl xvfb x11-utils libxcb-xinerama0 libxcb-icccm4 libxcb-keysyms1
python3 --version  # wajib 3.11+
curl -LsSf https://astral.sh/uv/install.sh | sh
```

## 2. Download IDA (resmi saja!)
- Pro: https://hex-rays.com/ida-pro (login akun lisensi) → dapat `ida-pro_90_x64linux.run`
- Free: https://hex-rays.com/ida-free → `ida-free-pc_92_x64linux.run`
> [!WARNING] Jangan share installer/license. Repo ini tidak menyediakannya.

## 3. Install
```bash
chmod +x ida-free-pc_92_x64linux.run
sudo ./ida-free-pc_92_x64linux.run
# Pro default ke ~/idapro-9.0, Free ke ~/ida-free-pc-9.2
ls ~/idapro-9.0/ida64 ~/ida-free-pc-9.2/ida
```

## 4. Python untuk IDA (`idapyswitch`)
```bash
~/idapro-9.0/idapyswitch  # pilih python 3.11+ terbaru
~/idapro-9.0/ida64 -c 'import sys; print(sys.version)'  # verifikasi
cat ~/idapro-9.0/qt.conf  # harus Prefix = .
```
Isi `README_python3.txt`: IDA butuh runtime Python yang dipilih via `idapyswitch`.

## 5. Perintah `ida` (wrapper)
Setup asli penulis (`~/.local/bin/ida`):
```bash
#!/bin/bash
export QT_QPA_PLATFORM=xcb
export DISPLAY=:1
exec /home/debugging/idapro-9.0/ida64 "$@"
```
Pakai versi repo (lebih robust, support fallback Free + xvfb):
```bash
chmod +x scripts/*.sh
./scripts/check-ida.sh
cp scripts/ida.sh ~/.local/bin/ida && chmod +x ~/.local/bin/ida
echo 'export IDADIR=$HOME/idapro-9.0' >> ~/.bashrc
ida /path/to/binary
```

## 6. Verifikasi
```bash
ida -h 2>&1 | head
DISPLAY=:1 QT_QPA_PLATFORM=xcb ida ~/chal_revenge &
```

## 7. Next
Lanjut ke `INSTALL-MCP-ID.md` untuk AI bridge, atau `TROUBLESHOOTING.md` kalau error Qt/DISPLAY.
