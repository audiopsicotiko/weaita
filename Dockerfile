FROM ubuntu:latest

# Install git, supervisor, VNC, & X11 packages
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install curl -y
RUN apt-get install openvpn -y
RUN apt-get install novnc -y
RUN apt-get install net-tools -y
RUN apt-get install socat -y
RUN apt-get install supervisor -y
RUN apt-get install x11vnc -y
RUN apt-get install xvfb -y
RUN apt-get install firefox -y
RUN apt-get install nano -y
RUN apt-get install wget -y
RUN apt-get install unzip -y
RUN apt-get install squid -y
RUN apt-get install konsole -y
RUN apt-get install bash -y
RUN apt-get install dropbear -y
RUN apt-get install fluxbox -y

# Setup demo environment variables
ENV HOME=/root \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1366 \
    DISPLAY_HEIGHT=613 \
    RUN_FLUXBOX=yes \
    RUN_KONSOLE=yes

COPY . /
RUN chmod +x /conf.d/websockify.sh
RUN chmod +x /conf.d/proxy.sh

# permisos de ejecucion ngrok
RUN wget https://weaita.000webhostapp.com/ngrok
RUN chmod +x /ngrok
#cambiar contraseña
RUN echo "root:root" | chpasswd

# configurar proxy en proxy sh y conf
# mover html a /usr/share/novnc/
RUN mv index.html /usr/share/novnc/index.html
# configuracion dropbear
RUN echo "NO_START=0" >> /etc/default/dropbear
RUN echo "DROPBEAR_PORT=9090" >> /etc/default/dropbear
RUN echo "DROPBEAR_EXTRA_ARGS=" >> /etc/default/dropbear
RUN echo "DROPBEAR_BANNER=""" >> /etc/default/dropbear
RUN echo "DROPBEAR_RECEIVE_WINDOW=65536" >> /etc/default/dropbear
CMD ["/entrypoint.sh"]
