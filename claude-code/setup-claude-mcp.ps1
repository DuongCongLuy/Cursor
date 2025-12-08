# Script Cấu Hình MCP cho Claude Code
# MCP Setup Script for Claude Code

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  CẤU HÌNH MCP CHO CLAUDE CODE" -ForegroundColor Cyan
Write-Host "  MCP Setup for Claude Code" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Kiểm tra file .mcp.json có tồn tại không
if (-not (Test-Path ".mcp.json")) {
    Write-Host "❌ LỖI: Không tìm thấy file .mcp.json" -ForegroundColor Red
    exit 1
}

# Hướng dẫn nhập tokens
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  NHẬP TOKENS/API KEYS" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "⚠️  LƯU Ý: GitHub Secrets KHÔNG thể dùng trực tiếp cho MCP local" -ForegroundColor Yellow
Write-Host "   Bạn cần nhập tokens thủ công vào file .mcp.json" -ForegroundColor Yellow
Write-Host ""
Write-Host "📝 Để lấy tokens từ GitHub Secrets:" -ForegroundColor Cyan
Write-Host "   1. Vào GitHub → Settings → Secrets → Actions" -ForegroundColor Gray
Write-Host "   2. Tạo lại secret mới (vì không thể xem giá trị cũ)" -ForegroundColor Gray
Write-Host "   3. Hoặc dùng tokens/keys đã lưu ở nơi khác" -ForegroundColor Gray
Write-Host ""

# Nhập Notion Token
Write-Host "1️⃣  NOTION TOKEN" -ForegroundColor Cyan
Write-Host "   Lấy từ: Notion → Settings → Connections → Integrations" -ForegroundColor Gray
Write-Host "   Hoặc: GitHub Secrets → NOTION_TOKEN" -ForegroundColor Gray
$notionToken = Read-Host "   Nhập Notion Token (hoặc Enter để bỏ qua)"

# Nhập OpenAI API Key
Write-Host ""
Write-Host "2️⃣  OPENAI API KEY" -ForegroundColor Cyan
Write-Host "   Lấy từ: https://platform.openai.com/api-keys" -ForegroundColor Gray
Write-Host "   Hoặc: GitHub Secrets → OPENAI_API_KEY" -ForegroundColor Gray
$openaiKey = Read-Host "   Nhập OpenAI API Key (hoặc Enter để bỏ qua)"

# Cập nhật file .mcp.json
if ($notionToken -or $openaiKey) {
    Write-Host ""
    Write-Host "📝 Đang cập nhật file .mcp.json..." -ForegroundColor Green
    
    $mcpContent = Get-Content ".mcp.json" -Raw | ConvertFrom-Json
    
    if ($notionToken) {
        $headers = @{
            "Authorization" = "Bearer $notionToken"
            "Notion-Version" = "2022-06-28"
        }
        $headersJson = ($headers | ConvertTo-Json -Compress).Replace('"', '\"')
        $mcpContent.mcpServers.notionApi.env.OPENAPI_MCP_HEADERS = "{$headersJson}"
        Write-Host "   ✅ Đã cập nhật Notion Token" -ForegroundColor Green
    }
    
    if ($openaiKey) {
        $mcpContent.mcpServers."claude-context".env.OPENAI_API_KEY = $openaiKey
        Write-Host "   ✅ Đã cập nhật OpenAI API Key" -ForegroundColor Green
    }
    
    $mcpContent | ConvertTo-Json -Depth 10 | Set-Content ".mcp.json"
    Write-Host ""
    Write-Host "✅ Hoàn tất cấu hình!" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "⚠️  Bạn chưa nhập tokens. Vui lòng chỉnh sửa file .mcp.json thủ công." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  BƯỚC TIẾP THEO" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Copy file .mcp.json vào vị trí Claude Code:" -ForegroundColor White
Write-Host "   Windows: %APPDATA%\Claude\mcp.json" -ForegroundColor Gray
Write-Host "   macOS: ~/Library/Application Support/Claude/mcp.json" -ForegroundColor Gray
Write-Host "   Linux: ~/.config/claude-desktop/mcp.json" -ForegroundColor Gray
Write-Host ""
Write-Host "2. Đổi tên file thành 'mcp.json' (không có dấu chấm đầu)" -ForegroundColor White
Write-Host ""
Write-Host "3. Khởi động lại Claude Code" -ForegroundColor White
Write-Host ""
Write-Host "📚 Xem thêm hướng dẫn trong file README.md" -ForegroundColor Cyan
Write-Host ""

