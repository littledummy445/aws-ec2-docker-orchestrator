#!/bin/bash
set -euxo pipefail

dnf update -y
dnf install -y docker
systemctl enable docker
systemctl start docker

mkdir -p /usr/local/lib/docker/cli-plugins
curl -SL "https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64" -o /usr/local/lib/docker/cli-plugins/docker-compose
chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

mkdir -p /opt/app

cat > /opt/app/package.json <<'APP_PACKAGE'
{
  "name": "ec2-docker-orchestrator-app",
  "version": "1.0.0",
  "main": "index.js",
  "license": "MIT",
  "dependencies": {
    "express": "^4.19.2"
  }
}
APP_PACKAGE

cat > /opt/app/index.js <<'APP_INDEX'
const express = require('express');

const app = express();
const port = 80;

app.get('/', (_req, res) => {
  res.send('Hello from Containers running on Amazon EC2!');
});

app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
APP_INDEX

cat > /opt/app/Dockerfile <<'APP_DOCKERFILE'
FROM node:20-alpine

WORKDIR /usr/src/app

COPY package.json ./
RUN npm install --omit=dev

COPY index.js ./

EXPOSE 80

CMD ["node", "index.js"]
APP_DOCKERFILE

cat > /opt/app/docker-compose.yml <<'APP_COMPOSE'
version: "3.8"

services:
  app:
    build: .
    ports:
      - "80:80"
    restart: always
APP_COMPOSE

cd /opt/app
docker compose up -d
