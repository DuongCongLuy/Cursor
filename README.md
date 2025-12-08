# Cursor Repository

Repository cấu hình MCP (Model Context Protocol) servers cho Cursor IDE.

## 📋 Tổng Quan (Overview)

Repository này chứa:
- Cấu hình mẫu cho 2 MCP servers: **Notion MCP** và **Claude Context MCP**
- Script tự động setup MCP từ GitHub Secrets
- GitHub Actions workflow để kiểm tra cấu hình

## 🚀 Bắt Đầu (Getting Started)

### Cách 1: Sử dụng Script Tự Động (Recommended)

```powershell
# Chạy script setup
.\setup-mcp.ps1
```

Script sẽ:
- Tạo file `.mcp.json` từ template
- Hướng dẫn nhập tokens/API keys
- Tự động cập nhật cấu hình

### Cách 2: Setup Thủ Công

1. Copy file mẫu:
   ```bash
   cp .mcp.json.example .mcp.json
   ```

2. Chỉnh sửa file `.mcp.json` và thay thế:
   - `YOUR_NOTION_TOKEN_HERE` → Notion token thực tế
   - `YOUR_OPENAI_API_KEY_HERE` → OpenAI API key thực tế

3. Khởi động lại Cursor

📚 **Xem hướng dẫn chi tiết trong [SETUP.md](SETUP.md)**

## 🔐 GitHub Secrets

Repository sử dụng 2 GitHub Secrets:
- `NOTION_TOKEN` - Notion Integration Token
- `OPENAI_API_KEY` - OpenAI API Key

⚠️ **Lưu ý:** GitHub Secrets chỉ dùng được trong GitHub Actions workflows, không thể truy cập từ local. Để dùng MCP trong Cursor local, bạn cần tạo file `.mcp.json` và nhập tokens thủ công.

## 📁 Cấu Trúc Files

```
.
├── .mcp.json.example      # Template cấu hình MCP (không chứa secrets)
├── .mcp.json              # File cấu hình thực tế (bị gitignore)
├── setup-mcp.ps1          # Script tự động setup
├── SETUP.md               # Hướng dẫn chi tiết
├── CLAUDE.md              # System Builder Instructions
└── .github/
    └── workflows/
        └── test-mcp.yml   # GitHub Actions workflow kiểm tra cấu hình
```

## ✅ Kiểm Tra MCP Hoạt Động

Sau khi setup, test trong Cursor chat:
- `Test Notion MCP: Hãy liệt kê các teams trong Notion workspace`
- `Test Claude Context: Hãy đọc knowledge graph hiện tại`

## 📚 Tài Liệu Tham Khảo

- [SETUP.md](SETUP.md) - Hướng dẫn setup chi tiết
- [CLAUDE.md](CLAUDE.md) - System Builder Instructions
- [Notion MCP Server](https://github.com/notionhq/notion-mcp-server)
- [Claude Context MCP](https://github.com/zilliztech/claude-context-mcp)

---

*Cập nhật: 08/12/2025*