# TROUBLESHOOTING

## 1. `Could not load Qt platform plugin "xcb"` (Linux)
**Gejala:** IDA langsung exit, error xcb.
**Fix:**
```bash
sudo apt install -y libxcb-xinerama0 libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-render-util0 libxkbcommon-x11-0
export QT_QPA_PLATFORM=xcb
QT_DEBUG_PLUGINS=1 ./ida64  # lihat plugin mana yang gagal
```
Pro 9.0 = Qt5, Free 9.2 = Qt6 — jangan campur `LD_LIBRARY_PATH`.

## 2. Wayland vs X11
```bash
echo $XDG_SESSION_TYPE  # wayland → paksa xcb
export QT_QPA_PLATFORM=xcb
```

## 3. DISPLAY unset / cannot open display
```bash
echo $DISPLAY  # kosong → set
export DISPLAY=:1
# headless server:
xvfb-run -a ida /path/to/bin
# atau pakai scripts/ida.sh yang otomatis fallback xvfb-run
```

## 4. IDAPython gagal (`import idc` error)
```bash
~/idapro-9.0/idapyswitch  # pilih 3.11+
ldd ~/idapro-9.0/plugins/idapython3_64.so | grep "not found"
```

## 5. MCP tidak konek
- Cek `echo $IDADIR $TVHEADLESS` → harus `/...idapro-9.0` dan `1`
- Cek `ps aux | grep idalib`, `ss -tlnp | grep 51297`
- `idalib-mcp --stdio` manual, lihat stderr.
- Free tidak support headless — pakai Pro.

## 6. Windows spesifik
- `ida64.exe` tidak jalan → install VC Redist x64.
- `ida.ps1 cannot be loaded` → `Set-ExecutionPolicy -Scope CurrentUser Bypass`.
- Path spasi → selalu quote: `"C:\Program Files\IDA Professional 9.0\ida64.exe"`.
- Python salah versi → jalankan `idapyswitch.exe` sebagai Administrator.

## 7. `core.*` menumpuk (kasus mesin penulis: core.28926 dst)
```bash
ls -lh ~/idapro-9.0/core.*  # hapus aman, ini dump crash
rm ~/idapro-9.0/core.* ~/idapro-9.0/*.bak ~/idapro-9.0/*.bak2  # backup dulu kalau ragu
ulimit -c 0  # matikan core dump sementara
```
