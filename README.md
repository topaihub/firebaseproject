# firebaseproject
💡 A lightweight solution for automatic static website deployment on iStoreOS using Docker and Firebase CLI.

# 项目简介：iStoreOS 环境下的 Firebase Hosting 自动部署系统

本项目旨在帮助用户在 **iStoreOS 系统** 中，通过 **Docker 容器** 部署和托管基于 Firebase 的静态网站，解决传统 WSL 或 Windows 登录难、环境复杂、授权不便等问题。

通过整合以下技术与工具，实现无界面纯命令行环境下的 Firebase 项目部署：

- 🔧 使用 **Node.js v20+** 构建 Firebase 环境，满足现代前端工具链需求。
- 🐳 利用 **Docker** 封装 Firebase CLI 工具，避免宿主系统污染。
- 🔐 使用 `.env` 文件集中管理敏感配置（如 `FIREBASE_TOKEN` 和 `PROJECT_ID`）。
- 🚀 一键运行 `deploy.sh` 脚本完成 Firebase Hosting 自动部署。
- 📁 支持自定义挂载目录（如挂载在 `/mnt/scsi2.1-1/`），适配 iStoreOS 挂载盘结构。

## 应用场景

- iStoreOS 系统部署个人网站、博客、文档、前端静态页面
- 无需桌面环境或浏览器交互的远程登录式部署
- 自动化 CI/CD 构建部署流程（可对接 n8n、GitHub Actions 等）

## 项目优势

- ✅ 纯 CLI 操作，脱离浏览器交互
- ✅ 支持多项目部署，环境隔离
- ✅ 持久存储与挂载盘兼容性良好
- ✅ 灵活扩展，兼容 Git 自动构建推送

> 本项目是你在 iStoreOS 上优雅部署 Firebase Hosting 的最佳实践方案。

```prompt
🔥 运行一条命令即可部署：
docker run --rm -v /mnt/scsi2.1-1/firebaseproject:/firebase -w /firebase firebase-hosting bash ./deploy.sh
```

