# Claude Code MCP Configuration

> Cấu hình MCP servers cho Claude Code CLI

## MCP Servers Được Cấu Hình

| Server | Package | Mô tả |
|--------|---------|-------|
| **notionApi** | `@notionhq/notion-mcp-server` | Kết nối Notion workspace |
| **filesystem** | `@modelcontextprotocol/server-filesystem` | Đọc/ghi file system |
| **fetch** | `@modelcontextprotocol/server-fetch` | Fetch URLs |

## Setup

### Cách 1: Copy file cấu hình

1. Cập nhật tokens trong file `.mcp.json`:
   - `YOUR_NOTION_TOKEN_HERE` → Notion Integration Token

2. Copy file `.mcp.json` vào root project:
   ```bash
   cp .mcp.json ../
   ```

3. Hoặc copy vào user config:
   ```bash
   # Thêm vào ~/.claude.json nếu muốn dùng cho tất cả projects
   ```

### Cách 2: Dùng Claude CLI

```bash
# Thêm Notion MCP
claude mcp add notionApi --command "npx -y @notionhq/notion-mcp-server" --scope project

# Thêm Filesystem MCP
claude mcp add filesystem --command "npx -y @modelcontextprotocol/server-filesystem /home/user/Cursor" --scope project

# Thêm Fetch MCP
claude mcp add fetch --command "npx -y @modelcontextprotocol/server-fetch" --scope project

# Kiểm tra danh sách MCP
claude mcp list
```

## Test

```bash
# Kiểm tra MCP servers đã load
claude mcp list

# Test trong Claude Code session
claude
> Hãy liệt kê các MCP tools có sẵn
```

## Lưu Ý

- File `.mcp.json` ở root project được chia sẻ với team (nếu commit)
- File `~/.claude.json` là cấu hình cá nhân
- KHÔNG commit tokens/secrets lên GitHub
