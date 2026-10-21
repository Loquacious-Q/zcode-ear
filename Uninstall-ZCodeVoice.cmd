@echo off
setlocal
title ZCode Voice Uninstaller
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Install-ZCodeVoice.ps1" -Uninstall %*
if errorlevel 1 (
  echo.
  echo Uninstall failed. See the message above.
  pause
)
endlocal
