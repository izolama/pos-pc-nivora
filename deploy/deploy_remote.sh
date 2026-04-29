#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
ARCHIVE_PATH="${ARCHIVE_PATH:-/tmp/pos-pc-nivora-deploy.tgz}"
REMOTE_USER="${REMOTE_USER:-shananfamily}"
REMOTE_HOST="${REMOTE_HOST:-172.30.220.43}"
REMOTE_DIR="${REMOTE_DIR:-/home/${REMOTE_USER}/pos-pc-nivora}"
SSH_OPTS="${SSH_OPTS:--o StrictHostKeyChecking=no}"

echo "[1/5] Building Flutter web release bundle"
cd "$ROOT_DIR"
flutter build web

echo "[2/5] Packaging deploy bundle to ${ARCHIVE_PATH}"
tar -czf "$ARCHIVE_PATH" Dockerfile docker-compose.yml .dockerignore deploy build/web

echo "[3/5] Uploading bundle to ${REMOTE_USER}@${REMOTE_HOST}"
scp ${SSH_OPTS} "$ARCHIVE_PATH" "${REMOTE_USER}@${REMOTE_HOST}:~/"

echo "[4/5] Preparing remote directory ${REMOTE_DIR}"
ssh ${SSH_OPTS} "${REMOTE_USER}@${REMOTE_HOST}" "mkdir -p '${REMOTE_DIR}' && tar -xzf ~/$(basename "$ARCHIVE_PATH") -C '${REMOTE_DIR}'"

echo "[5/5] Building and starting container via docker compose"
ssh ${SSH_OPTS} "${REMOTE_USER}@${REMOTE_HOST}" "cd '${REMOTE_DIR}' && docker compose up -d --build"

echo "Deploy completed."
