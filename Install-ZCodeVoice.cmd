@echo off
setlocal
title ZCode Voice Installer
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Install-ZCodeVoice.ps1" %*
if errorlevel 1 (
  echo.
  echo Installation failed. See the message above.
  pause
)
endlocal
