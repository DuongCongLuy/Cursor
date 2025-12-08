@echo off
REM Script wrapper để chạy sync-mcp.ps1 với ExecutionPolicy Bypass
REM Wrapper script to run sync-mcp.ps1 with ExecutionPolicy Bypass

powershell -ExecutionPolicy Bypass -File "%~dp0sync-mcp.ps1" %*

