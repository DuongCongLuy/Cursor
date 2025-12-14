# Docker MCP Toolkit - Hướng Dẫn Kết Nối (Connection Guide)

> **MỤC ĐÍCH:** Hướng dẫn sử dụng Docker MCP Toolkit để kết nối các MCP servers chạy trong Docker containers với các AI clients (Cursor, Claude Code, Claude Desktop).

---

## 📋 TỔNG QUAN (Overview)

**Docker MCP Toolkit** là một extension trong Docker Desktop cho phép:
- Browse và kết nối các MCP servers được Docker hóa
- Quản lý kết nối giữa MCP servers và AI clients
- Sử dụng OAuth để xác thực với các dịch vụ bên ngoài (GitHub, etc.)

### Yêu Cầu (Requirements)

- **Docker Desktop 4.42** hoặc mới hơn
- Các AI clients đã cài đặt: Cursor, Claude Code, hoặc Claude Desktop

---

## 🎯 CÁC THÀNH PHẦN CHÍNH (Main Components)

### 1. MCP Servers

Các MCP servers chạy trong Docker containers, cung cấp tools cho AI clients:

| Server | Tools | Mô tả |
|--------|-------|-------|
| **Memory** | 9 tools | Knowledge graph - tạo entities, relations, observations |
| **Playwright** | 25 tools | Browser automation - điều khiển trình duyệt |
| **YouTube transcripts** | 1 tool | Lấy transcript từ video YouTube |

### 2. MCP Clients

Các AI clients có thể kết nối với MCP Toolkit:

| Client | Trạng thái hỗ trợ |
|--------|------------------|
| **Claude Code** | ✅ Hỗ trợ chính thức |
| **Claude Desktop** | ✅ Hỗ trợ chính thức |
| **Cursor** | ✅ Hỗ trợ chính thức |
| **Gordon** | ✅ Hỗ trợ (Docker AI) |
| **Amazon Q Developer CLI** | ✅ Hỗ trợ |
| **Codex** | ✅ Hỗ trợ |
| **Continue.dev** | ✅ Hỗ trợ |
| **Gemini CLI** | ✅ Hỗ trợ |

### 3. OAuth Providers

Xác thực với các dịch vụ bên ngoài:

| Provider | Mục đích |
|----------|----------|
| **GitHub** | Truy cập repositories, issues, PRs |

---

## 🚀 HƯỚNG DẪN CÀI ĐẶT (Installation Guide)

### Bước 1: Mở Docker MCP Toolkit

1. Mở **Docker Desktop**
2. Vào **Extensions** (menu bên trái)
3. Tìm và cài đặt **MCP Toolkit** (nếu chưa có)
4. Click vào **MCP Toolkit** trong menu Extensions

### Bước 2: Kích hoạt MCP Servers

1. Vào tab **MCP Servers** (hoặc **My servers**)
2. Chọn các servers muốn kích hoạt:
   - Toggle **ON** cho Memory, Playwright, YouTube transcripts, etc.
3. Servers sẽ tự động khởi động trong Docker containers

### Bước 3: Kết nối MCP Clients

1. Vào tab **MCP Clients** (hoặc **Clients**)
2. Tìm client muốn kết nối (Cursor, Claude Code, Claude Desktop)
3. Click **Connect** để kết nối
4. Làm theo hướng dẫn cấu hình (Manual configuration)

### Bước 4: Cấu hình OAuth (Tùy chọn)

1. Vào tab **OAuth**
2. Click **Authorize** cho GitHub (hoặc provider khác)
3. Đăng nhập và cấp quyền
4. Trạng thái sẽ hiển thị **AUTHORIZED**

---

## 🔧 CẤU HÌNH CHI TIẾT (Detailed Configuration)

### Cấu hình cho Cursor

Khi click **Connect** cho Cursor, Docker MCP Toolkit sẽ hướng dẫn thêm cấu hình vào file MCP của Cursor:

```json
{
  "mcpServers": {
    "docker-mcp": {
      "command": "docker",
      "args": ["run", "-i", "--rm", "mcp/toolkit"]
    }
  }
}
```

**Vị trí file:** `.mcp.json` trong workspace hoặc settings của Cursor

### Cấu hình cho Claude Code

Thêm vào file `%APPDATA%\Claude\mcp.json` (Windows) hoặc `~/.config/claude/mcp.json` (macOS/Linux):

```json
{
  "mcpServers": {
    "docker-mcp": {
      "command": "docker",
      "args": ["run", "-i", "--rm", "mcp/toolkit"]
    }
  }
}
```

### Cấu hình cho Claude Desktop

Thêm vào file cấu hình Claude Desktop:
- **Windows:** `%APPDATA%\Claude\claude_desktop_config.json`
- **macOS:** `~/Library/Application Support/Claude/claude_desktop_config.json`

```json
{
  "mcpServers": {
    "docker-mcp": {
      "command": "docker",
      "args": ["run", "-i", "--rm", "mcp/toolkit"]
    }
  }
}
```

---

## 📊 KIỂM TRA KẾT NỐI (Verify Connection)

### Kiểm tra trong Docker Desktop

1. Vào **MCP Toolkit** → **Clients**
2. Các client đã kết nối sẽ hiển thị nút **Disconnect** (màu cam)
3. Các client chưa kết nối sẽ hiển thị nút **Connect** (màu xanh)

### Kiểm tra Containers

1. Vào **Containers** trong Docker Desktop
2. Tìm container `cursor` hoặc các MCP-related containers
3. Kiểm tra trạng thái: Running (màu xanh)

### Test trong AI Client

Trong Cursor hoặc Claude Code, thử các lệnh:

```
# Test Memory MCP
Hãy tạo một entity trong knowledge graph

# Test Playwright MCP
Hãy mở trang google.com

# Test YouTube transcripts MCP
Hãy lấy transcript từ video YouTube: [URL]
```

---

## 🔄 SO SÁNH VỚI CẤU HÌNH THỦ CÔNG (Comparison)

| Tiêu chí | Docker MCP Toolkit | Cấu hình thủ công (.mcp.json) |
|----------|-------------------|-------------------------------|
| **Cài đặt** | GUI, dễ dàng | Cần chỉnh sửa file JSON |
| **Quản lý servers** | Toggle ON/OFF trong UI | Cần thêm/xóa cấu hình |
| **Cập nhật** | Tự động qua Docker | Cần cập nhật thủ công |
| **OAuth** | Tích hợp sẵn | Cần cấu hình riêng |
| **Catalog** | 311+ servers có sẵn | Cần tìm và cấu hình từng server |
| **Isolation** | Chạy trong containers | Chạy trên máy host |

### Khi nào dùng Docker MCP Toolkit?

- Muốn cài đặt nhanh, không cần cấu hình nhiều
- Cần nhiều MCP servers khác nhau
- Muốn isolation tốt hơn (chạy trong containers)
- Cần OAuth integration

### Khi nào dùng cấu hình thủ công?

- Cần kiểm soát chi tiết cấu hình
- Muốn đồng bộ cấu hình giữa các máy
- Không muốn phụ thuộc Docker
- Cần custom MCP servers riêng

---

## 🚨 XỬ LÝ LỖI (Troubleshooting)

### Lỗi: Client không thể kết nối

1. Đảm bảo Docker Desktop đang chạy
2. Kiểm tra MCP Toolkit extension đã được cài
3. Khởi động lại Docker Desktop
4. Thử **Disconnect** rồi **Connect** lại

### Lỗi: MCP Server không hoạt động

1. Vào **Containers** kiểm tra container có đang chạy
2. Kiểm tra logs của container
3. Toggle OFF rồi ON lại server trong MCP Toolkit

### Lỗi: OAuth không authorize được

1. Kiểm tra kết nối internet
2. Xóa cache trình duyệt
3. Thử **Revoke** rồi **Authorize** lại

---

## 📚 TÀI LIỆU THAM KHẢO (References)

- [Docker MCP Toolkit Documentation](https://docs.docker.com/desktop/extensions/mcp-toolkit/)
- [MCP Protocol Specification](https://modelcontextprotocol.io/)
- [MCP-MANAGEMENT.md](MCP-MANAGEMENT.md) - Quản lý MCP config thủ công
- [SETUP.md](SETUP.md) - Hướng dẫn setup MCP thủ công

---

*Cập nhật: 14/12/2025*
