FROM mcr.microsoft.com/devcontainers/base:ubuntu

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    openjdk-17-jre \
    xfce4 \
    xfce4-goodies \
    xvfb \
    x11vnc \
    novnc \
    websockify \
    unzip \
    curl \
    wget \
    && rm -rf /var/lib/apt/lists/*
