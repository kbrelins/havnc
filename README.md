# HAVNC Standalone (Fork)

This is a customized version of the [havnc project by gnyman](https://github.com/gnyman/havnc), optimized to run as a **standalone Docker container** (e.g., on macOS via OrbStack, Linux) rather than a Home Assistant Add-on.

## Summary of Changes

The goal was to eliminate dependencies on Home Assistant supervisor files (`options.json`) and configure the container to run on ARM64 architecture (Apple Silicon) while maintaining the original functionality provided by Gnyman.

1.  **Removed Home Assistant Dependencies**:
    * Updated supervisor configuration files (`.conf`) to stop looking for `/data/options.json`.
    * Replaced hardcoded HA-specific variables with environment variables passed during `docker run`.
2.  **Network & Web Access (HTTP Support)**:
    * Modified `4-websockify.conf` to run in **HTTP mode** (removed SSL certificate requirements). This enables direct access via `http://localhost:8080` without browser warnings, improving compatibility with various VNC clients.
3.  **Mouse/Cursor Synchronization (M1/OrbStack fix)**:
    * Updated `5-chromium.conf` to include flags ensuring the cursor maps correctly to the virtual screen: `--force-device-scale-factor=1` and `--window-position=0,0`.
    * Configured `1-xvfb.conf` to explicitly set the display environment.
4.  **No changes to `index.html`**: The original noVNC interface provided by Gnyman was kept intact.

## Technical Details

* **Base OS**: Alpine Linux 3.19
* **VNC Server**: TigerVNC (`x0vncserver`)
* **Web VNC Client**: noVNC v0.5.1
* **Web Proxy**: Websockify
* **Browser**: Chromium (latest available in Alpine 3.19 repositories, running in `--kiosk` mode)
* **Window Manager**: Openbox
* **Display Server**: Xvfb

## How to run standalone (Docker)

Use the following command to run the container. Adjust `HA_URL` to point to your Home Assistant instance.

```bash
docker run -d \
  --name ha-vnc-dashboard \
  --restart=unless-stopped \
  -p 8080:8080 \
  -e RESOLUTION="1024x768" \
  -e RESOLUTION_COMMAS="1024,768" \
  -e VNC_PASSWORD="1" \
  -e HA_URL="http://YOUR_HA_IP:8123" \
  -e DISPLAY=":0" \
  YOUR_GITHUB_USERNAME/havnc:latest
```

Access the dashboard via: http://127.0.0.1:8080/?password=1
