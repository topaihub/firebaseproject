# firebaseproject
💡 A lightweight solution for automatic static website deployment on iStoreOS using Docker and Firebase CLI.


# iStoreOS 环境下使用 Docker 自动部署 Firebase Hosting 完整教程

---

## 目录

1. 项目简介  
2. 环境准备  
3. Dockerfile 编写  
4. 项目目录结构  
5. `.env` 文件配置  
6. 自动部署脚本 `deploy.sh`  
7. 构建与运行容器  
8. 常见问题及建议  

---

## 1. 项目简介

本项目旨在帮助用户在 iStoreOS 系统中，使用 Docker 容器环境和 Firebase CLI 工具，实现静态网站自动部署到 Firebase Hosting，无需依赖本地浏览器，支持 `.env` 文件管理敏感配置，方便持续集成和自动化部署。

---

## 2. 环境准备

- iStoreOS 系统，已安装 Docker
- Firebase 项目，已创建并获取项目 ID
- 本地机器获取 `FIREBASE_TOKEN`（通过命令 `firebase login:ci --no-localhost`）

---

## 3. Dockerfile 编写

在项目根目录新建 `Dockerfile`：

```Dockerfile
# 基于官方 node 镜像，选择最新的 Node 20 版本
FROM node:20

# 设置工作目录
WORKDIR /firebase

# 全局安装 firebase-tools，并升级 npm
RUN npm install -g npm@11.4.1 firebase-tools

# 容器入口保持 bash
CMD [ "bash" ]
```

---

## 4. 项目目录结构

```
firebaseproject/
├── .env                    # 环境变量文件，存储 FIREBASE_TOKEN 和 PROJECT_ID
├── Dockerfile              # 构建镜像使用
├── deploy.sh               # 自动部署脚本
├── firebase.json           # Firebase Hosting 配置文件
├── .firebaserc             # Firebase 项目别名配置
└── public/                 # 静态网站资源目录（需部署内容放这里）
    └── index.html          # 示例首页文件
```

---

## 5. `.env` 文件示例

创建 `.env` 文件，内容如下：

```env
FIREBASE_TOKEN=1//你的firebase登录token
PROJECT_ID=你的-firebase-项目ID
```

---

## 6. 自动部署脚本 `deploy.sh`

新建 `deploy.sh`，内容如下：

```bash
#!/bin/bash
set -e

# 加载 .env 文件
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
else
  echo ".env 文件未找到，退出！"
  exit 1
fi

echo "开始部署，项目ID: $PROJECT_ID"

# 初始化项目配置（首次运行用）
if [ ! -f firebase.json ]; then
  firebase init hosting --project "$PROJECT_ID" --token "$FIREBASE_TOKEN" --public "public" --non-interactive --force
fi

# 部署 Hosting
firebase deploy --only hosting --token "$FIREBASE_TOKEN" --project "$PROJECT_ID"
```

给脚本执行权限：

```bash
chmod +x deploy.sh
```

---

## 7. 构建与运行容器部署

### 构建镜像

进入项目目录，执行：

```bash
docker build -t firebase-hosting .
```

### 运行部署

执行部署命令：

```bash
docker run --rm \
  -v /mnt/scsi2.1-1/firebaseproject:/firebase \
  -w /firebase \
  firebase-hosting \
  bash ./deploy.sh
```

---

## 8. 常见问题及建议

- **无法访问登录链接**  
  解决方法：在本地机器运行 `firebase login:ci --no-localhost`，获取 token 写入 `.env`。

- **token 过期**  
  重新获取 token 并更新 `.env`。

- **挂载路径权限问题**  
  确保 Docker 容器对挂载目录有读写权限。

- **首次部署需初始化**  
  脚本中已包含初始化命令，确保 `firebase.json` 不存在时自动初始化。

- **升级 npm 版本**  
  Dockerfile 已集成最新 npm 版本。

---

祝你在 iStoreOS 环境下，利用 Docker 完成 Firebase Hosting 部署顺利！  
有任何问题欢迎随时提问。  



