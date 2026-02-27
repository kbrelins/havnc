FROM alpine:3.19

# Podstawowa konfiguracja środowiska
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    TZ="Europe/Warsaw" \
    DISPLAY=:0 \
    RESOLUTION="1024x768" \
    RESOLUTION_COMMAS="1024,768" \
    PORT=8080 \
    VNC_PASSWORD="1" \
    HA_URL="http://192.168.8.3:8123"

RUN apk update && \
    apk add --no-cache supervisor bash python3 py3-requests sed unzip xvfb tigervnc websockify openbox chromium nss alsa-lib font-noto font-noto-cjk jq git procps

# Pobieranie noVNC (wersja stabilna v0.5.1 pod Gnymana)
RUN git clone -c http.sslVerify=false --branch v0.5.1 https://github.com/novnc/noVNC.git /opt/novnc

# Przygotowanie katalogów
RUN mkdir -p /config/supervisor /root/.config/tigervnc /config/google-chrome

# Kopiowanie Twojego index.html (z pakietu Gnymana)
COPY index.html /opt/novnc/index.html
COPY config/supervisord.conf /config/supervisord.conf
COPY config/supervisor/*.conf /config/supervisor/

WORKDIR /opt/novnc

# MODYFIKACJA CSS (Ukrycie paska bocznego/górnego w noVNC)
RUN sed -i '/<link rel="stylesheet"/a <style>#noVNC_status_bar { display: none !important; } #noVNC_canvas { width: 100vw !important; height: 100vh !important; object-fit: contain !important; }</style>' index.html

CMD ["supervisord", "-l", "/var/log/supervisord.log", "-c", "/config/supervisord.conf"]
