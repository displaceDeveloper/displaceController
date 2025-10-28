#!/usr/bin/env python3

import struct, time
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
PKT_FMT = "<B I f f B B h h"
PKT_SIZE = struct.calcsize(PKT_FMT)  # = 11 bytes

SERVICE_UUID = '12345678-1234-5678-1234-56789abcdef0'
RX_UUID = '12345678-1234-5678-1234-56789abcdef1'
TX_UUID = '12345678-1234-5678-1234-56789abcdef2'
LOCAL_NAME = 'ABCDEF'

ALPHA = 1.0 # 0.35

cap = {
    ecodes.EV_KEY: [ecodes.BTN_LEFT],
    ecodes.EV_REL: [ecodes.REL_X, ecodes.REL_Y, ecodes.REL_WHEEL, ecodes.REL_HWHEEL],
}
ui = UInput(cap, name="DisplaceTrackpad", bustype=ecodes.BUS_USB)

# EMA state
# vx, vy = 0.0, 0.0

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
    print(f"Scrolling: dwheel={dwheel}, hwheel={hwheel}")
    # Handle horizontal and vertical scrolling
    if dwheel != 0:
        ui.write(ecodes.EV_REL, ecodes.REL_WHEEL, 1 if dwheel > 0 else -1)
    if hwheel != 0:
        ui.write(ecodes.EV_REL, ecodes.REL_HWHEEL, 1 if hwheel > 0 else -1)
    ui.syn()


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

        typ, t_ms, dx, dy, btn, down, dwheel, hwheel = struct.unpack(PKT_FMT, data)

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

        if cls.tx_char:
            cls.tx_char.set_value(list(data))
            # print('[BLE] TX => echoed')


def main():
    requests.post('http://127.0.0.1:5564/command', json={
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
