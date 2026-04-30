# AGENTS.md — screen-follow

## Stealth Quad — Verify Layer
- **Orchestrator:** [stealth-runner](https://github.com/OpenSIN-AI/stealth-runner)
- **HIDE:** [playstealth-cli](https://github.com/SIN-CLIs/playstealth-cli)
- **ACT:** [skylight-cli](https://github.com/SIN-CLIs/skylight-cli)
- **SENSE:** [unmask-cli](https://github.com/SIN-CLIs/unmask-cli)

## CLI
```bash
screen-follow record --video --output /tmp/demo.mp4
screen-follow stop
screen-follow status
screen-follow trace --last 20
screen-follow              # GUI (Klic-basiert)
```

## Architektur
- **EventBus** (Combine) — zentraler Event-Publisher
- **SystemEventTap** — EIN CGEventTap für Maus + Tastatur + Scroll
- **ScreenRecorder** — ScreenCaptureKit + AVAssetWriter
- **EventAuditLogger** — JSONL-Audit-Trail
- **Klic-basiert** — cursor trails, keyboard overlay, mouse effects (MIT)
