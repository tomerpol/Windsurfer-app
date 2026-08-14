FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ca-certificates \
    curl \
    dbus-x11 \
    libarchive13 \
    libcurl4 \
    libgtk-3-0 \
    libjpeg-turbo8 \
    libpng16-16 \
    libusb-1.0-0 \
    libwebkit2gtk-4.0-37 \
    openjdk-17-jre \
    procps \
    xfce4 \
    xfce4-goodies \
    novnc \
    unzip \
    websockify \
    x11-utils \
    x11vnc \
    xvfb \
    && rm -rf /var/lib/apt/lists/*
