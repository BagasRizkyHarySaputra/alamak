# INSTALL MCP / AI BRIDGE — Bahasa Indonesia
Dua mode (dari README `ida-pro-mcp` v2.0.0, `idaVersions >=8.3`, Pro 9 direkomendasikan, **Free tidak support headless**).

## Mode A — GUI plugin (deprecated tapi mudah)
```sh
pip uninstall ida-pro-mcp
pip install https://github.com/mrexodia/ida-pro-mcp/archive/refs/heads/main.zip
ida-pro-mcp --install
```
Lalu di IDA GUI: plugin terinstall, MCP server jalan. Cocok untuk pemula.

## Mode B — Headless `idalib-mcp` (disarankan)
Setup asli penulis (`~/.local/bin/idalib-mcp-wrapper`):
```bash
export IDADIR=/home/debugging/idapro-9.0
export TVHEADLESS=1
exec idalib-mcp --stdio "$@"
```
Terbukti jalan: `idalib_server` di port 51297 & 36873.

Langkah:
```bash
# Linux
uv run "/home/user/idapro-9.0/idalib/python/py-activate-idalib.py"
idalib-mcp --help
export IDADIR=$HOME/idapro-9.0 TVHEADLESS=1
idalib-mcp --stdio &
# Windows (PowerShell, sesuaikan versi 9.0/9.3)
uv run "C:\Program Files\IDA Professional 9.3\idalib\python\py-activate-idalib.py"
```

## Config MCP client (Claude Code / VSCode / Opencode)
```bash
ida-pro-mcp --config   # cetak JSON untuk client kamu
```
Claude Code plugin:
```bash
claude plugin marketplace add mrexodia/claude-marketplace
claude plugin install ida-pro-mcp@mrexodia
```

## Verifikasi
- Buka binary di IDA, lalu dari AI client: `list_funcs`, `decompile main` harus kembali pseudocode.
- `ps aux | grep idalib` harus ada server.

## Catatan Free vs Pro
- Free 9.2: hanya Mode A, tanpa decompiler Hex-Rays (hexx64/hexxarm).
- Pro 9.0: semua hex*.so (`hexarc64`, `hexarm64`, `hexx64`) + `idapython3_64.so` aktif.
