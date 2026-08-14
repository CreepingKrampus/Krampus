# Krampus

Ah, Fluxbox. 👍 É bem mais leve que XFCE e combina melhor com Codespaces.

Use Fluxbox + TigerVNC + noVNC + Chromium:

sudo apt update
sudo apt install -y chromium fluxbox tigervnc-standalone-server novnc

Configure o VNC para iniciar o Fluxbox:

mkdir -p ~/.vnc


cat > ~/.vnc/xstartup <<'EOF'
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
fluxbox &
EOF


chmod +x ~/.vnc/xstartup

Crie a senha:

vncpasswd

Inicie o VNC:

vncserver :1 -geometry 1280x800 -depth 24

Inicie o noVNC:

websockify --web=/usr/share/novnc 6080 localhost:5901

No Codespace → PORTS, encaminhe a porta 6080 e abra-a no navegador.

Depois, pelo terminal do Codespace, rode:

DISPLAY=:1 chromium --no-sandbox --disable-dev-shm-usage

Pronto: noVNC → Fluxbox → Chromium, sem XFCE.
