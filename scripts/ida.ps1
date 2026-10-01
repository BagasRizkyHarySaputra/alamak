# ida.ps1 — Windows PowerShell wrapper setara ida.sh
# Cara pakai: powershell -ExecutionPolicy Bypass -File scripts\ida.ps1 C:\samples\crackme.exe
param([Parameter(ValueFromRemainingArguments=$true)][string[]]$ArgsRest)

$IdaDir = $env:IDADIR
if ([string]::IsNullOrEmpty($IdaDir)) {
  $cands = @("C:\Program Files\IDA Professional 9.0", "C:\Program Files\IDA Professional 9.3", "C:\Program Files\IDA Free 9.2")
  foreach ($c in $cands) { if (Test-Path $c) { $IdaDir = $c; break } }
}
if ([string]::IsNullOrEmpty($IdaDir) -or -not (Test-Path $IdaDir)) {
  Write-Error "[ida.ps1] ERROR: IDADIR tidak valid. Set `$env:IDADIR='C:\path\to\ida'"
  exit 1
}
$env:QT_QPA_PLATFORM = "windows"
$exe64 = Join-Path $IdaDir "ida64.exe"
$exeFree = Join-Path $IdaDir "ida.exe"
if (Test-Path $exe64) { & $exe64 @ArgsRest }
elseif (Test-Path $exeFree) { & $exeFree @ArgsRest }
else { Write-Error "[ida.ps1] ERROR: tidak ada ida64.exe/ida.exe di $IdaDir"; exit 1 }
