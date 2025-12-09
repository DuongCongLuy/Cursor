# Hướng Dẫn Cấu Hình MCP Từ Điện Thoại (Mobile MCP Setup Guide)

> **MỤC ĐÍCH:** Hướng dẫn tạo file cấu hình MCP khi không có máy tính

---

## 📱 BƯỚC 1: Tạo GitHub Gist Riêng Tư

1. **Bấm vào link:** [Tạo Gist Mới](https://gist.github.com/new)

2. **Điền thông tin:**
   - **Filename:** `.mcp.json`
   - **Nội dung:** Copy template bên dưới

3. **Chọn:** `Create secret gist` (nút màu xanh bên phải)

---

## 📋 BƯỚC 2: Copy Template Này

```json
{
  "mcpServers": {
    "notionApi": {
      "command": "npx",
      "args": ["-y", "@notionhq/notion-mcp-server"],
      "env": {
        "OPENAPI_MCP_HEADERS": "{\"Authorization\": \"Bearer NOTION_TOKEN_CUA_ANH\", \"Notion-Version\": \"2022-06-28\"}"
      }
    },
    "claude-context": {
      "command": "npx",
      "args": ["-y", "@zilliz/claude-context-mcp@latest"],
      "env": {
        "OPENAI_API_KEY": "OPENAI_API_KEY_CUA_ANH"
      }
    }
  }
}
```

---

## 🔑 BƯỚC 3: Thay Thế Tokens

Trong template trên, thay thế:

| Placeholder | Thay bằng | Lấy ở đâu |
|-------------|-----------|-----------|
| `NOTION_TOKEN_CUA_ANH` | Token Notion (bắt đầu `ntn_...`) | [Notion Integrations](https://www.notion.so/my-integrations) |
| `OPENAI_API_KEY_CUA_ANH` | API Key OpenAI (bắt đầu `sk-...`) | [OpenAI API Keys](https://platform.openai.com/api-keys) |

---

## 💻 BƯỚC 4: Khi Về Máy Tính

1. **Mở Gist** đã tạo ở bước 1
2. **Copy toàn bộ nội dung**
3. **Tạo file mới** trong thư mục project:
   ```
   CURSOR\.mcp.json
   ```
4. **Paste nội dung** vào file
5. **Chạy script đồng bộ:**
   ```cmd
   sync-mcp.bat cursor-to-claude
   ```
6. **Khởi động lại** Cursor và Claude Code

---

## ⚠️ LƯU Ý BẢO MẬT

- ✅ **Luôn dùng Secret Gist** (riêng tư) - không dùng Public Gist
- ✅ **Xóa Gist** sau khi đã copy xong vào máy tính
- ❌ **KHÔNG** paste tokens vào file trên GitHub repo (sẽ bị lộ công khai)
- ❌ **KHÔNG** chia sẻ link Gist cho người khác

---

## 🔗 LINKS NHANH

- [Tạo Gist Mới](https://gist.github.com/new)
- [Notion Integrations](https://www.notion.so/my-integrations)
- [OpenAI API Keys](https://platform.openai.com/api-keys)

---

*Cập nhật: 09/12/2025*
