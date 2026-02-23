# Home Assistant Config

## Structure

```
├── esphome/               # ESPHome device configs (see esphome/README.md)
├── .github/workflows/     # GitHub Actions workflows
│   ├── esphome-ci.yml     # ESPHome validate & compile
│   └── ci.yml             # CI checks (lint, etc.)
├── .yamllint              # yamllint config
└── .dir-locals.el         # Emacs yaml-mode config
```

---

## Secrets

Each component has its own `secrets.yaml` (git-ignored):
- `secrets.yaml` — HA secrets
- `esphome/secrets.yaml` — ESPHome secrets

---

## CI

Workflows only run when their relevant directories change:
- **ESPHome: Validate & Compile** — runs on changes to `esphome/**`
- **CI** — runs on changes to any `.yaml`/`.yml` file

---

## Development

### Linting

Configured via `.yamllint`. Run locally with:

```bash
uvx yamllint .
```

---

## Deployment

This repo syncs to HA's `/config/` directory via the Git pull app.
