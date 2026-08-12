#!/usr/bin/env bash
set -e
export DISPLAY=:1
if ! pgrep -f "Xvfb :1" >/dev/null; then
  nohup Xvfb :1 -screen 0 1280x800x24 >/tmp/xvfb.log 2>&1 &
fi
sleep 1
if ! pgrep -f xfce4-session >/dev/null; then
  nohup env DISPLAY=:1 startxfce4 >/tmp/xfce.log 2>&1 &
fi
sleep 2
if ! pgrep -f "x11vnc.*:1" >/dev/null; then
  nohup x11vnc -display :1 -forever -shared -nopw -rfbport 5900 >/tmp/x11vnc.log 2>&1 &
fi
if ! pgrep -f "websockify.*6080" >/dev/null; then
  nohup websockify --web=/usr/share/novnc/ 6080 localhost:5900 >/tmp/novnc.log 2>&1 &
fi
echo "Desktop ready on forwarded port 6080"
