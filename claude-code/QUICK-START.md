# Hướng Dẫn Nhanh - Claude Code MCP (Quick Start Guide)

> **MỤC ĐÍCH:** Hướng dẫn nhanh cấu hình MCP cho Claude Code (Claude Desktop).

---

## ✅ ĐÃ HOÀN THÀNH

- ✅ **Folder `claude-code/`** đã được tạo
- ✅ **File `.mcp.json`** đã được tạo với tokens từ Cursor
- ✅ **File đã được copy** vào vị trí Claude Code: `%APPDATA%\Claude\mcp.json`

---

## 🔐 VỀ GITHUB SECRETS

**GitHub Secrets KHÔNG thể dùng trực tiếp cho MCP local:**

- ✅ GitHub Secrets có: `NOTION_TOKEN`, `OPENAI_API_KEY`
- ❌ Nhưng chỉ dùng được trong **GitHub Actions workflows**
- ❌ MCP local (Cursor/Claude Code) **KHÔNG thể** truy cập GitHub Secrets
- ✅ **Giải pháp:** Đã copy tokens từ file `.mcp.json` của Cursor vào Claude Code

---

## 🚀 BƯỚC TIẾP THEO

### 1. Khởi động lại Claude Code

Sau khi file `mcp.json` đã được copy vào `%APPDATA%\Claude\`, khởi động lại Claude Code.

### 2. Test MCP trong Claude Code

Sau khi khởi động lại, test trong Claude Code chat:

```
Test Notion MCP: Hãy liệt kê các teams trong Notion workspace
```

```
Test Claude Context: Hãy đọc knowledge graph hiện tại
```

---

## 📁 VỊ TRÍ FILES

**Trong repository:**
- `claude-code/.mcp.json` - File cấu hình (có tokens)
- `claude-code/README.md` - Hướng dẫn chi tiết
- `claude-code/setup-claude-mcp.ps1` - Script setup

**Trong Claude Code:**
- `%APPDATA%\Claude\mcp.json` - File cấu hình thực tế (đã copy)

---

## ⚠️ LƯU Ý

- File `claude-code/.mcp.json` chứa tokens thực tế → **KHÔNG commit lên GitHub**
- Nên thêm `claude-code/.mcp.json` vào `.gitignore` nếu cần
- File trong `%APPDATA%\Claude\mcp.json` là file thực tế Claude Code sử dụng

---

*Cập nhật: 08/12/2025*

