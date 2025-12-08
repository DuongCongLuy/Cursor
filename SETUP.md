# Hướng Dẫn Cấu Hình MCP (MCP Setup Guide)

> **MỤC ĐÍCH:** Hướng dẫn chi tiết cách cấu hình MCP (Model Context Protocol) servers từ GitHub Secrets để sử dụng trong Cursor.

---

## 📋 TỔNG QUAN (Overview)

Repository này sử dụng **2 MCP servers**:
1. **Notion MCP** - Kết nối với Notion workspace
2. **Claude Context MCP** - Knowledge Graph và Context management

---

## 🔐 BƯỚC 1: KIỂM TRA GITHUB SECRETS

### 1.1. Xác nhận GitHub Secrets

✅ **Đã có 2 secrets trong repository:**
- `NOTION_TOKEN` - Notion Integration Token (cập nhật: Hôm qua)
- `OPENAI_API_KEY` - OpenAI API Key cho Claude Context MCP (cập nhật: Hôm qua)

⚠️ **Lưu ý:** GitHub Secrets chỉ dùng được trong GitHub Actions workflows, không thể truy cập từ local Cursor.

### 1.2. Nếu cần thêm mới hoặc cập nhật:

**Thêm NOTION_TOKEN:**
1. Vào Notion → **Settings & Members** → **Connections** → **Develop or manage integrations**
2. Tạo Integration mới hoặc dùng Integration có sẵn
3. Copy **Internal Integration Token**
4. Vào GitHub Secrets → **New repository secret**
   - Name: `NOTION_TOKEN`
   - Secret: `[Paste token ở đây]`
   - Click **Add secret**

**Thêm OPENAI_API_KEY:**
1. Vào [OpenAI Platform](https://platform.openai.com/api-keys)
2. Tạo API key mới hoặc dùng key có sẵn
3. Vào GitHub Secrets → **New repository secret**
   - Name: `OPENAI_API_KEY`
   - Secret: `[Paste API key ở đây]`
   - Click **Add secret**

---

## 🛠️ BƯỚC 2: TẠO FILE CẤU HÌNH LOCAL

### 2.1. Sử dụng Script Tự Động (Recommended)

Chạy script PowerShell để tự động setup:

```powershell
.\setup-mcp.ps1
```

Script sẽ:
- Tạo file `.mcp.json` từ template
- Hướng dẫn nhập tokens/API keys
- Tự động cập nhật cấu hình

### 2.2. Hoặc Setup Thủ Công

**Copy file mẫu:**
```bash
cp .mcp.json.example .mcp.json
```

**Cập nhật file `.mcp.json`:**

Mở file `.mcp.json` và thay thế:

**Cho Notion MCP:**
- Thay `YOUR_NOTION_TOKEN_HERE` bằng Notion token thực tế

**Cho Claude Context MCP:**
- Thay `YOUR_OPENAI_API_KEY_HERE` bằng OpenAI API key thực tế

**File hoàn chỉnh sẽ trông như sau:**

```json
{
  "mcpServers": {
    "notionApi": {
      "command": "npx",
      "args": ["-y", "@notionhq/notion-mcp-server"],
      "env": {
        "OPENAPI_MCP_HEADERS": "{\"Authorization\": \"Bearer secret_abc123...\", \"Notion-Version\": \"2022-06-28\"}"
      }
    },
    "claude-context": {
      "command": "npx",
      "args": ["-y", "@zilliz/claude-context-mcp@latest"],
      "env": {
        "OPENAI_API_KEY": "sk-abc123..."
      }
    }
  }
}
```

---

## ⚙️ BƯỚC 3: CẤU HÌNH TRONG CURSOR

### 3.1. Mở Cursor Settings

1. Mở Cursor
2. Vào **File** → **Preferences** → **Settings** (hoặc `Ctrl+,`)
3. Tìm **MCP** hoặc **Model Context Protocol**

### 3.2. Cấu hình MCP

Cursor sẽ tự động đọc file `.mcp.json` trong workspace root. Đảm bảo:
- File `.mcp.json` đã được tạo và cấu hình đúng
- Tokens/API keys đã được điền vào

### 3.3. Khởi động lại Cursor

Sau khi cấu hình, khởi động lại Cursor để MCP servers được load.

---

## ✅ BƯỚC 4: KIỂM TRA MCP HOẠT ĐỘNG

### 4.1. Test Notion MCP

Trong Cursor chat, thử:
```
Test Notion MCP: Hãy liệt kê các teams trong Notion workspace
```

### 4.2. Test Claude Context MCP

Trong Cursor chat, thử:
```
Test Claude Context: Hãy đọc knowledge graph hiện tại
```

---

## ⚠️ LƯU Ý QUAN TRỌNG (Important Notes)

### 1. GitHub Secrets vs Local Configuration

- **GitHub Secrets**: Chỉ dùng được trong **GitHub Actions workflows**, không thể truy cập từ local
- **Local `.mcp.json`**: Dùng cho Cursor local, phải tự điền tokens/keys

### 2. Bảo mật (Security)

- **KHÔNG** commit file `.mcp.json` lên GitHub (đã được ignore trong `.gitignore`)
- **KHÔNG** chia sẻ tokens/API keys
- File `.mcp.json.example` chỉ là template, không chứa secrets

### 3. Troubleshooting

**MCP không hoạt động:**
- Kiểm tra file `.mcp.json` có đúng format JSON không
- Kiểm tra tokens/keys có đúng không
- Khởi động lại Cursor
- Kiểm tra console logs trong Cursor

**Notion MCP lỗi:**
- Kiểm tra Notion Integration có quyền truy cập workspace không
- Kiểm tra token có còn hiệu lực không

**Claude Context MCP lỗi:**
- Kiểm tra OpenAI API key có còn hiệu lực không
- Kiểm tra có đủ credits trong OpenAI account không

---

## 📚 TÀI LIỆU THAM KHẢO (References)

- [Notion MCP Server Documentation](https://github.com/notionhq/notion-mcp-server)
- [Claude Context MCP Documentation](https://github.com/zilliztech/claude-context-mcp)
- [Cursor MCP Setup Guide](https://docs.cursor.com/mcp)

---

*Cập nhật: 08/12/2025*

