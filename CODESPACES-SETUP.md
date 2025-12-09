# Hướng Dẫn Sử Dụng GitHub Codespaces với MCP

> **MỤC ĐÍCH:** Chạy Claude Code với MCP (Notion, OpenAI) hoàn toàn trên browser

---

## 📱 BƯỚC 1: THÊM SECRETS (Chỉ làm 1 lần)

### 1.1. Vào trang Codespaces Secrets:

👉 **[Thêm Secrets Tại Đây](https://github.com/DuongCongLuy/Cursor/settings/secrets/codespaces)**

Hoặc: Repository → Settings → Secrets and variables → Codespaces

### 1.2. Thêm 2 secrets sau:

| Name | Value | Lấy ở đâu |
|------|-------|-----------|
| `NOTION_TOKEN` | `ntn_xxx...` | [notion.so/my-integrations](https://www.notion.so/my-integrations) |
| `OPENAI_API_KEY` | `sk-xxx...` | [platform.openai.com/api-keys](https://platform.openai.com/api-keys) |

### 1.3. Cách thêm từng secret:

1. Bấm **"New repository secret"**
2. **Name:** `NOTION_TOKEN`
3. **Value:** Paste token của anh
4. Bấm **"Add secret"**
5. Lặp lại cho `OPENAI_API_KEY`

---

## 🚀 BƯỚC 2: TẠO CODESPACE

### Cách 1: Từ điện thoại/browser

1. Vào repo: [github.com/DuongCongLuy/Cursor](https://github.com/DuongCongLuy/Cursor)
2. Bấm nút **"<> Code"** (màu xanh)
3. Chọn tab **"Codespaces"**
4. Bấm **"Create codespace on main"**

### Cách 2: Link trực tiếp

👉 **[Tạo Codespace Ngay](https://github.com/codespaces/new?repo=DuongCongLuy/Cursor)**

---

## ⏳ BƯỚC 3: CHỜ KHỞI ĐỘNG

- Lần đầu: ~2-3 phút (cài đặt môi trường)
- Lần sau: ~30-60 giây

Codespace sẽ tự động:
1. Tạo môi trường Ubuntu
2. Cài Node.js
3. Chạy script tạo `.mcp.json` từ secrets

---

## ✅ BƯỚC 4: SỬ DỤNG

### Kiểm tra MCP đã hoạt động:

```bash
cat .mcp.json
```

Nếu thấy file với tokens → MCP đã sẵn sàng!

### Chạy Claude Code:

```bash
claude
```

### Test Notion MCP:

Hỏi Claude: "Liệt kê các databases trong Notion của tôi"

---

## 🔧 XỬ LÝ LỖI

### Lỗi: "Secrets not found"

**Nguyên nhân:** Chưa thêm secrets hoặc chưa rebuild

**Cách fix:**
1. Kiểm tra đã thêm secrets chưa
2. Rebuild Codespace:
   - Bấm F1 → "Codespaces: Rebuild Container"
   - Hoặc: Menu ☰ → "Codespaces" → "Rebuild Container"

### Lỗi: MCP không kết nối Notion

**Nguyên nhân:** Token không có quyền hoặc chưa connect pages

**Cách fix:**
1. Vào [notion.so/my-integrations](https://www.notion.so/my-integrations)
2. Chọn Integration
3. Tab "Capabilities" → Bật tất cả quyền
4. Tab "Access" → Chọn pages cần truy cập

---

## 💰 GIỚI HẠN MIỄN PHÍ

| Loại | Giới hạn/tháng |
|------|----------------|
| **Core hours** | 120 giờ |
| **Storage** | 15 GB |

**Tính toán:**
- 2-core machine = 2 core-hours/giờ sử dụng
- 120 ÷ 2 = **60 giờ sử dụng/tháng**

**Tiết kiệm:**
- Đóng Codespace khi không dùng
- Dùng máy 2-core (mặc định)

---

## 🔗 LINKS NHANH

| Mục đích | Link |
|----------|------|
| Thêm Secrets | [Codespaces Secrets](https://github.com/DuongCongLuy/Cursor/settings/secrets/codespaces) |
| Tạo Codespace | [New Codespace](https://github.com/codespaces/new?repo=DuongCongLuy/Cursor) |
| Quản lý Codespaces | [Your Codespaces](https://github.com/codespaces) |
| Notion Integrations | [notion.so/my-integrations](https://www.notion.so/my-integrations) |
| OpenAI API Keys | [platform.openai.com/api-keys](https://platform.openai.com/api-keys) |

---

## 📋 CHECKLIST

### Lần đầu setup:
- [ ] Đã thêm `NOTION_TOKEN` vào Codespaces secrets
- [ ] Đã thêm `OPENAI_API_KEY` vào Codespaces secrets
- [ ] Đã cấu hình quyền Notion Integration (Capabilities)
- [ ] Đã connect pages với Notion Integration (Access)

### Mỗi lần dùng:
- [ ] Mở Codespace
- [ ] Chờ khởi động xong
- [ ] Chạy `claude` để bắt đầu

---

*Cập nhật: 09/12/2025*
