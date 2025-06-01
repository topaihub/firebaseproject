FROM node:20

# 安装最新 firebase-tools & npm
RUN npm install -g npm@11.4.1 firebase-tools

# 设置默认工作目录
WORKDIR /firebase
