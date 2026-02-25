# ESPHome Config

## Devices

### [Family Room Soundbar Control](family-room-soundbar-control.yaml) (`family-room-soundbar-control.yaml`)
M5Stack Atom S3 Lite. IR blaster for Yamaha ATS-1070 soundbar (NEC, address 0x8778). Power, volume, etc. Physical button toggles power.

### [Family Room Tetris Switch](family-room-tetris-switch.yaml) (`family-room-tetris-switch.yaml`)
M5Stack Atom Echo. Push-to-talk voice assistant with external rotary switch.

### [Laundry Room Presence](laundry-room-presence.yaml) (`laundry-room-presence.yaml`)
M5Stack Atom Lite. PIR motion sensor.

### [Laundry Room TV Control](laundry-room-tv-control.yaml) (`laundry-room-tv-control.yaml`)
M5Stack Atom Echo. IR blaster for Samsung TV. Power, volume, etc. Push-to-talk voice assistant on physical button.

---

## Project Structure

```
├── common/                    # Shared config packages
│   ├── base.yaml              # Logger, time, status, uptime, restart, factory reset
│   ├── net/
│   │   ├── wifi.yaml          # WiFi with signal strength reporting
│   │   └── ethernet.yaml      # Ethernet connectivity
│   └── device/
│       └── m5stack-atom/
│           ├── base.yaml                      # Board, LED, internal temp
│           ├── button-simple.yaml             # Single-click button (GPIO39)
│           ├── button-multi.yaml              # Multi-click button (GPIO39)
│           ├── i2s.yaml                       # I2S audio bus (GPIO33/19)
│           ├── mic.yaml                       # I2S microphone (GPIO23)
│           ├── speaker.yaml                   # I2S speaker (GPIO22)
│           ├── media-player.yaml              # Speaker-based media player
│           ├── ir.yaml                        # IR transmitter (GPIO12)
│           ├── i2c-grove.yaml                 # I2C Grove connector (GPIO26/32)
│           ├── voice-assistant-ptt.yaml       # Push-to-talk voice assistant
│           ├── voice-assistant-wakeword.yaml  # Wake word voice assistant
│           └── profiles/
│               ├── echo.yaml          # Atom Echo profile (base, button, audio)
│               └── lite.yaml          # Atom Lite profile (base, button, IR, I2C)
│       └── m5stack-atom-s3/
│           ├── base.yaml                      # Board, internal temp (ESP32-S3)
│           ├── button.yaml                    # Built-in button (GPIO41)
│           ├── neopixel.yaml                  # RGB LED (GPIO35, S3 Lite only)
│           ├── ir-lite.yaml                   # IR transmitter (GPIO4, S3 Lite)
│           ├── ir-echo.yaml                   # IR transmitter (GPIO47, S3 Echo)
│           └── profiles/
│               ├── lite.yaml          # S3 Lite profile (base, neopixel, button, IR)
│               └── echo.yaml          # S3 Echo profile (base, button, IR)
├── ci/
│   └── secrets/               # Placeholder secrets for CI (mirrors main structure)
│       ├── common/
│       │   ├── base.yaml
│       │   └── net/
│       │       ├── wifi.yaml
│       │       └── ethernet.yaml
│       ├── family-room-soundbar-control.yaml
│       ├── family-room-tetris-switch.yaml
│       ├── laundry-room-presence.yaml
│       └── laundry-room-tv-control.yaml
└── secrets.yaml               # Real secrets (git-ignored)
```

---

## Secrets

Real secrets live in `secrets.yaml` (git-ignored). Each device and common config references secrets with `!secret <key>`.

CI uses placeholder secrets from `ci/secrets/`, merged at build time. When adding a new device or secret, add a corresponding entry in `ci/secrets/`.

---

## CI

Two GitHub Actions jobs run on push to `main` and on pull requests targeting `esphome/**`:

1. **Validate** — merges `ci/secrets/`, runs `esphome config` on all device configs
2. **Compile** — runs `esphome compile` on all device configs (only runs if Validate passes)

---

## Adding a New Device

1. Create `DEVICE_NAME.yaml` in the root
2. Add device secrets to `secrets.yaml`
3. Add placeholder secrets to `ci/secrets/<device-name>.yaml`
4. Include shared packages as needed

**Example: `meg-office-presence.yaml`**

```yaml
substitutions:
  name: "meg-office-presence"
  friendly_name: "Meg Office Presence"
  mac_address: !secret mac_address_meg_office_presence
  ip_address: "10.2.2.20"

packages:
  common: !include ./common/base.yaml
  net_wifi: !include ./common/net/wifi.yaml
  device: !include ./common/device/m5stack-atom/base.yaml
  button: !include ./common/device/m5stack-atom/button-simple.yaml

esphome:
  name: "${name}"
  friendly_name: "${friendly_name}"

api:
  encryption:
    key: !secret api_key_meg_office_presence

ota:
  - platform: esphome
    password: !secret ota_password_meg_office_presence

binary_sensor:

  - platform: gpio
    pin: GPIO32
    name: "Motion"
    device_class: motion
    filters:
      - delayed_on: 10ms
      - delayed_off: 10ms
```

**`secrets.yaml`** (add entries):
```yaml
mac_address_meg_office_presence: "aa:bb:cc:dd:ee:ff"
api_key_meg_office_presence: "YOUR_API_KEY"
ota_password_meg_office_presence: "YOUR_OTA_PASSWORD"
```

**`ci/secrets/meg-office-presence.yaml`** (placeholder values):
```yaml
mac_address_meg_office_presence: "aa:bb:cc:dd:ee:ff"
api_key_meg_office_presence: "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="
ota_password_meg_office_presence: "dummy"
```
