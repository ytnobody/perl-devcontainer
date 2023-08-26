FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu-22.04
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    wget \
    sqlite3 \
    && rm -rf /var/lib/apt/lists/*

