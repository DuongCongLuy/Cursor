# Script Dong Bo MCP Config giua Cursor va Claude Code
# MCP Config Sync Script between Cursor and Claude Code

param(
    [Parameter(Mandatory=$false)]
    [ValidateSet("cursor-to-claude", "claude-to-cursor", "both", "check")]
    [string]$Direction = "check"
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  DONG BO MCP CONFIG" -ForegroundColor Cyan
Write-Host "  MCP Config Sync" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Duong dan files
$cursorConfig = ".mcp.json"
$claudeCodeConfig = "$env:APPDATA\Claude\mcp.json"
$claudeCodeBackup = "claude-code\.mcp.json"

# Kiem tra files ton tai
$cursorExists = Test-Path $cursorConfig
$claudeExists = Test-Path $claudeCodeConfig
$backupExists = Test-Path $claudeCodeBackup

Write-Host "Vi tri files:" -ForegroundColor Cyan
Write-Host "   Cursor: $cursorConfig" -ForegroundColor Gray
Write-Host "   Claude Code: $claudeCodeConfig" -ForegroundColor Gray
Write-Host "   Backup: $claudeCodeBackup" -ForegroundColor Gray
Write-Host ""

# Ham so sanh 2 files
function Compare-Files {
    param($file1, $file2)
    
    if (-not (Test-Path $file1) -or -not (Test-Path $file2)) {
        return $false
    }
    
    $hash1 = (Get-FileHash $file1 -Algorithm MD5).Hash
    $hash2 = (Get-FileHash $file2 -Algorithm MD5).Hash
    
    return $hash1 -eq $hash2
}

# Ham copy file an toan
function Copy-MCPConfig {
    param($source, $destination, $description)
    
    if (-not (Test-Path $source)) {
        Write-Host "LOI: Khong tim thay file nguon: $source" -ForegroundColor Red
        return $false
    }
    
    try {
        # Tao folder dich neu chua co
        $destFolder = Split-Path $destination -Parent
        if (-not (Test-Path $destFolder)) {
            New-Item -ItemType Directory -Path $destFolder -Force | Out-Null
        }
        
        Copy-Item $source $destination -Force
        Write-Host "THANH CONG: Da copy: $description" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "LOI khi copy: $_" -ForegroundColor Red
        return $false
    }
}

# Kiem tra trang thai
if ($Direction -eq "check" -or $Direction -eq "both") {
    Write-Host "Kiem tra trang thai dong bo..." -ForegroundColor Cyan
    Write-Host ""
    
    $cursorClaudeSame = Compare-Files $cursorConfig $claudeCodeConfig
    $cursorBackupSame = Compare-Files $cursorConfig $claudeCodeBackup
    $claudeBackupSame = Compare-Files $claudeCodeConfig $claudeCodeBackup
    
    Write-Host "Ket qua so sanh:" -ForegroundColor Cyan
    Write-Host "   Cursor <-> Claude Code: $(if ($cursorClaudeSame) { 'DONG BO' } else { 'KHAC NHAU' })" -ForegroundColor $(if ($cursorClaudeSame) { 'Green' } else { 'Yellow' })
    Write-Host "   Cursor <-> Backup: $(if ($cursorBackupSame) { 'DONG BO' } else { 'KHAC NHAU' })" -ForegroundColor $(if ($cursorBackupSame) { 'Green' } else { 'Yellow' })
    Write-Host "   Claude Code <-> Backup: $(if ($claudeBackupSame) { 'DONG BO' } else { 'KHAC NHAU' })" -ForegroundColor $(if ($claudeBackupSame) { 'Green' } else { 'Yellow' })
    Write-Host ""
}

# Dong bo tu Cursor sang Claude Code
if ($Direction -eq "cursor-to-claude" -or $Direction -eq "both") {
    Write-Host "Dong bo tu Cursor -> Claude Code..." -ForegroundColor Cyan
    Write-Host ""
    
    $success1 = Copy-MCPConfig $cursorConfig $claudeCodeConfig "Cursor -> Claude Code"
    $success2 = Copy-MCPConfig $cursorConfig $claudeCodeBackup "Cursor -> Backup"
    
    if ($success1 -and $success2) {
        Write-Host ""
        Write-Host "Hoan tat dong bo!" -ForegroundColor Green
    }
}

# Dong bo tu Claude Code sang Cursor
if ($Direction -eq "claude-to-cursor" -or $Direction -eq "both") {
    Write-Host "Dong bo tu Claude Code -> Cursor..." -ForegroundColor Cyan
    Write-Host ""
    
    $success1 = Copy-MCPConfig $claudeCodeConfig $cursorConfig "Claude Code -> Cursor"
    $success2 = Copy-MCPConfig $claudeCodeConfig $claudeCodeBackup "Claude Code -> Backup"
    
    if ($success1 -and $success2) {
        Write-Host ""
        Write-Host "Hoan tat dong bo!" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  HUONG DAN SU DUNG" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Kiem tra trang thai:" -ForegroundColor White
Write-Host "  .\sync-mcp.ps1 -Direction check" -ForegroundColor Gray
Write-Host ""
Write-Host "Dong bo tu Cursor -> Claude Code:" -ForegroundColor White
Write-Host "  .\sync-mcp.ps1 -Direction cursor-to-claude" -ForegroundColor Gray
Write-Host ""
Write-Host "Dong bo tu Claude Code -> Cursor:" -ForegroundColor White
Write-Host "  .\sync-mcp.ps1 -Direction claude-to-cursor" -ForegroundColor Gray
Write-Host ""
Write-Host "Dong bo 2 chieu (kiem tra + dong bo):" -ForegroundColor White
Write-Host "  .\sync-mcp.ps1 -Direction both" -ForegroundColor Gray
Write-Host ""