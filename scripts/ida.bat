@echo off
REM ida.bat — Windows cmd wrapper setara ida.sh
REM Cara pakai: scripts\ida.bat C:\samples\crackme.exe
REM Bisa override: set IDADIR=C:\Program Files\IDA Professional 9.0

if "%IDADIR%"=="" (
  if exist "C:\Program Files\IDA Professional 9.0\ida64.exe" (
    set "IDADIR=C:\Program Files\IDA Professional 9.0"
  ) else if exist "C:\Program Files\IDA Free 9.2\ida.exe" (
    set "IDADIR=C:\Program Files\IDA Free 9.2"
  ) else (
    echo [ida.bat] ERROR: IDADIR tidak diset dan IDA tidak ketemu di Program Files.
    echo   Set manual: set IDADIR=C:\path\to\ida
    exit /b 1
  )
)

set "QT_QPA_PLATFORM=windows"

if exist "%IDADIR%\ida64.exe" (
  "%IDADIR%\ida64.exe" %*
) else if exist "%IDADIR%\ida.exe" (
  "%IDADIR%\ida.exe" %*
) else (
  echo [ida.bat] ERROR: tidak ada ida64.exe / ida.exe di %IDADIR%
  exit /b 1
)
