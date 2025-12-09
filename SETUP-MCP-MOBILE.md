# Hướng Dẫn Cấu Hình MCP Từ Điện Thoại (Mobile MCP Setup Guide)

> **MỤC ĐÍCH:** Hướng dẫn tạo file cấu hình MCP và cấp quyền Notion Integration

---

## ⚙️ PHẦN 1: CẤU HÌNH QUYỀN NOTION INTEGRATION (Quan trọng!)

> **LƯU Ý:** Quyền được cấu hình trong Notion, KHÔNG phải trong file .mcp.json

### Bước 1.1: Vào Notion Integrations
👉 **[Notion My Integrations](https://www.notion.so/my-integrations)**

### Bước 1.2: Chọn Integration của anh (hoặc tạo mới)

### Bước 1.3: Vào tab "Capabilities" và BẬT các quyền sau:

| Quyền | Trạng thái | Mô tả |
|-------|-----------|-------|
| **Read content** | ✅ BẬT | Đọc nội dung pages/databases |
| **Update content** | ✅ BẬT | Cập nhật nội dung |
| **Insert content** | ✅ BẬT | Thêm nội dung mới |
| **Read comments** | ✅ BẬT | Đọc comments |
| **Create comments** | ✅ BẬT | Tạo comments |
| **Read user information** | ✅ BẬT | Đọc thông tin user (bao gồm email) |

> ⚠️ **Lưu ý:** MCP Server KHÔNG hỗ trợ Delete - nên không cần lo về việc xóa dữ liệu

### Bước 1.4: Vào tab "Access" - Cấp quyền truy cập Pages

1. Bấm **"Edit access"**
2. Chọn **tất cả pages/databases** mà anh muốn Claude Code truy cập
3. Hoặc chọn **"All pages"** để cấp full quyền

---

## 📱 PHẦN 2: TẠO FILE CẤU HÌNH

### Bước 2.1: Tạo GitHub Gist Riêng Tư
👉 **[Tạo Gist Mới](https://gist.github.com/new)**

### Bước 2.2: Điền thông tin
- **Filename:** `.mcp.json`
- **Nội dung:** Copy template bên dưới

### Bước 2.3: Chọn **"Create secret gist"** (nút bên phải)

---

## 📋 TEMPLATE MCP CONFIG (Đã tối ưu)

```json
{
  "mcpServers": {
    "notionApi": {
      "command": "npx",
      "args": ["-y", "@notionhq/notion-mcp-server"],
      "env": {
        "NOTION_TOKEN": "ntn_XXXXX_YOUR_TOKEN_HERE"
      }
    },
    "claude-context": {
      "command": "npx",
      "args": ["-y", "@zilliz/claude-context-mcp@latest"],
      "env": {
        "OPENAI_API_KEY": "sk-XXXXX_YOUR_KEY_HERE"
      }
    }
  }
}
```

---

## 🔑 THAY THẾ TOKENS

| Placeholder | Thay bằng | Lấy ở đâu |
|-------------|-----------|-----------|
| `ntn_XXXXX_YOUR_TOKEN_HERE` | Token Notion | [Notion Integrations](https://www.notion.so/my-integrations) → Chọn Integration → Copy "Internal Integration Secret" |
| `sk-XXXXX_YOUR_KEY_HERE` | API Key OpenAI | [OpenAI API Keys](https://platform.openai.com/api-keys) |

---

## 💻 PHẦN 3: KHI VỀ MÁY TÍNH

### Bước 3.1: Copy từ Gist
1. Mở Gist đã tạo
2. Copy toàn bộ nội dung

### Bước 3.2: Tạo file .mcp.json
```
CURSOR\.mcp.json
```
Paste nội dung vào file

### Bước 3.3: Chạy script đồng bộ
```cmd
sync-mcp.bat cursor-to-claude
```

### Bước 3.4: Khởi động lại
- Đóng và mở lại **Cursor**
- Đóng và mở lại **Claude Code**

### Bước 3.5: Test MCP
Trong Claude Code, thử hỏi:
```
Hãy liệt kê các databases trong Notion của tôi
```

---

## ✅ CHECKLIST KIỂM TRA

### Notion Integration:
- [ ] Đã bật Read content
- [ ] Đã bật Update content
- [ ] Đã bật Insert content
- [ ] Đã bật Read comments
- [ ] Đã bật Create comments
- [ ] Đã bật Read user information
- [ ] Đã cấp Access cho các pages cần thiết

### File .mcp.json:
- [ ] Đã thay NOTION_TOKEN bằng token thật
- [ ] Đã thay OPENAI_API_KEY bằng key thật
- [ ] Đã lưu file trong thư mục CURSOR

### Đồng bộ:
- [ ] Đã chạy sync-mcp.bat cursor-to-claude
- [ ] Đã khởi động lại Cursor
- [ ] Đã khởi động lại Claude Code

---

## ⚠️ LƯU Ý BẢO MẬT

- ✅ **Luôn dùng Secret Gist** (riêng tư)
- ✅ **Xóa Gist** sau khi copy xong
- ❌ **KHÔNG** paste tokens vào GitHub repo công khai
- ❌ **KHÔNG** chia sẻ tokens cho người khác

---

## 🔗 LINKS NHANH

| Mục đích | Link |
|----------|------|
| Tạo Gist mới | [gist.github.com/new](https://gist.github.com/new) |
| Notion Integrations | [notion.so/my-integrations](https://www.notion.so/my-integrations) |
| OpenAI API Keys | [platform.openai.com/api-keys](https://platform.openai.com/api-keys) |
| Notion MCP Docs | [developers.notion.com/docs/mcp](https://developers.notion.com/docs/mcp) |

---

## 📚 THAM KHẢO

- [Official Notion MCP Server - GitHub](https://github.com/makenotion/notion-mcp-server)
- [Notion MCP Getting Started](https://developers.notion.com/docs/get-started-with-mcp)

---

*Cập nhật: 09/12/2025*
