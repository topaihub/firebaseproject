#!/bin/bash
set -e

# 加载 .env 环境变量
if [ -f .env ]; then
  export $(cat .env | xargs)
else
  echo ".env 文件不存在，请确保包含 FIREBASE_TOKEN 和 PROJECT_ID"
  exit 1
fi

echo "Using FIREBASE_TOKEN: ${FIREBASE_TOKEN:0:10}..."
echo "Using PROJECT_ID: $PROJECT_ID"

# 初始化 firebase 配置（仅首次部署需要）
if [ ! -f firebase.json ]; then
  echo "firebase.json 不存在，初始化中..."
  firebase init hosting --project "$PROJECT_ID" --token "$FIREBASE_TOKEN" --public "public" --non-interactive --force
fi

# 部署
firebase deploy --only hosting --token "$FIREBASE_TOKEN" --project "$PROJECT_ID"