# Quản Lý MCP Config - Hệ Thống Đồng Bộ (MCP Config Management - Sync System)

> **MỤC ĐÍCH:** Hướng dẫn quản lý và đồng bộ file cấu hình MCP giữa Cursor và Claude Code một cách gọn gàng, tự động.

---

## 📋 TỔNG QUAN (Overview)

Hiện tại có **3 vị trí** lưu trữ file MCP config:

1. **`.mcp.json`** (Cursor workspace) - File chính cho Cursor
2. **`claude-code/.mcp.json`** (Backup trong repo) - File backup/đồng bộ
3. **`%APPDATA%\Claude\mcp.json`** (Claude Code config) - File chính cho Claude Code

---

## 🎯 NGUYÊN TẮC QUẢN LÝ (Management Principles)

### 1. File Nguồn Chân Lý (Source of Truth)

**Quy tắc:** File `.mcp.json` trong Cursor workspace là **file nguồn chân lý (Source of Truth)**

- Mọi thay đổi tokens/API keys → **Chỉnh sửa file `.mcp.json` trong Cursor workspace**
- Sau đó đồng bộ sang các vị trí khác

### 2. Quy Trình Đồng Bộ (Sync Workflow)

```
.mcp.json (Cursor) 
    ↓ [Đồng bộ]
    ├─→ %APPDATA%\Claude\mcp.json (Claude Code)
    └─→ claude-code/.mcp.json (Backup trong repo)
```

### 3. Bảo Mật (Security)

- **KHÔNG commit** file `.mcp.json` lên GitHub (đã ignore)
- File backup `claude-code/.mcp.json` cũng đã được ignore
- Chỉ commit các files hướng dẫn và script

---

## 🛠️ SỬ DỤNG SCRIPT ĐỒNG BỘ

### ⚠️ Lưu ý về Execution Policy

Nếu gặp lỗi "running scripts is disabled", sử dụng một trong các cách sau:

**Cách 1: Dùng file `.bat` (Khuyến nghị)**
```cmd
sync-mcp.bat check
sync-mcp.bat cursor-to-claude
```

**Cách 2: Chạy PowerShell với Bypass**
```powershell
powershell -ExecutionPolicy Bypass -File .\sync-mcp.ps1 -Direction check
```

**Cách 3: Thay đổi Execution Policy (một lần)**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Cách 1: Kiểm tra trạng thái

```cmd
sync-mcp.bat check
```

Hoặc:
```powershell
.\sync-mcp.ps1 -Direction check
```

Script sẽ hiển thị:
- Files nào đang đồng bộ
- Files nào khác nhau

### Cách 2: Đồng bộ từ Cursor → Claude Code

```cmd
sync-mcp.bat cursor-to-claude
```

Hoặc:
```powershell
.\sync-mcp.ps1 -Direction cursor-to-claude
```

Sử dụng khi:
- Bạn vừa cập nhật tokens trong `.mcp.json` của Cursor
- Muốn áp dụng cùng config cho Claude Code

### Cách 3: Đồng bộ từ Claude Code → Cursor

```cmd
sync-mcp.bat claude-to-cursor
```

Hoặc:
```powershell
.\sync-mcp.ps1 -Direction claude-to-cursor
```

Sử dụng khi:
- Bạn đã chỉnh sửa config trong Claude Code
- Muốn đồng bộ ngược lại về Cursor

### Cách 4: Đồng bộ 2 chiều (kiểm tra + đồng bộ)

```cmd
sync-mcp.bat both
```

Hoặc:
```powershell
.\sync-mcp.ps1 -Direction both
```

Sử dụng khi:
- Muốn kiểm tra và đồng bộ tất cả

---

## 📁 CẤU TRÚC FILES ĐỀ XUẤT

```
CURSOR/
├── .mcp.json                    # ⭐ Source of Truth (cho Cursor)
├── .mcp.json.example            # Template (không có secrets)
├── claude-code/
│   ├── .mcp.json                # Backup (đồng bộ từ .mcp.json)
│   ├── README.md                # Hướng dẫn Claude Code
│   ├── QUICK-START.md           # Hướng dẫn nhanh
│   └── setup-claude-mcp.ps1     # Script setup
├── sync-mcp.ps1                 # ⭐ Script đồng bộ
├── setup-mcp.ps1                # Script setup Cursor
├── SETUP.md                     # Hướng dẫn chi tiết
├── QUICK-START.md               # Hướng dẫn nhanh
└── README.md                    # Tổng quan
```

**Vị trí Claude Code:**
```
%APPDATA%\Claude\mcp.json        # File thực tế Claude Code dùng
```

---

## 🔄 QUY TRÌNH LÀM VIỆC (Workflow)

### Khi cập nhật tokens/API keys:

1. **Chỉnh sửa file `.mcp.json`** trong Cursor workspace
2. **Chạy script đồng bộ:**
   ```powershell
   .\sync-mcp.ps1 -Direction cursor-to-claude
   ```
3. **Khởi động lại** Cursor và Claude Code

### Khi clone repo mới:

1. **Copy file `.mcp.json.example`** → `.mcp.json`
2. **Nhập tokens** vào `.mcp.json`
3. **Chạy script đồng bộ:**
   ```powershell
   .\sync-mcp.ps1 -Direction cursor-to-claude
   ```
4. **Khởi động lại** Cursor và Claude Code

---

## ✅ CHECKLIST QUẢN LÝ

### Hàng ngày:
- [ ] Kiểm tra đồng bộ: `.\sync-mcp.ps1 -Direction check`

### Khi cập nhật tokens:
- [ ] Chỉnh sửa `.mcp.json` trong Cursor workspace
- [ ] Chạy script đồng bộ: `.\sync-mcp.ps1 -Direction cursor-to-claude`
- [ ] Khởi động lại Cursor và Claude Code
- [ ] Test MCP trong cả 2 ứng dụng

### Khi commit code:
- [ ] Đảm bảo `.mcp.json` và `claude-code/.mcp.json` đã được ignore
- [ ] Chỉ commit các files hướng dẫn và script

---

## 🚨 LƯU Ý QUAN TRỌNG (Important Notes)

### 1. File Nguồn Chân Lý

- **LUÔN** chỉnh sửa file `.mcp.json` trong Cursor workspace trước
- **SAU ĐÓ** mới đồng bộ sang các vị trí khác
- **KHÔNG** chỉnh sửa trực tiếp file trong `%APPDATA%\Claude\` (trừ khi cần thiết)

### 2. Đồng Bộ

- Sử dụng script `sync-mcp.ps1` để đồng bộ tự động
- Kiểm tra trạng thái trước khi đồng bộ
- Backup file cũ trước khi ghi đè (script tự động)

### 3. Bảo Mật

- **KHÔNG** commit file `.mcp.json` lên GitHub
- **KHÔNG** chia sẻ tokens/API keys
- File backup trong repo cũng đã được ignore

---

## 📚 TÀI LIỆU THAM KHẢO

- [SETUP.md](SETUP.md) - Hướng dẫn setup chi tiết
- [QUICK-START.md](QUICK-START.md) - Hướng dẫn nhanh
- [claude-code/README.md](claude-code/README.md) - Hướng dẫn Claude Code

---

*Cập nhật: 08/12/2025*

