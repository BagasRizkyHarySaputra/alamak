# Check-Ida.ps1 — validasi setup IDA di Windows
$fail = $false
function Ok($m){ Write-Host "[OK] $m" -ForegroundColor Green }
function Bad($m,$s){ Write-Host "[FAIL] $m -- $s" -ForegroundColor Red; $script:fail = $true }

$IdaDir = $env:IDADIR
if ([string]::IsNullOrEmpty($IdaDir)) {
  foreach ($c in @("C:\Program Files\IDA Professional 9.0","C:\Program Files\IDA Professional 9.3","C:\Program Files\IDA Free 9.2")) {
    if (Test-Path $c) { $IdaDir = $c; break }
  }
}
if ($IdaDir -and (Test-Path "$IdaDir\ida64.exe" -PathType Leaf)) { Ok "IDA di $IdaDir\ida64.exe" }
elseif ($IdaDir -and (Test-Path "$IdaDir\ida.exe" -PathType Leaf)) { Ok "IDA Free di $IdaDir\ida.exe" }
else { Bad "IDA binary" "set `$env:IDADIR='C:\path\to\ida' atau install dari hex-rays.com" }

try { $v = (python --version) 2>&1; if ($v -match "3\.(11|12|13)") { Ok $v } else { Bad "python $v" "butuh 3.11+, lalu jalankan idapyswitch.exe" } }
catch { Bad "python" "install python 3.11+ dan centang Add to PATH" }

if (Get-Command uv -ErrorAction SilentlyContinue) { Ok "uv ada" } else { Bad "uv" "install via powershell -c `"irm astral.sh/uv/install.ps1 | iex`"" }
if (Get-Command idalib-mcp -ErrorAction SilentlyContinue) { Ok "idalib-mcp ada" } else { Write-Host "[INFO] idalib-mcp belum ada (lihat docs/INSTALL-MCP-ID.md)" }
if ($env:QT_QPA_PLATFORM -eq "windows" -or [string]::IsNullOrEmpty($env:QT_QPA_PLATFORM)) { Ok "QT_QPA_PLATFORM=$($env:QT_QPA_PLATFORM)" } else { Write-Host "[INFO] QT_QPA_PLATFORM=$($env:QT_QPA_PLATFORM)" }

if (-not $fail) { Write-Host "== SEMUA CEK PENTING LULUS ==" -ForegroundColor Green } else { Write-Host "== ADA YANG GAGAL, lihat docs/TROUBLESHOOTING.md ==" -ForegroundColor Yellow; exit 1 }
