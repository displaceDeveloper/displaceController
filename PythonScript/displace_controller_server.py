#!/usr/bin/env python3

import threading
import struct, time
import subprocess
import socket
from bluezero import adapter, peripheral, device
from evdev import UInput, ecodes
import requests
import json

import os, re, subprocess
import hashlib, secrets, pathlib
from pathlib import Path

import random
from typing import Tuple

from msg import msg_pb2

INTEL_USB_VIDS = {'8087'}   # Intel USB vendor IDs
INTEL_PCI_VIDS = {'8086'}   # Intel PCI vendor IDs

### SELECT THE RIGHT BLUETOOTH ADAPTER -- START ###

import shlex
import re

GUI_USER = "displace"
DISPLAY = ":0"
DBUS = "unix:path=/run/user/1000/bus"   # 1000 = UID of 'displace'

INTEL_MFR_HEX = "0002"  # Intel manufacturer id (normalized without '0x')

def _bluetoothctl_show(adapter_addr: str, timeout: float = 2.0) -> str:
    try:
        cp = subprocess.run(
            ["bluetoothctl", "show", adapter_addr],
            text=True, capture_output=True, timeout=timeout, check=False
        )
        return cp.stdout if cp.returncode == 0 else ""
    except Exception:
        return ""

def _manufacturer_id_from_btctl(adapter_addr: str) -> str | None:
    """
    Parse Manufacturer ID from `bluetoothctl show <adapter>`.
    Returns lowercase hex without '0x' (ecodes.g., '0002'), or None if not found.
    Handles lines like:
      Manufacturer: 0x0002 (2)
      Manufacturer: Intel Corp (0x0002)
      Manufacturer: 2 (decimal only)
    """
    out = _bluetoothctl_show(adapter_addr)
    if not out:
        return None

    for line in out.splitlines():
        if "Manufacturer:" not in line:
            continue
        # 1) Prefer explicit hex anywhere on the line
        m_hex = re.search(r'0x([0-9A-Fa-f]+)', line)
        if m_hex:
            return m_hex.group(1).lower().rjust(4, "0")

        # 2) Else, try a decimal inside parentheses: "(93)"
        m_dec = re.search(r'\((\d+)\)', line)
        if m_dec:
            try:
                return format(int(m_dec.group(1)), '04x')
            except Exception:
                pass

        # 3) Else, try a trailing/plain decimal after the colon
        m_plain_dec = re.search(r'Manufacturer:\s*(\d+)', line, flags=re.I)
        if m_plain_dec:
            try:
                return format(int(m_plain_dec.group(1)), '04x')
            except Exception:
                pass

        # 4) Else, try hex without 0x (rare)
        m_bare_hex = re.search(r'\b([0-9A-Fa-f]{2,4})\b', line)
        if m_bare_hex:
            return m_bare_hex.group(1).lower().rjust(4, "0")

    return None

def pick_adapter_by_manufacturer(adapters):
    """
    Prefer non-Intel manufacturer (Manufacturer ID != 0x0002).
    Ranking: non-Intel (0) < unknown (1) < Intel (2).
    Returns (adapter_obj, info_dict).
    """
    recs = []
    for a in adapters:
        addr = getattr(a, "address", "<unknown>")
        name = getattr(a, "name", "")
        mfr = _manufacturer_id_from_btctl(addr)  # now robust
        is_intel = (mfr == INTEL_MFR_HEX)
        rank = 2 if is_intel else (1 if mfr is None else 0)
        recs.append({
            "obj": a,
            "addr": addr,
            "name": name,
            "mfr": mfr,
            "is_intel": is_intel,
            "rank": rank,
        })

    if not recs:
        raise RuntimeError("No BLE adapters from Bluezero")

    recs.sort(key=lambda r: (r["rank"], r["addr"]))
    best = recs[0]

    print("[BLE] Adapter manufacturers:")
    for r in recs:
        print(f"  - {r['addr']} name='{r['name']}' manufacturer=0x{(r['mfr'] or '????')} intel={r['is_intel']} rank={r['rank']}")

    return best["obj"], best

##### SELECT THE RIGHT BLUETOOTH ADAPTER -- END #####

def _read(path):
    try:
        with open(path, 'r') as f:
            return f.read().strip()
    except Exception:
        return None

# === Packet format (Little-endian) ===
# uint8  type
# uint32 t_ms
# float  dx
# float  dy
# uint8  btn
# uint8  down
# qint16 dwheel
# qint16 hwheel
# char   key
PKT_FMT = "<B f f B B h h c B"
PKT_SIZE = struct.calcsize(PKT_FMT)  # = 11 bytes

SERVICE_UUID = '12345678-1234-5678-1234-56789abcdef0'
RX_UUID = '12345678-1234-5678-1234-56789abcdef1'
TX_UUID = '12345678-1234-5678-1234-56789abcdef2'
LOCAL_NAME = 'ABCDEF'

ALPHA = 1.0 # 0.35

cap = {
    ecodes.EV_KEY: [
        ecodes.BTN_LEFT,

        # Letter keys (A-Z)
        ecodes.KEY_A, ecodes.KEY_B, ecodes.KEY_C, ecodes.KEY_D,
        ecodes.KEY_E, ecodes.KEY_F, ecodes.KEY_G, ecodes.KEY_H,
        ecodes.KEY_I, ecodes.KEY_J, ecodes.KEY_K, ecodes.KEY_L,
        ecodes.KEY_M, ecodes.KEY_N, ecodes.KEY_O, ecodes.KEY_P,
        ecodes.KEY_Q, ecodes.KEY_R, ecodes.KEY_S, ecodes.KEY_T,
        ecodes.KEY_U, ecodes.KEY_V, ecodes.KEY_W, ecodes.KEY_X,
        ecodes.KEY_Y, ecodes.KEY_Z,

        # Number keys (0-9)
        ecodes.KEY_0, ecodes.KEY_1, ecodes.KEY_2, ecodes.KEY_3,
        ecodes.KEY_4, ecodes.KEY_5, ecodes.KEY_6, ecodes.KEY_7,
        ecodes.KEY_8, ecodes.KEY_9,

        # Basic character/punctuation/operator keys
        ecodes.KEY_SPACE, ecodes.KEY_MINUS, ecodes.KEY_EQUAL,
        ecodes.KEY_LEFTBRACE, ecodes.KEY_RIGHTBRACE, ecodes.KEY_BACKSLASH,
        ecodes.KEY_SEMICOLON, ecodes.KEY_APOSTROPHE, ecodes.KEY_GRAVE,
        ecodes.KEY_COMMA, ecodes.KEY_DOT, ecodes.KEY_SLASH,

        # Functional/Control keys
        ecodes.KEY_ENTER, ecodes.KEY_BACKSPACE, ecodes.KEY_TAB,
        ecodes.KEY_CAPSLOCK, ecodes.KEY_LEFTSHIFT, ecodes.KEY_RIGHTSHIFT,
        ecodes.KEY_LEFTCTRL, ecodes.KEY_RIGHTCTRL, ecodes.KEY_LEFTALT,
        ecodes.KEY_RIGHTALT, ecodes.KEY_LEFTMETA, ecodes.KEY_RIGHTMETA,

        # Arrow keys
        ecodes.KEY_UP, ecodes.KEY_DOWN, ecodes.KEY_LEFT, ecodes.KEY_RIGHT,

        # F-keys (F1-F12)
        ecodes.KEY_F1, ecodes.KEY_F2, ecodes.KEY_F3, ecodes.KEY_F4,
        ecodes.KEY_F5, ecodes.KEY_F6, ecodes.KEY_F7, ecodes.KEY_F8,
        ecodes.KEY_F9, ecodes.KEY_F10, ecodes.KEY_F11, ecodes.KEY_F12,

        # Other control keys
        ecodes.KEY_INSERT, ecodes.KEY_DELETE, ecodes.KEY_HOME, ecodes.KEY_END,
        ecodes.KEY_PAGEUP, ecodes.KEY_PAGEDOWN, ecodes.KEY_ESC,
        ecodes.KEY_SYSRQ, # Print Screen/SysRq
        ecodes.KEY_SCROLLLOCK,
        ecodes.KEY_PAUSE, # Pause/Break
    ],
    ecodes.EV_REL: [ecodes.REL_X, ecodes.REL_Y, ecodes.REL_WHEEL, ecodes.REL_HWHEEL, ecodes.REL_WHEEL_HI_RES, ecodes.REL_HWHEEL_HI_RES],
}
ui = UInput(cap, name="DisplaceTrackpad", bustype=ecodes.BUS_USB)


class LocalServer:
    def __init__(self, host="127.0.0.1",
                port=6000,
                mutedChangedCallback=None,
                powerChangedCallback=None,
                volumeChangedCallback=None):
        self.host = host
        self.port = port
        self.server_socket = None
        self.running = True
        self.mutedChangedCallback = mutedChangedCallback
        self.powerChangedCallback = powerChangedCallback
        self.volumeChangedCallback = volumeChangedCallback

    def start_server(self):
        """Start a local socket server to listen for messages from newRfcommHandler.py."""
        while True:
            try:
                self.server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                self.server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)  # Allow reuse of the address
                self.server_socket.bind((self.host, self.port))
                self.server_socket.listen(5)
                print(f"Local server listening on {self.host}:{self.port}")
                break
            except OSError as e:
                print(f"Address already in use. Retrying in 5 seconds... ({e})")
                time.sleep(5)

        while self.running:
            try:
                conn, addr = self.server_socket.accept()
                print(f"Connection established with {addr}")
                threading.Thread(target=self.handle_client, args=(conn,), daemon=True).start()
            except Exception as e:
                print(f"Error in LocalServer: {e}")
                break

    def handle_client(self, conn):
        """Handle incoming messages and forward them to the Arduino server."""
        try:
            while True:
                data = conn.recv(1024).decode("utf-8").strip()
                if not data:
                    break
                print(f"Received from TV app: '{data}'")
                line = data.strip()
                parts = line.split(" ")
                if len(parts) != 2:
                    continue

                match parts[0]:
                    case "MUTED":
                        is_muted = parts[1] == "true"
                        if self.mutedChangedCallback:
                            self.mutedChangedCallback(is_muted)

                    case "POWERED":
                        is_powered = parts[1] == "true"
                        if self.powerChangedCallback:
                            self.powerChangedCallback(is_powered)

                    case "VOLUME":
                        volume = float(parts[1])
                        if self.volumeChangedCallback:
                            self.volumeChangedCallback(volume)
                    
        except Exception as e:
            print(f"Client connection error: {e}")
        finally:
            conn.close()

    def stop_server(self):
        """Stop the server."""
        self.running = False
        if self.server_socket:
            self.server_socket.close()


def send_msg(obj):
    try:
        return requests.post('http://127.0.0.1:5564/command', json=obj)
    except Exception as e:
        print(f"[HTTP] Failed to send message: {e}")
        return None

def send_cmd(cmd: str):
    print(f"[SOCKET] Sending command: {cmd}")
    try:
        with socket.create_connection(('127.0.0.1', 6000)) as s:
            s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)  # Optional: allows socket reuse
            data = cmd.encode('utf-8')
            if not data.endswith(b'\n'):
                data += b'\n'
            s.sendall(data)
    except Exception as e:
        print(f"[SOCKET] Failed to send command to 127.0.0.1:6000: {e}")

def rel_move(dx_norm: float, dy_norm: float):
    # global vx, vy
    # EMA
    # vx = ALPHA * dx_norm + (1.0 - ALPHA) * vx
    # vy = ALPHA * dy_norm + (1.0 - ALPHA) * vy

    sx = int(round(dx_norm))
    sy = int(round(dy_norm))

    if sx != 0 or sy != 0:
        ui.write(ecodes.EV_REL, ecodes.REL_X, sx)
        ui.write(ecodes.EV_REL, ecodes.REL_Y, sy)
        ui.syn()

def leftmouse_click():
    ui.write(ecodes.EV_KEY, ecodes.BTN_LEFT, True)
    ui.syn()

    time.sleep(0.05)

    ui.write(ecodes.EV_KEY, ecodes.BTN_LEFT, False)
    ui.syn()

def vscroll(value: int):
    ui.write(ecodes.EV_REL, ecodes.REL_WHEEL_HI_RES, int(value))
    ui.syn()

def hscroll(value: int):
    ui.write(ecodes.EV_REL, ecodes.REL_HWHEEL_HI_RES, int(value))
    ui.syn()

def scroll(dwheel: int, hwheel: int):
    # print(f"Scrolling: dwheel={dwheel}, hwheel={hwheel}")
    # Handle horizontal and vertical scrolling
    #if dwheel != 0:
    #    ui.write(ecodes.EV_REL, ecodes.REL_WHEEL, 1 if dwheel > 0 else -1)

    #if hwheel != 0:
    #    ui.write(ecodes.EV_REL, ecodes.REL_HWHEEL, 1 if hwheel > 0 else -1)

    if dwheel != 0:
        ui.write(ecodes.EV_REL, ecodes.REL_WHEEL_HI_RES, dwheel)

    if hwheel != 0:
        ui.write(ecodes.EV_REL, ecodes.REL_HWHEEL_HI_RES, hwheel)

    ui.syn()

def press_key(key_code: int):
    ui.write(ecodes.EV_KEY, key_code, 1)  # Key press
    ui.syn()
    time.sleep(0.05)  # Short delay
    ui.write(ecodes.EV_KEY, key_code, 0)  # Key release
    ui.syn()

def press_key_str(key_str: str):
    key_map = {
        'a': ecodes.KEY_A, 'b': ecodes.KEY_B, 'c': ecodes.KEY_C,
        'd': ecodes.KEY_D, 'e': ecodes.KEY_E, 'f': ecodes.KEY_F,
        'g': ecodes.KEY_G, 'h': ecodes.KEY_H, 'i': ecodes.KEY_I,
        'j': ecodes.KEY_J, 'k': ecodes.KEY_K, 'l': ecodes.KEY_L,
        'm': ecodes.KEY_M, 'n': ecodes.KEY_N, 'o': ecodes.KEY_O,
        'p': ecodes.KEY_P, 'q': ecodes.KEY_Q, 'r': ecodes.KEY_R,
        's': ecodes.KEY_S, 't': ecodes.KEY_T, 'u': ecodes.KEY_U,
        'v': ecodes.KEY_V, 'w': ecodes.KEY_W, 'x': ecodes.KEY_X,
        'y': ecodes.KEY_Y, 'z': ecodes.KEY_Z,
        '0': ecodes.KEY_0, '1': ecodes.KEY_1, '2': ecodes.KEY_2,
        '3': ecodes.KEY_3, '4': ecodes.KEY_4, '5': ecodes.KEY_5,
        '6': ecodes.KEY_6, '7': ecodes.KEY_7, '8': ecodes.KEY_8,
        '9': ecodes.KEY_9,
        'backspace': ecodes.KEY_BACKSPACE,
        'enter': ecodes.KEY_ENTER,
        ' ': ecodes.KEY_SPACE,
    }
    
    key = key_str.lower()
    if key in key_map:
        press_key(key_map[key])

def send_string(text: str):
    CHAR_MAP = {
        'a': (ecodes.KEY_A, False), 'b': (ecodes.KEY_B, False), 'c': (ecodes.KEY_C, False),
        'd': (ecodes.KEY_D, False), 'e': (ecodes.KEY_E, False), 'f': (ecodes.KEY_F, False),
        'g': (ecodes.KEY_G, False), 'h': (ecodes.KEY_H, False), 'i': (ecodes.KEY_I, False),
        'j': (ecodes.KEY_J, False), 'k': (ecodes.KEY_K, False), 'l': (ecodes.KEY_L, False),
        'm': (ecodes.KEY_M, False), 'n': (ecodes.KEY_N, False), 'o': (ecodes.KEY_O, False),
        'p': (ecodes.KEY_P, False), 'q': (ecodes.KEY_Q, False), 'r': (ecodes.KEY_R, False),
        's': (ecodes.KEY_S, False), 't': (ecodes.KEY_T, False), 'u': (ecodes.KEY_U, False),
        'v': (ecodes.KEY_V, False), 'w': (ecodes.KEY_W, False), 'x': (ecodes.KEY_X, False),
        'y': (ecodes.KEY_Y, False), 'z': (ecodes.KEY_Z, False),
        
        'A': (ecodes.KEY_A, True), 'B': (ecodes.KEY_B, True), 'C': (ecodes.KEY_C, True),
        'D': (ecodes.KEY_D, True), 'E': (ecodes.KEY_E, True), 'F': (ecodes.KEY_F, True),
        'G': (ecodes.KEY_G, True), 'H': (ecodes.KEY_H, True), 'I': (ecodes.KEY_I, True),
        'J': (ecodes.KEY_J, True), 'K': (ecodes.KEY_K, True), 'L': (ecodes.KEY_L, True),
        'M': (ecodes.KEY_M, True), 'N': (ecodes.KEY_N, True), 'O': (ecodes.KEY_O, True),
        'P': (ecodes.KEY_P, True), 'Q': (ecodes.KEY_Q, True), 'R': (ecodes.KEY_R, True),
        'S': (ecodes.KEY_S, True), 'T': (ecodes.KEY_T, True), 'U': (ecodes.KEY_U, True),
        'V': (ecodes.KEY_V, True), 'W': (ecodes.KEY_W, True), 'X': (ecodes.KEY_X, True),
        'Y': (ecodes.KEY_Y, True), 'Z': (ecodes.KEY_Z, True),


        '1': (ecodes.KEY_1, False), '2': (ecodes.KEY_2, False), '3': (ecodes.KEY_3, False),
        '4': (ecodes.KEY_4, False), '5': (ecodes.KEY_5, False), '6': (ecodes.KEY_6, False),
        '7': (ecodes.KEY_7, False), '8': (ecodes.KEY_8, False), '9': (ecodes.KEY_9, False),
        '0': (ecodes.KEY_0, False),
        
        '!': (ecodes.KEY_1, True), '@': (ecodes.KEY_2, True), '#': (ecodes.KEY_3, True),
        '$': (ecodes.KEY_4, True), '%': (ecodes.KEY_5, True), '^': (ecodes.KEY_6, True),
        '&': (ecodes.KEY_7, True), '*': (ecodes.KEY_8, True), '(': (ecodes.KEY_9, True),
        ')': (ecodes.KEY_0, True),

        '-': (ecodes.KEY_MINUS, False), '_': (ecodes.KEY_MINUS, True), 
        '=': (ecodes.KEY_EQUAL, False), '+': (ecodes.KEY_EQUAL, True),
        '[': (ecodes.KEY_LEFTBRACE, False), '{': (ecodes.KEY_LEFTBRACE, True),
        ']': (ecodes.KEY_RIGHTBRACE, False), '}': (ecodes.KEY_RIGHTBRACE, True),
        '\\': (ecodes.KEY_BACKSLASH, False), '|': (ecodes.KEY_BACKSLASH, True),
        ';': (ecodes.KEY_SEMICOLON, False), ':': (ecodes.KEY_SEMICOLON, True),
        "'": (ecodes.KEY_APOSTROPHE, False), '"': (ecodes.KEY_APOSTROPHE, True),
        '`': (ecodes.KEY_GRAVE, False), '~': (ecodes.KEY_GRAVE, True),
        ',': (ecodes.KEY_COMMA, False), '<': (ecodes.KEY_COMMA, True),
        '.': (ecodes.KEY_DOT, False), '>': (ecodes.KEY_DOT, True),
        '/': (ecodes.KEY_SLASH, False), '?': (ecodes.KEY_SLASH, True),
        
        # Functional characters
        ' ': (ecodes.KEY_SPACE, False), '\n': (ecodes.KEY_ENTER, False),
        '\t': (ecodes.KEY_TAB, False),
    }

    for char in text:
        try:
            key_code, needs_shift = CHAR_MAP[char]
            
            # 1. Press SHIFT if needed
            if needs_shift:
                # Send SHIFT key press event (hold)
                ui.write(ecodes.EV_KEY, ecodes.KEY_LEFTSHIFT, 1)
                ui.syn()

            # 2. Press the main key (press down then release)
            ui.write(ecodes.EV_KEY, key_code, 1) # Press down
            ui.write(ecodes.EV_KEY, key_code, 0) # Release
            ui.syn() # Synchronize to send event

            # 3. Release SHIFT if it was pressed
            if needs_shift:
                # Send SHIFT key release event
                ui.write(ecodes.EV_KEY, ecodes.KEY_LEFTSHIFT, 0)
                ui.syn()

        except KeyError:
            print(f"Warning: Character '{char}' is not mapped and will be skipped.")

def _run_as_gui_user(cmd):
    return subprocess.run(
        ["sudo", "-u", GUI_USER, "env",
         f"DISPLAY={DISPLAY}",
         f"DBUS_SESSION_BUS_ADDRESS={DBUS}",
         *cmd],
        capture_output=True,
        text=True
    )

def pause_if_playing():
    """Pause media only if playback is currently active."""
    status = _run_as_gui_user(["playerctl", "status"]).stdout.strip()
    if status == "Playing":
        _run_as_gui_user(["playerctl", "pause"])
        return True
    return False

def power_tv_on():
    print("TV_ON")
    send_cmd("TV_ON")

def power_tv_off():
    print("TV_OFF")
    pause_if_playing()
    send_cmd("TV_OFF")

def go_to_search():
    print("SEARCH")
    send_msg({
        "command":"showScreen",
        "value":"Search"
    })

def go_to_home():
    print("HOME")
    send_cmd("HDMI_MELE")
    send_msg({
        "command":"showScreen",
        "value":"Home"
    })

def go_back():
    print("BACK")
    send_msg({
        "command": "webviewGoBack"
    })

def play_pause():
    print("PLAY_PAUSE")
    _run_as_gui_user(["playerctl", "play-pause"])

def sound_mute():
    print("MUTE")
    send_cmd("MUTE_VOLUME")

def sound_unmute():
    print("UNMUTE")
    send_cmd("UNMUTE_VOLUME")

def notify_controller_connected():
    send_msg({
        "command": "setNumberOfControllers",
        "controllers": 1
    })

def notify_controller_disconnected():
    send_msg({
        "command": "setNumberOfControllers",
        "controllers": 0
    })


def change_volume(volume: float):
    if volume < 0:
        print("DECREASE_VOLUME")
        send_cmd("DECREASE_VOLUME ")
    elif volume > 0:
        print("INCREASE_VOLUME")
        send_cmd("INCREASE_VOLUME ")


def check_new_version(current_version: str):
    # Check if a new version availalbe or not
    # - return None if no new version
    # - return tuple ["new_version", "download_url", "min_version", "max_version"] if new version available
    try:
        print(f"Checking for new version for {current_version}")
        obj = requests.get(f"http://18.144.58.226/{current_version}.json").json()
        new_version = obj.get("newVersion")
        min_version = obj.get("minVersion")
        max_version = obj.get("maxVersion")
        download_url = obj.get("downloadUrl")

        return [new_version, download_url, min_version, max_version]
    except Exception as e:
        print(f"Error checking new version: {e}")
        return None

class App:
    tx_char = None

    # thread = None
    is_running = True
    # is_muted = False
    # is_powered_on = False
    # volume = 0
    first_heartbeat = False
    app_version = None

    @classmethod
    def send_app_status(cls):
        try:
            ret = send_msg({
                "command": "getDevInfo"
            })
            obj = json.loads(ret.text)
            print(obj)

            is_muted = obj.get("isMuted", False)
            is_powered_on = obj.get("isPoweredOn", False)
            volume = obj.get("volume", 0)

            response = msg_pb2.Response()
            response.state_updated.is_muted = is_muted
            response.state_updated.is_powered_on = is_powered_on
            response.state_updated.volume = volume / 100.0
            buf = response.SerializeToString()
            cls.tx_char.set_value(list(buf))            

        except Exception as e:
            return
            

    @classmethod
    def periodic_check_new_version(cls):
        while cls.is_running:
            new_version = None
            new_version_url = None

            if cls.app_version:
                result = check_new_version(cls.app_version)
                if result:
                    print(f"New version available: {result[0]} at {result[1]}")
                    new_version = result[0]
                    new_version_url = result[1]
                    min_version = result[2]
                    max_version = result[3]

                    if cls.tx_char:
                        print("Send upgrade request via BLE")
                        response = msg_pb2.Response()
                        response.upgrade_request.new_version = new_version
                        response.upgrade_request.download_url = new_version_url
                        response.upgrade_request.min_version = min_version
                        response.upgrade_request.max_version = max_version

                        buf = response.SerializeToString()
                        cls.tx_char.set_value(list(buf))

            time.sleep(30)  # Check every 30 seconds


    @classmethod
    def on_connect(cls, ble_dev: device.Device):
        print(f'[BLE] Connected: {ble_dev.address}')
        notify_controller_connected()

        cls.is_running = True
        cls.first_heartbeat = True
        cls.app_version = None
        cls.thread = threading.Thread(target=cls.periodic_check_new_version)
        cls.thread.start()

    @classmethod
    def on_disconnect(cls, adapter_addr, dev_addr):
        print(f'[BLE] Disconnected: {dev_addr}')
        notify_controller_disconnected()
        cls.is_running = False
        cls.first_heartbeat = True
        cls.app_version = None
        if cls.thread:
            cls.thread.join()

    @classmethod
    def on_muted_changed(cls, is_muted: bool):
        print(f"[BLE] Muted changed: {is_muted}")

        response = msg_pb2.Response()
        response.mute_change.is_muted = is_muted
        buf = response.SerializeToString()
        cls.tx_char.set_value(list(buf))

    @classmethod
    def on_power_changed(cls, is_powered: bool):
        print(f"[BLE] Power changed: {is_powered}")

        response = msg_pb2.Response()
        response.power_change.is_powered_on = is_powered
        buf = response.SerializeToString()
        cls.tx_char.set_value(list(buf))

    @classmethod
    def on_volume_changed(cls, volume: float):
        print(f"[BLE] Volume changed: {volume}")

        response = msg_pb2.Response()
        response.volume_change.volume = volume
        buf = response.SerializeToString()
        cls.tx_char.set_value(list(buf))

    @classmethod
    def tx_notify_state(cls, notifying, characteristic):
        cls.tx_char = characteristic if notifying else None
        print(f'[BLE] TX notifying = {notifying}')

    @classmethod
    def rx_write(cls, value, options):
        data = bytes(value)
        evt = msg_pb2.InputEvent()
        evt.ParseFromString(data)

        which = evt.WhichOneof("payload")
        match which:
            case "mouse_move":
                dx = evt.mouse_move.dx
                dy = evt.mouse_move.dy
                rel_move(dx, dy)

            case "mouse_click":
                button = evt.mouse_click.button

                if button == msg_pb2.MouseButton.MOUSE_BUTTON_LEFT:
                    leftmouse_click()

            case "mouse_vscroll":
                value = evt.mouse_vscroll.value
                vscroll(value)

            case "mouse_hscroll":
                value = evt.mouse_hscroll.value
                hscroll(value)

            case "key_string":
                key1 = evt.key_string.str
                send_string(key1)

            case "key_control":
                key2 = evt.key_control.key
                cmd = ({
                    msg_pb2.KeyControl.KEY_BACKSPACE: "backspace",
                    msg_pb2.KeyControl.KEY_ENTER: "enter",
                    msg_pb2.KeyControl.KEY_ESCAPE: "escape",
                }).get(key2, None)   

                press_key_str(cmd)

            case "control_button":
                btn = evt.control_button.type

                match btn:
                    case msg_pb2.ControlType.TYPE_POWER_ON:
                        power_tv_on()
                    case msg_pb2.ControlType.TYPE_POWER_OFF:
                        power_tv_off()
                    case msg_pb2.ControlType.TYPE_SEARCH:
                        go_to_search()
                    case msg_pb2.ControlType.TYPE_HOME:
                        go_to_home()
                    case msg_pb2.ControlType.TYPE_BACK:
                        go_back()
                    case msg_pb2.ControlType.TYPE_PLAY_PAUSE:
                        play_pause()
                    case msg_pb2.ControlType.TYPE_MUTE_UNMUTE:
                        is_muted = evt.control_button.value == 1

                        if is_muted:
                            sound_unmute()
                        else:
                            sound_mute()

            case "heart_beat":
                cls.app_version = evt.heart_beat.version

                if cls.tx_char:
                    print("Replying to heartbeat")
                    response = msg_pb2.Response()
                    response.heart_beat.seq = 0

                    buf = response.SerializeToString()
                    cls.tx_char.set_value(list(buf))

                if cls.first_heartbeat:
                    cls.send_app_status()
                    cls.first_heartbeat = False

            case "volume_change":
                volume = evt.volume_change.volume
                change_volume(volume)


_STABLE_CODE_FILE = "/var/lib/displace/tv_code"  # persisted override/cache

def _hash_to_6_digits(seed: str) -> str:
    h = hashlib.sha1(seed.encode("utf-8")).digest()
    # big int -> 6 digits, zero-padded
    return f"{int.from_bytes(h[:6], 'big') % 1_000_000:06d}"

def _read_first(path: str) -> str | None:
    try:
        s = _read(path)
        return s if s else None
    except Exception:
        return None

def get_system_uuid() -> str:
    """
    Return a stable string that uniquely identifies this machinecodes.
    Order of preference:
      1) /etc/machine-id
      2) DMI product_uuid
      3) First real NIC MAC (non-virtual, non-loopback)
      4) Hostname
    No Bluetooth/HCI dependency.
    """
    candidates: list[str] = []

    # 1) Machine ID (most stable on Linux)
    mi = _read_first("/etc/machine-id")
    if mi:
        candidates.append(f"mi:{mi}")

    # 2) DMI product UUID (fairly stable on physical machines)
    dmi = _read_first("/sys/class/dmi/id/product_uuid")
    if dmi:
        candidates.append(f"dmi:{dmi}")

    # 3) First real NIC MAC (skip virtual/loopback/tunnels/containers)
    try:
        skip_prefixes = (
            "lo", "docker", "veth", "br-", "virbr", "tun", "tap", "wg",
            "tailscale", "ts", "zt", "cilium", "flannel", "kube"
        )
        for iface in sorted(os.listdir("/sys/class/net")):
            if any(iface.startswith(p) for p in skip_prefixes):
                continue
            # optional: skip if it's clearly virtual
            typ = _read(f"/sys/class/net/{iface}/type")  # '1' == ARPHRD_ETHER
            if typ is not None and typ.strip() != "1":
                continue
            mac = _read(f"/sys/class/net/{iface}/address")
            if mac and mac != "00:00:00:00:00:00":
                candidates.append(f"nic:{iface}:{mac}")
                break
    except Exception:
        pass

    # 4) Hostname as last fallback
    try:
        hn = socket.gethostname()
        if hn:
            candidates.append(f"host:{hn}")
    except Exception:
        pass

    if not candidates:
        # absolute last resort: random but persisted (callers typically hash anyway)
        return secrets.token_hex(8)

    return "|".join(candidates)

def get_stable_tv_code_6() -> str:
    """
    Returns a 6-digit code that is stable for this TV (and unique across TVs).
    - If /var/lib/displace/tv_code exists and looks valid, use it.
    - Else derive from system UUID and persist it for future runs.
    """
    # env override (optional)
    env_override = os.environ.get("DISPLACE_TV_CODE", "").strip()
    if env_override.isdigit() and len(env_override) == 6:
        return env_override

    try:
        p = pathlib.Path(_STABLE_CODE_FILE)
        if p.is_file():
            s = p.read_text().strip()
            if s.isdigit() and len(s) == 6:
                return s
    except Exception:
        pass

    seed = get_system_uuid()
    code = _hash_to_6_digits(f"displace|v1|{seed}")

    # best-effort persist so it never changes even if hardware identifiers do
    try:
        p = pathlib.Path(_STABLE_CODE_FILE)
        p.parent.mkdir(parents=True, exist_ok=True)
        p.write_text(code)
    except Exception:
        # non-fatal if we can’t write; code is still stable as long as seed stays
        pass

    return code

# def get_random_6_digit() -> str:
#     """Returns a cryptographically strong random 6-digit code each run."""
#     return f"{secrets.randbelow(1_000_000):06d}"

def get_random_6_digit() -> str:
    """
    Returns a 6-digit code persisted in ./pairing_code next to this script.
    If the file exists and is valid, reuse it; otherwise generate, save, and return.
    """
    path = Path(__file__).resolve().parent / "pairing_code"

    # Try to read an existing code
    try:
        if path.is_file():
            s = path.read_text(encoding="utf-8").strip()
            if s.isdigit() and len(s) == 6:
                return s
    except Exception:
        # If we can't read/parse, we'll regenerate below
        pass

    # Generate a fresh code
    code = f"{secrets.randbelow(1_000_000):06d}"

    # Best-effort atomic write with restrictive perms
    try:
        tmp = path.with_suffix(".tmp")
        with open(tmp, "w", encoding="utf-8") as f:
            try:
                os.fchmod(f.fileno(), 0o600)  # ensure 0600 on supported systems
            except Exception:
                pass
            f.write(code)
        os.replace(tmp, path)  # atomic on POSIX
    except Exception:
        # If persisting fails, still return the generated code
        pass

    return code

def _bluezero_soft_reset(adpt) -> None:
    try:
        # Toggle power and discoverable a couple of times
        adpt.powered = False
        time.sleep(0.2)
        adpt.powered = True
        try:
            adpt.pairable = True
        except Exception:
            pass
        try:
            adpt.discoverable = False
            time.sleep(0.1)
            adpt.discoverable = True
        except Exception:
            pass
    except Exception:
        pass

def _try_power_on_bluezero(adapter_obj) -> bool:
    try:
        if not getattr(adapter_obj, 'powered', False):
            adapter_obj.powered = True
        return bool(adapter_obj.powered)
    except Exception:
        return False

def _prep_adapter(adpt, info: dict) -> None:
    """
    Try to bring adapter into a sane state before advertising.
    Uses btmgmt when we have hci, else Bluezero toggles.
    """
    _rfkill_unblock_bluetooth()
    if info.get('hci') and info['hci'] != '?':
        _btmgmt_soft_reset(info['hci'])
    else:
        _bluezero_soft_reset(adpt)
    # Final check via Bluezero
    _try_power_on_bluezero(adpt)

def _build_and_publish_peripheral(adapter_addr: str, tv_code: str):
    """
    Build the Peripheral, add services/chars, and publish.
    This is broken out so we can call it repeatedly on retries.
    """
    dongle = adapter.Adapter(adapter_addr)
    dongle.alias = tv_code

    local_server = LocalServer(
        port=7000,
        mutedChangedCallback=lambda x: App.on_muted_changed(x),
        powerChangedCallback=lambda x: App.on_power_changed(x),
        volumeChangedCallback=lambda x: App.on_volume_changed(x)
    )
    local_server_thread = threading.Thread(target=local_server.start_server, daemon=True)
    local_server_thread.start()

    periph = peripheral.Peripheral(
        adapter_address=adapter_addr,
        local_name=tv_code
    )

    periph.add_service(srv_id=1, uuid=SERVICE_UUID, primary=True)

    periph.add_characteristic(
        srv_id=1, chr_id=1, uuid=RX_UUID,
        value=[], notifying=False,
        flags=['write', 'write-without-response'],
        write_callback=App.rx_write,
        read_callback=None, notify_callback=None)

    periph.add_characteristic(
        srv_id=1, chr_id=2, uuid=TX_UUID,
        value=[], notifying=False,
        flags=['notify'],
        notify_callback=App.tx_notify_state,
        read_callback=None, write_callback=None)

    periph.on_connect = App.on_connect
    periph.on_disconnect = App.on_disconnect

    periph.publish()
    return periph

def main():
    tv_code = get_stable_tv_code_6()
    pairing_code = get_random_6_digit()

    print(f"[BLE] System UUID: {get_system_uuid()}")
    print(f"[BLE] TV Code (stable 6-digit): {tv_code}")
    print(f"[BLE] Pairing code (session):   {pairing_code}")

    send_msg({"command": "generateCode", "tv_code": tv_code, "pairing_code": pairing_code})

    adapters_list = list(adapter.Adapter.available())
    print(f'[BLE] Available adapters ({len(adapters_list)}):')
    for i, a in enumerate(adapters_list):
        print(f'  [{i}] {getattr(a,"address","<unknown>")} {getattr(a,"name","")}')

    if not adapters_list:
        raise SystemExit('[BLE] No BLE adapter found')

    # Choose purely by Manufacturer ID (non-Intel preferred, else Intel)
    chosen_obj, info = pick_adapter_by_manufacturer(adapters_list)

    # Ensure it’s powered via Bluezero, no btmgmt needed
    _try_power_on_bluezero(chosen_obj)

    # Robustly get address
    try:
        adapter_addr = getattr(chosen_obj, 'address')
    except Exception:
        adapter_addr = '<unknown>'

    print(f"[BLE] Chosen: {adapter_addr} (name='{info['name']}', manufacturer=0x{(info['mfr'] or '????')}, intel={info['is_intel']})")

    # Retry loop stays the same
    max_attempts = 5
    base_sleep = 0.5
    last_err = None
    for attempt in range(1, max_attempts + 1):
        try:
            _bluezero_soft_reset(chosen_obj)  # simple reset only
            print(f'[BLE] Advertising as "{tv_code}" with service {SERVICE_UUID} (attempt {attempt}/{max_attempts})')
            periph = _build_and_publish_peripheral(adapter_addr, tv_code)
            return
        except Exception as e:
            last_err = e
            print(f"[BLE] Advertise attempt {attempt} failed: {type(e).__name__}: {e}")
            time.sleep(min(base_sleep * (2 ** (attempt - 1)), 3.0))

    raise SystemExit(f"[BLE] Failed to start advertising after {max_attempts} attempts: {type(last_err).__name__}: {last_err}")


if __name__ == '__main__':
    main()
