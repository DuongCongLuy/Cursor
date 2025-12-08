# Cấu Hình MCP cho Claude Code (Claude Desktop)

> **MỤC ĐÍCH:** Hướng dẫn cấu hình MCP (Model Context Protocol) servers cho Claude Code (Claude Desktop).

---

## 📋 TỔNG QUAN (Overview)

Folder này chứa cấu hình MCP riêng cho **Claude Code (Claude Desktop)**, tách biệt với cấu hình MCP của Cursor.

**2 MCP servers được cấu hình:**
1. **Notion MCP** - Kết nối với Notion workspace
2. **Claude Context MCP** - Knowledge Graph và Context management

---

## ⚠️ VỀ GITHUB SECRETS

**GitHub Secrets KHÔNG thể dùng trực tiếp cho MCP local:**

- GitHub Secrets chỉ dùng được trong **GitHub Actions workflows**
- MCP trong Claude Code chạy **local**, không thể truy cập GitHub Secrets
- **Cần nhập tokens/API keys thủ công** vào file `.mcp.json`

---

## 🛠️ CÁCH CẤU HÌNH

### Bước 1: Lấy Tokens từ GitHub Secrets (nếu cần)

Nếu bạn muốn dùng cùng tokens như trong GitHub Secrets:

1. Vào GitHub repository: `https://github.com/DuongCongLuy/Cursor`
2. Vào **Settings** → **Secrets and variables** → **Actions**
3. Xem giá trị của:
   - `NOTION_TOKEN`
   - `OPENAI_API_KEY`

⚠️ **Lưu ý:** GitHub Secrets chỉ hiển thị khi tạo mới, không thể xem lại giá trị cũ. Nếu đã tạo trước đó, bạn cần:
- Tạo lại token/key mới, hoặc
- Dùng tokens/keys đã lưu ở nơi khác

### Bước 2: Cập nhật file `.mcp.json`

1. Mở file `claude-code/.mcp.json`
2. Thay thế:
   - `YOUR_NOTION_TOKEN_HERE` → Notion token thực tế
   - `YOUR_OPENAI_API_KEY_HERE` → OpenAI API key thực tế
3. Lưu file

### Bước 3: Copy file vào vị trí Claude Code

**Vị trí cấu hình MCP cho Claude Desktop:**

**Windows:**
```
%APPDATA%\Claude\mcp.json
```
Hoặc:
```
C:\Users\<username>\AppData\Roaming\Claude\mcp.json
```

**macOS:**
```
~/Library/Application Support/Claude/mcp.json
```

**Linux:**
```
~/.config/claude-desktop/mcp.json
```

**Cách làm:**
1. Copy file `claude-code/.mcp.json` 
2. Paste vào vị trí trên (tạo folder nếu chưa có)
3. Đổi tên thành `mcp.json` (không có dấu chấm đầu)

### Bước 4: Khởi động lại Claude Code

Sau khi copy file, khởi động lại Claude Code để MCP servers được load.

---

## ✅ KIỂM TRA MCP HOẠT ĐỘNG

Sau khi khởi động lại Claude Code, test trong chat:

```
Test Notion MCP: Hãy liệt kê các teams trong Notion workspace
```

```
Test Claude Context: Hãy đọc knowledge graph hiện tại
```

---

## 📚 TÀI LIỆU THAM KHẢO

- [Claude Desktop MCP Setup](https://docs.anthropic.com/claude/docs/mcp)
- [Notion MCP Server](https://github.com/notionhq/notion-mcp-server)
- [Claude Context MCP](https://github.com/zilliztech/claude-context-mcp)

---

*Cập nhật: 08/12/2025*

