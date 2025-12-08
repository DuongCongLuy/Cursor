# Cursor MCP Configuration

> Cấu hình MCP servers cho Cursor IDE

## Setup

1. Copy file mẫu:
   ```bash
   cp .mcp.json.example .mcp.json
   ```

2. Thay thế tokens trong `.mcp.json`:
   - `YOUR_NOTION_TOKEN_HERE` → Notion Integration Token
   - `YOUR_OPENAI_API_KEY_HERE` → OpenAI API Key

3. Copy file `.mcp.json` vào root của project hoặc folder làm việc

4. Khởi động lại Cursor

## Test

Trong Cursor chat:
- `Test Notion MCP: Hãy liệt kê các pages trong Notion workspace`
- `Test Claude Context: Hãy đọc knowledge graph hiện tại`
