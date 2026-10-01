# Check-Legal.ps1 — pastikan repo tidak bocor lisensi/installer (Windows)
$fail = $false
$RepoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
if ([string]::IsNullOrEmpty($RepoRoot)) { $RepoRoot = "." }
Write-Host "== Legal check: $RepoRoot =="
$hits = Get-ChildItem -Path $RepoRoot -Recurse -File -Force -ErrorAction SilentlyContinue |
  Where-Object { $_.FullName -notmatch "\\\.git\\" -and $_.Name -notin @("check-legal.sh","Check-Legal.ps1","legal-check.yml") } |
  Select-String -Pattern "48-1337-DEAD|BEGIN IDA LICENSE" -ErrorAction SilentlyContinue
if ($hits) {
  Write-Host "[FAIL] isi lisensi IDA terdeteksi:" -ForegroundColor Red
  $hits | ForEach-Object { Write-Host "  $($_.Path):$($_.LineNumber)" -ForegroundColor Red }
  $fail = $true
} else { Write-Host "[OK] tidak ada isi lisensi (48-1337 / BEGIN IDA LICENSE)" -ForegroundColor Green }
$bad = Get-ChildItem -Path $RepoRoot -Recurse -File -Force -ErrorAction SilentlyContinue |
  Where-Object { $_.FullName -notmatch "\\\.git\\" -and ($_.Extension -in @(".hexlic",".idb",".i64") -or $_.Name -like "core.*" -or $_.Name -like "*.bak*" -or $_.Name -like "*.run") }
if ($bad) {
  Write-Host "[FAIL] file terlarang ditemukan:" -ForegroundColor Red
  $bad | ForEach-Object { Write-Host "  $($_.FullName)" -ForegroundColor Red }
  $fail = $true
} else { Write-Host "[OK] tidak ada file *.hexlic/*.run/core.*/*.bak/*.idb/*.i64" -ForegroundColor Green }
if (-not $fail) { Write-Host "== LEGAL CLEAN ==" -ForegroundColor Green }
else { Write-Host "== LEGAL DIRTY — perbaiki sebelum push! ==" -ForegroundColor Yellow; exit 1 }
