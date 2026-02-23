# Home Assistant Apps

### ESPHome (`5c53de3b_esphome`)

Default config.

---

### File Editor (`core_configurator`)

```yaml
dirsfirst: false
enforce_basepath: true
git: true
ignore_pattern:
  - __pycache__
  - .cloud
  - .storage
  - deps
ssh_keys: []
```

---

### Frigate Proxy (`ccab4aaf_frigate-proxy`)

TODO

---

### Git Pull (`core_git_pull`)

```yaml
repository: git@github.com:merichar/ha-config.git
git_branch: main
git_remote: origin
auto_restart: true
restart_ignore:
  - .gitignore
  - ci
  - .github
  - README.md
  - LICENSE
git_command: pull
git_prune: true
deployment_key: []        # secret; contents from ~/.ssh/id_ed25519
deployment_key_protocol: ed25519
repeat:
  active: false
  interval: 300
```

---

### Let's Encrypt (`core_letsencrypt`)

```yaml
keyfile: privkey.pem
certfile: fullchain.pem
challenge: dns            # chosen
dns:
  provider: dns-cloudflare          # chosen
  cloudflare_api_token: "..."       # secret
domains:
  - "*.par.bar"           # chosen
email: webmaster@par.bar  # chosen
```

---

### MariaDB (`core_mariadb`)

```yaml
databases:
  - homeassistant
logins:
  - username: homeassistant
    password: "..."        # secret
rights:
  - username: homeassistant
    database: homeassistant
```

---

### Mosquitto (`core_mosquitto`)

TODO

---

### NGINX Home Assistant SSL Proxy (`core_nginx_proxy`)

```yaml
domain: hass.par.bar      # chosen
hsts: ""
certfile: fullchain.pem
keyfile: privkey.pem
cloudflare: false
use_ssl_backend: false
customize:
  active: false
  default: nginx_proxy_default*.conf
  servers: nginx_proxy/*.conf
real_ip_from: []
```

---

### OpenWakeWord (`core_openwakeword`)

```yaml
threshold: 0.5
trigger_level: 1
debug_logging: false
```

---

### Piper (`core_piper`)

```yaml
voice: en_US-lessac-medium  # chosen
speaker: 0
length_scale: 1
noise_scale: 0.667
noise_w: 0.333
debug_logging: false
update_voices: true
```

---

### SSH & Web Terminal (`core_ssh`)

```yaml
authorized_keys: []
password: ""
apks: []
server:
  tcp_forwarding: false
```

---

### Whisper (`core_whisper`)

```yaml
model: base               # chosen (default: tiny)
language: en              # chosen (default: auto)
beam_size: 1
custom_model_type: faster-whisper
stt_library: auto
debug_logging: false
```
