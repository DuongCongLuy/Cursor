# Script Cấu Hình MCP từ GitHub Secrets
# MCP Setup Script from GitHub Secrets

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  CẤU HÌNH MCP SERVERS" -ForegroundColor Cyan
Write-Host "  MCP Servers Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Kiểm tra file .mcp.json.example có tồn tại không
if (-not (Test-Path ".mcp.json.example")) {
    Write-Host "❌ LỖI: Không tìm thấy file .mcp.json.example" -ForegroundColor Red
    exit 1
}

# Kiểm tra file .mcp.json đã tồn tại chưa
if (Test-Path ".mcp.json") {
    Write-Host "⚠️  CẢNH BÁO: File .mcp.json đã tồn tại!" -ForegroundColor Yellow
    $overwrite = Read-Host "Bạn có muốn ghi đè không? (y/n)"
    if ($overwrite -ne "y" -and $overwrite -ne "Y") {
        Write-Host "❌ Hủy bỏ. Giữ nguyên file cũ." -ForegroundColor Red
        exit 0
    }
}

# Copy file mẫu
Write-Host "📋 Đang copy file mẫu..." -ForegroundColor Green
Copy-Item ".mcp.json.example" ".mcp.json"
Write-Host "✅ Đã tạo file .mcp.json" -ForegroundColor Green
Write-Host ""

# Hướng dẫn nhập tokens
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  NHẬP TOKENS/API KEYS" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "⚠️  LƯU Ý: GitHub Secrets chỉ dùng được trong GitHub Actions" -ForegroundColor Yellow
Write-Host "   Để dùng MCP trong Cursor local, bạn cần nhập tokens thủ công" -ForegroundColor Yellow
Write-Host ""
Write-Host "✅ GitHub Secrets đã có: NOTION_TOKEN, OPENAI_API_KEY" -ForegroundColor Green
Write-Host ""

# Nhập Notion Token
Write-Host "1️⃣  NOTION TOKEN" -ForegroundColor Cyan
Write-Host "   Lấy từ: Notion → Settings → Connections → Integrations" -ForegroundColor Gray
$notionToken = Read-Host "   Nhập Notion Token (hoặc Enter để bỏ qua)"

# Nhập OpenAI API Key
Write-Host ""
Write-Host "2️⃣  OPENAI API KEY" -ForegroundColor Cyan
Write-Host "   Lấy từ: https://platform.openai.com/api-keys" -ForegroundColor Gray
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
Write-Host "1. Kiểm tra file .mcp.json đã đúng chưa" -ForegroundColor White
Write-Host "2. Khởi động lại Cursor" -ForegroundColor White
Write-Host "3. Test MCP trong Cursor chat" -ForegroundColor White
Write-Host ""
Write-Host "📚 Xem thêm hướng dẫn trong file SETUP.md" -ForegroundColor Cyan
Write-Host ""

