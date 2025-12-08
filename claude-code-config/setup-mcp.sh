#!/bin/bash

# Setup MCP Servers cho Claude Code
# Chạy script này để cấu hình MCP servers

echo "=== Claude Code MCP Setup ==="
echo ""

# Kiểm tra Claude Code CLI
if ! command -v claude &> /dev/null; then
    echo "❌ Claude Code CLI chưa được cài đặt"
    echo "   Cài đặt: npm install -g @anthropic-ai/claude-code"
    exit 1
fi

echo "✅ Claude Code CLI đã cài đặt"
echo ""

# Nhập Notion Token
echo "Nhập Notion Integration Token (hoặc Enter để bỏ qua):"
read -r NOTION_TOKEN

if [ -n "$NOTION_TOKEN" ]; then
    # Tạo file .mcp.json với token thực
    cat > ../.mcp.json << EOF
{
  "mcpServers": {
    "notionApi": {
      "command": "npx",
      "args": ["-y", "@notionhq/notion-mcp-server"],
      "env": {
        "OPENAPI_MCP_HEADERS": "{\"Authorization\": \"Bearer $NOTION_TOKEN\", \"Notion-Version\": \"2022-06-28\"}"
      }
    },
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "$(pwd)/.."]
    },
    "fetch": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-fetch"]
    }
  }
}
EOF
    echo "✅ Đã tạo ../.mcp.json với Notion token"
else
    # Copy file mẫu
    cp .mcp.json ../.mcp.json
    echo "✅ Đã copy .mcp.json mẫu vào root (cần thay thế token thủ công)"
fi

echo ""
echo "=== Setup hoàn tất ==="
echo ""
echo "Kiểm tra MCP servers:"
echo "  claude mcp list"
echo ""
echo "Khởi động Claude Code:"
echo "  cd .. && claude"
