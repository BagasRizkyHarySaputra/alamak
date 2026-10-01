# scripts/ — cara pakai

| File | OS | Fungsi |
|---|---|---|
| `ida.sh` | Linux | Wrapper `ida` (menggantikan `~/.local/bin/ida`). Dipakai: `IDADIR=$HOME/idapro-9.0 ./scripts/ida.sh sample` |
| `ida.bat` | Windows cmd | Sama, untuk cmd: `scripts\ida.bat C:\samples\a.exe` |
| `ida.ps1` | Windows PS | Sama, untuk PowerShell (lebih robust) |
| `check-ida.sh` | Linux | Cek binary, python 3.11+, uv, DISPLAY, Qt, MCP |
| `Check-Ida.ps1` | Windows | Cek setara Windows |

## Contoh Linux
```bash
chmod +x scripts/*.sh
./scripts/check-ida.sh
export IDADIR=$HOME/idapro-9.0
./scripts/ida.sh /path/to/crackme
# install ke PATH permanen:
cp scripts/ida.sh ~/.local/bin/ida && chmod +x ~/.local/bin/ida
```

## Contoh Windows
```powershell
powershell -ExecutionPolicy Bypass -File scripts\Check-Ida.ps1
$env:IDADIR="C:\Program Files\IDA Professional 9.0"
scripts\ida.ps1 C:\samples\crackme.exe
```
