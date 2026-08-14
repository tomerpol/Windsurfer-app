#!/usr/bin/env bash
set -euo pipefail

readonly DISPLAY_NUMBER="${DISPLAY_NUMBER:-:1}"
readonly SCREEN_SIZE="${SCREEN_SIZE:-1280x800x24}"
readonly VNC_PORT="${VNC_PORT:-5900}"
readonly NOVNC_PORT="${NOVNC_PORT:-6080}"
readonly GARMIN_DIR="${GARMIN_DIR:-$HOME/.garmin/connectiq-sdk-manager}"
readonly GARMIN_URL="${GARMIN_SDK_MANAGER_URL:-https://developer.garmin.com/downloads/connect-iq/sdk-manager/connectiq-sdk-manager-linux.zip}"
readonly LOG_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/windsurfer"

mkdir -p "$GARMIN_DIR" "$LOG_DIR"

install_monkey_c_extension() {
    local code_command
    if command -v code >/dev/null 2>&1; then
        code_command=code
    elif command -v code-insiders >/dev/null 2>&1; then
        code_command=code-insiders
    else
        echo "VS Code CLI not found; run this script from the dev container." >&2
        return 1
    fi

    if ! "$code_command" --list-extensions | tr '[:upper:]' '[:lower:]' | grep -qx 'garmin.monkey-c'; then
        "$code_command" --install-extension garmin.monkey-c
    fi
}

install_sdk_manager() {
    if find "$GARMIN_DIR" -type f -name sdkmanager -perm -u+x -print -quit | grep -q .; then
        return
    fi

    local archive temporary_directory
    archive="$(mktemp --suffix=.zip)"
    temporary_directory="$(mktemp -d)"
    trap 'rm -f "$archive"; rm -rf "$temporary_directory"' RETURN

    echo "Downloading Garmin Connect IQ SDK Manager..."
    curl --fail --location --retry 3 --output "$archive" "$GARMIN_URL"
    unzip -q "$archive" -d "$temporary_directory"
    cp -a "$temporary_directory"/. "$GARMIN_DIR"/

    local executable
    executable="$(find "$GARMIN_DIR" -type f -name sdkmanager -print -quit)"
    if [[ -z "$executable" ]]; then
        echo "Garmin archive did not contain an sdkmanager executable." >&2
        return 1
    fi
    chmod +x "$executable"
}

start_process() {
    local pattern="$1"
    local log="$2"
    shift 2
    if ! pgrep -f "$pattern" >/dev/null; then
        nohup "$@" >"$LOG_DIR/$log" 2>&1 &
    fi
}

start_desktop() {
    export DISPLAY="$DISPLAY_NUMBER"
    start_process "Xvfb $DISPLAY_NUMBER" xvfb.log \
        Xvfb "$DISPLAY_NUMBER" -screen 0 "$SCREEN_SIZE" -nolisten tcp

    for _ in {1..20}; do
        xdpyinfo -display "$DISPLAY_NUMBER" >/dev/null 2>&1 && break
        sleep 0.25
    done
    xdpyinfo -display "$DISPLAY_NUMBER" >/dev/null

    start_process "xfce4-session" xfce.log env DISPLAY="$DISPLAY_NUMBER" dbus-launch startxfce4
    start_process "x11vnc.*-rfbport $VNC_PORT" x11vnc.log \
        x11vnc -display "$DISPLAY_NUMBER" -forever -shared -nopw -localhost -rfbport "$VNC_PORT"
    start_process "websockify.*$NOVNC_PORT" novnc.log \
        websockify --web=/usr/share/novnc/ "localhost:$NOVNC_PORT" "localhost:$VNC_PORT"
}

start_sdk_manager() {
    local executable
    executable="$(find "$GARMIN_DIR" -type f -name sdkmanager -perm -u+x -print -quit)"
    start_process "$executable" sdk-manager.log env DISPLAY="$DISPLAY_NUMBER" "$executable"
}

install_monkey_c_extension
install_sdk_manager
start_desktop
start_sdk_manager

echo "Connect IQ desktop ready at http://localhost:$NOVNC_PORT/vnc.html"
echo "Logs are in $LOG_DIR; SDKs and developer keys stay outside the repository."
