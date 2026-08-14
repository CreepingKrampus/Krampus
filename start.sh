#!/bin/bash

echo "🧹 Limpando sessões virtuais antigas..."
pkill -f "Xvfb :1" 2>/dev/null
pkill -f "fluxbox" 2>/dev/null
pkill -f "x11vnc" 2>/dev/null
pkill -f "websockify.*6080" 2>/dev/null

rm -f /tmp/.X1-lock /tmp/.X11-unix/X1 2>/dev/null

echo "🖥️ Iniciando a tela virtual (Xvfb)..."
Xvfb :1 -screen 0 1280x1024x24 &
sleep 2

export DISPLAY=:1

echo "🎨 Iniciando o Fluxbox..."
fluxbox &
sleep 2

echo "🔒 Iniciando o x11vnc..."
x11vnc \
  -display :1 \
  -forever \
  -nopw \
  -listen localhost \
  -rfbport 5900 &

sleep 2

echo "🌐 Iniciando o noVNC na porta 6080..."
websockify \
  --web=/usr/share/novnc \
  6080 \
  localhost:5900 &

sleep 2

echo "🚀 Abrindo o Chromium..."

chromium \
  --no-sandbox \
  --disable-dev-shm-usage \
  --disable-gpu \
  --display=:1 \
  about:blank &

echo ""
echo "✅ Tudo pronto!"
echo "🌐 Abra a porta 6080 na aba Ports do Codespace."
echo ""
