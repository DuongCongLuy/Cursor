# Cursor Repository

Repository cấu hình MCP (Model Context Protocol) servers cho Cursor IDE.

## 📋 Tổng Quan (Overview)

Repository này chứa:
- Cấu hình mẫu cho 2 MCP servers: **Notion MCP** và **Claude Context MCP**
- Script tự động setup MCP từ GitHub Secrets
- GitHub Actions workflow để kiểm tra cấu hình
- Hướng dẫn kết nối **Docker MCP Toolkit** với các AI clients

## 🚀 Bắt Đầu (Getting Started)

### Cách 1: Docker MCP Toolkit (Recommended - GUI)

Sử dụng Docker Desktop với MCP Toolkit extension:
1. Cài đặt **Docker Desktop 4.42+**
2. Vào **Extensions** → **MCP Toolkit**
3. Kích hoạt MCP servers và kết nối clients

📚 **Xem hướng dẫn chi tiết trong [DOCKER-MCP-TOOLKIT.md](DOCKER-MCP-TOOLKIT.md)**

### Cách 2: Sử dụng Script Tự Động

```powershell
# Chạy script setup
.\setup-mcp.ps1
```

Script sẽ:
- Tạo file `.mcp.json` từ template
- Hướng dẫn nhập tokens/API keys
- Tự động cập nhật cấu hình

### Cách 3: Setup Thủ Công

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
├── .mcp.json              # File cấu hình thực tế (bị gitignore) ⭐ Source of Truth
├── sync-mcp.ps1           # Script đồng bộ MCP giữa Cursor và Claude Code
├── setup-mcp.ps1          # Script tự động setup
├── SETUP.md               # Hướng dẫn chi tiết
├── MCP-MANAGEMENT.md      # Hướng dẫn quản lý và đồng bộ MCP
├── QUICK-START.md         # Hướng dẫn nhanh
├── CLAUDE.md              # System Builder Instructions
├── claude-code/           # Folder cấu hình cho Claude Code
│   ├── .mcp.json          # Backup config (bị gitignore)
│   ├── README.md          # Hướng dẫn Claude Code
│   ├── QUICK-START.md     # Hướng dẫn nhanh
│   └── setup-claude-mcp.ps1
└── .github/
    └── workflows/
        └── test-mcp.yml   # GitHub Actions workflow kiểm tra cấu hình
```

## ✅ Kiểm Tra MCP Hoạt Động

Sau khi setup, test trong Cursor chat:
- `Test Notion MCP: Hãy liệt kê các teams trong Notion workspace`
- `Test Claude Context: Hãy đọc knowledge graph hiện tại`

## 🔄 Đồng Bộ MCP Config

Sử dụng script để đồng bộ config giữa Cursor và Claude Code:

```powershell
# Kiểm tra trạng thái
.\sync-mcp.ps1 -Direction check

# Đồng bộ từ Cursor → Claude Code
.\sync-mcp.ps1 -Direction cursor-to-claude
```

📚 **Xem [MCP-MANAGEMENT.md](MCP-MANAGEMENT.md) để biết chi tiết về quản lý và đồng bộ.**

## 📚 Tài Liệu Tham Khảo

- [DOCKER-MCP-TOOLKIT.md](DOCKER-MCP-TOOLKIT.md) - **Hướng dẫn Docker MCP Toolkit (GUI)**
- [MCP-MANAGEMENT.md](MCP-MANAGEMENT.md) - Quản lý và đồng bộ MCP config
- [SETUP.md](SETUP.md) - Hướng dẫn setup chi tiết
- [QUICK-START.md](QUICK-START.md) - Hướng dẫn nhanh
- [CLAUDE.md](CLAUDE.md) - System Builder Instructions
- [Docker MCP Toolkit Docs](https://docs.docker.com/desktop/extensions/mcp-toolkit/) - Tài liệu chính thức
- [Notion MCP Server](https://github.com/notionhq/notion-mcp-server)
- [Claude Context MCP](https://github.com/zilliztech/claude-context-mcp)

---

*Cập nhật: 14/12/2025*