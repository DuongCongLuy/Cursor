# Hướng Dẫn Nhanh (Quick Start Guide)

> **MỤC ĐÍCH:** Hướng dẫn nhanh để bắt đầu sử dụng MCP servers trong Cursor.

---

## ✅ TRẠNG THÁI HIỆN TẠI (Current Status)

- ✅ **GitHub Secrets:** Đã có 2 secrets (`NOTION_TOKEN`, `OPENAI_API_KEY`)
- ✅ **File Template:** Đã có `.mcp.json.example`
- ✅ **File Cấu Hình:** Đã tạo `.mcp.json` từ template
- ⚠️ **Cần:** Nhập tokens vào file `.mcp.json` để sử dụng local

---

## 🚀 BƯỚC TIẾP THEO (Next Steps)

### Cách 1: Sử dụng Script Tự Động (Recommended)

```powershell
.\setup-mcp.ps1
```

Script sẽ hướng dẫn bạn nhập tokens và tự động cập nhật file `.mcp.json`.

### Cách 2: Chỉnh Sửa Thủ Công

1. Mở file `.mcp.json`
2. Thay thế:
   - `YOUR_NOTION_TOKEN_HERE` → Notion token thực tế
   - `YOUR_OPENAI_API_KEY_HERE` → OpenAI API key thực tế
3. Lưu file

---

## 🧪 TEST SAU KHI SETUP

Sau khi cấu hình xong và khởi động lại Cursor, test trong chat:

```
Test Notion MCP: Hãy liệt kê các teams trong Notion workspace
```

```
Test Claude Context: Hãy đọc knowledge graph hiện tại
```

---

## 📚 TÀI LIỆU CHI TIẾT

Xem [SETUP.md](SETUP.md) để biết hướng dẫn chi tiết.

---

*Cập nhật: 08/12/2025*

