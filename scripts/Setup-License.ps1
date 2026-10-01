# Setup-License.ps1 — pasang .hexlic ASLI milikmu secara LOKAL (tidak di-commit)
param([string]$Src = "", [string]$IdaDir = $env:IDADIR)
if ([string]::IsNullOrEmpty($IdaDir)) { $IdaDir = "C:\Program Files\IDA Professional 9.0" }
Write-Host "== Setup lisensi lokal (TIDAK di-commit) =="
Write-Host "IDADIR=$IdaDir"
if ([string]::IsNullOrEmpty($Src)) {
  $dst = Join-Path $IdaDir "ida.hexlic"
  if (Test-Path $dst) { Write-Host "[OK] lisensi lokal ada: $dst (isi TIDAK ditampilkan)" -ForegroundColor Green }
  else { Write-Host "[FAIL] $dst tidak ada. Copy manual: Copy-Item C:\path\to\idapro.hexlic `"$dst`"" -ForegroundColor Red; exit 1 }
  return
}
if (-not (Test-Path $Src)) { Write-Error "[FAIL] sumber $Src tidak ada."; exit 1 }
if (-not (Test-Path $IdaDir)) { Write-Error "[FAIL] IDADIR $IdaDir tidak ada."; exit 1 }
$dst = Join-Path $IdaDir "ida.hexlic"
Copy-Item $Src $dst -Force
Write-Host "[OK] terpasang: $dst" -ForegroundColor Green
Write-Host "[INFO] file ini di-ignore git (*.hexlic), aman tidak ke-push."
