#!/usr/bin/env python3

import struct, time
import subprocess
import socket
from gi.repository import GLib
from bluezero import adapter, peripheral, device
from evdev import UInput, ecodes
import requests

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
PKT_FMT = "<B I f f B B h h c B"
PKT_SIZE = struct.calcsize(PKT_FMT)  # = 11 bytes

SERVICE_UUID = '12345678-1234-5678-1234-56789abcdef0'
RX_UUID = '12345678-1234-5678-1234-56789abcdef1'
TX_UUID = '12345678-1234-5678-1234-56789abcdef2'
LOCAL_NAME = 'ABCDEF'

ALPHA = 1.0 # 0.35

cap = {
    ecodes.EV_KEY: [
        ecodes.BTN_LEFT,

        # Các phím chữ cái (A-Z)
        ecodes.KEY_A, ecodes.KEY_B, ecodes.KEY_C, ecodes.KEY_D,
        ecodes.KEY_E, ecodes.KEY_F, ecodes.KEY_G, ecodes.KEY_H,
        ecodes.KEY_I, ecodes.KEY_J, ecodes.KEY_K, ecodes.KEY_L,
        ecodes.KEY_M, ecodes.KEY_N, ecodes.KEY_O, ecodes.KEY_P,
        ecodes.KEY_Q, ecodes.KEY_R, ecodes.KEY_S, ecodes.KEY_T,
        ecodes.KEY_U, ecodes.KEY_V, ecodes.KEY_W, ecodes.KEY_X,
        ecodes.KEY_Y, ecodes.KEY_Z,

        # Các phím số (0-9)
        ecodes.KEY_0, ecodes.KEY_1, ecodes.KEY_2, ecodes.KEY_3,
        ecodes.KEY_4, ecodes.KEY_5, ecodes.KEY_6, ecodes.KEY_7,
        ecodes.KEY_8, ecodes.KEY_9,

        # Các phím ký tự/dấu câu/toán tử cơ bản
        ecodes.KEY_SPACE, ecodes.KEY_MINUS, ecodes.KEY_EQUAL,
        ecodes.KEY_LEFTBRACE, ecodes.KEY_RIGHTBRACE, ecodes.KEY_BACKSLASH,
        ecodes.KEY_SEMICOLON, ecodes.KEY_APOSTROPHE, ecodes.KEY_GRAVE,
        ecodes.KEY_COMMA, ecodes.KEY_DOT, ecodes.KEY_SLASH,

        # Các phím Chức năng (Functional/Control keys)
        ecodes.KEY_ENTER, ecodes.KEY_BACKSPACE, ecodes.KEY_TAB,
        ecodes.KEY_CAPSLOCK, ecodes.KEY_LEFTSHIFT, ecodes.KEY_RIGHTSHIFT,
        ecodes.KEY_LEFTCTRL, ecodes.KEY_RIGHTCTRL, ecodes.KEY_LEFTALT,
        ecodes.KEY_RIGHTALT, ecodes.KEY_LEFTMETA, ecodes.KEY_RIGHTMETA,

        # Các phím Mũi tên (Arrows)
        ecodes.KEY_UP, ecodes.KEY_DOWN, ecodes.KEY_LEFT, ecodes.KEY_RIGHT,

        # Các phím F-keys (F1-F12)
        ecodes.KEY_F1, ecodes.KEY_F2, ecodes.KEY_F3, ecodes.KEY_F4,
        ecodes.KEY_F5, ecodes.KEY_F6, ecodes.KEY_F7, ecodes.KEY_F8,
        ecodes.KEY_F9, ecodes.KEY_F10, ecodes.KEY_F11, ecodes.KEY_F12,

        # Phím điều khiển khác
        ecodes.KEY_INSERT, ecodes.KEY_DELETE, ecodes.KEY_HOME, ecodes.KEY_END,
        ecodes.KEY_PAGEUP, ecodes.KEY_PAGEDOWN, ecodes.KEY_ESC,
        ecodes.KEY_SYSRQ, # Print Screen/SysRq
        ecodes.KEY_SCROLLLOCK,
        ecodes.KEY_PAUSE, # Pause/Break
    ],
    ecodes.EV_REL: [ecodes.REL_X, ecodes.REL_Y, ecodes.REL_WHEEL, ecodes.REL_HWHEEL],
}
ui = UInput(cap, name="DisplaceTrackpad", bustype=ecodes.BUS_USB)


def send_msg(obj):
    requests.post('http://127.0.0.1:5564/command', json=obj)

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

def left_button(down: bool):
    ui.write(ecodes.EV_KEY, ecodes.BTN_LEFT, 1 if down else 0)
    ui.syn()

def scroll(dwheel: int, hwheel: int):
    # print(f"Scrolling: dwheel={dwheel}, hwheel={hwheel}")
    # Handle horizontal and vertical scrolling
    if dwheel != 0:
        ui.write(ecodes.EV_REL, ecodes.REL_WHEEL, 1 if dwheel > 0 else -1)
    if hwheel != 0:
        ui.write(ecodes.EV_REL, ecodes.REL_HWHEEL, 1 if hwheel > 0 else -1)
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
        'enter': ecodes.KEY_ENTER
    }
    
    key = key_str.lower()
    if key in key_map:
        press_key(key_map[key])

class App:
    tx_char = None

    @classmethod
    def on_connect(cls, ble_dev: device.Device):
        print(f'[BLE] Connected: {ble_dev.address}')

    @classmethod
    def on_disconnect(cls, adapter_addr, dev_addr):
        print(f'[BLE] Disconnected: {dev_addr}')

    @classmethod
    def tx_notify_state(cls, notifying, characteristic):
        cls.tx_char = characteristic if notifying else None
        print(f'[BLE] TX notifying = {notifying}')

    @classmethod
    def rx_write(cls, value, options):
        data = bytes(value)
        #try:
        #    text = data.decode('utf-8')
        #except UnicodeDecodeError:
        #    text = repr(data)
        # print(f'[BLE] RX <= {text}  (len={len(data)})  options={options}')

        # ev = json.loads(text)
        if len(data) != PKT_SIZE:
            print(f"Invalid packet size: {len(data)}")
            return

        typ, t_ms, dx, dy, btn, down, dwheel, hwheel, k1, k2 = struct.unpack(PKT_FMT, data)

        # typ = ev.get("type")
        if typ == 1: # "move"
            # dx = float(ev.get("dx", 0.0))
            # dy = float(ev.get("dy", 0.0))
            rel_move(dx, dy)
        elif typ == 2:
            if btn == 0: # "left"
                # down = bool(ev.get("down", False))
                left_button(down)
        elif typ == 3:
            scroll(dwheel, hwheel)
        elif typ == 4:
            send_msg({
                "command":"showScreen",
                "value":"Home"
            })
        elif typ == 5:
            send_msg({
                "command": "webviewGoBack"
            })
        elif typ == 6:
            send_msg({
                "command":"showScreen",
                "value":"Search"
            })
        elif typ == 7:
            # Play-Pause
            subprocess.run(["playerctl", "play-pause"])
        elif typ == 8:
            # Power on
            pass
        elif typ == 9:
            # Power off
            send_cmd("TV_OFF")
        elif typ == 10:
            key1 = k1.decode()
            key2 = k2
            if key2 == 0:
                press_key_str(key1)
            else:
                if key2 == 1:
                    press_key_str("backspace")
                elif key2 == 2:
                    press_key_str("enter")

        if cls.tx_char:
            cls.tx_char.set_value(list(data))
            # print('[BLE] TX => echoed')


def main():
    send_msg({
        "command": "generateCode",
        "tv_code": "ABCDEF",
        "pairing_code": "123456"
    })

    adapters = list(adapter.Adapter.available())
    print(f'[BLE] Available adapters ({len(adapters)}):')
    for i, a in enumerate(adapters):
        addr = getattr(a, 'address', '<unknown>')
        name = getattr(a, 'name', '')
        print(f'  [{i}] {addr} {name}')
    if not adapters:
        raise SystemExit('[BLE] No BLE adapter found')

    adpt = adapters[0]
    adapter_addr = adpt.address

    periph = peripheral.Peripheral(
        adapter_address=adapter_addr,
        local_name=LOCAL_NAME
    )

    periph.add_service(srv_id=1, uuid=SERVICE_UUID, primary=True)

    periph.add_characteristic(
        srv_id=1,
        chr_id=1,
        uuid=RX_UUID,
        value=[],
        notifying=False,
        flags=['write', 'write-without-response'],
        write_callback=App.rx_write,
        read_callback=None,
        notify_callback=None,
    )

    periph.add_characteristic(
        srv_id=1,
        chr_id=2,
        uuid=TX_UUID,
        value=[],
        notifying=False,
        flags=['notify'],
        notify_callback=App.tx_notify_state,
        read_callback=None,
        write_callback=None,
    )

    periph.on_connect = App.on_connect
    periph.on_disconnect = App.on_disconnect

    print(f'[BLE] Advertising as "{LOCAL_NAME}" with service {SERVICE_UUID}')
    periph.publish()


if __name__ == '__main__':
    main()
