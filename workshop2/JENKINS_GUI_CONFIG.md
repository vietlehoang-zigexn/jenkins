# 🔧 Hướng dẫn cấu hình Jenkins GUI

## 📋 **Cấu hình Environment Variables qua GUI**

### **Bước 1: Vào Jenkins Job Configuration**
1. Jenkins Dashboard → Your Job → Configure
2. Scroll xuống phần "Environment Variables"

### **Bước 2: Thêm các biến môi trường**

#### **2.1. Credentials (Secret Text)**
```
Name: firebase-token
Type: Secret text
Value: [YOUR_FIREBASE_TOKEN_HERE]

Name: ssh-private-key
Type: Secret text
Value: [Nội dung file newbie_id_rsa]

Name: google-application-credentials
Type: Secret file
Value: [Upload firebase-service-account.json file]
```

#### **2.2. Environment Variables (String)**
```
Name: firebase-project-id
Value: [YOUR_FIREBASE_PROJECT_ID]

Name: remote-host
Value: 10.1.1.195

Name: remote-user
Value: newbie

Name: remote-port
Value: 3334

Name: slack-channel
Value: #lnd-2025-workshop

Name: deploy-user
Value: vietlh
```

### **Bước 3: Cấu hình Slack Plugin**
1. Manage Jenkins → System Configuration
2. Tìm phần "Slack"
3. Cấu hình:
   - **Workspace:** ventura-vn
   - **Credential:** Tạo secret text với value: `fFs6If2vNs3HBdR4DYOPffOg`
   - **Default channel:** #lnd-2025-workshop

### **Bước 4: Test Configuration**
1. Chạy job để test
2. Kiểm tra Slack notifications
3. Verify deployments thành công

## ⚠️ **Lưu ý bảo mật**
- KHÔNG commit secrets vào git
- Sử dụng Jenkins credential store
- Test trên branch riêng trước khi merge main
