# AGENTS.md — screen-follow

## Stealth Quad — Verify Layer
- **Orchestrator:** [stealth-runner](https://github.com/OpenSIN-AI/stealth-runner)
- **HIDE:** [playstealth-cli](https://github.com/SIN-CLIs/playstealth-cli)
- **ACT:** [skylight-cli](https://github.com/SIN-CLIs/skylight-cli)
- **SENSE:** [unmask-cli](https://github.com/SIN-CLIs/unmask-cli)
- **Vision:** NVIDIA Nemotron 3 Nano Omni → analysiert Aufnahmen via Rolling Video Buffer

## CLI
```bash
screen-follow record --video --output /tmp/demo.mp4
screen-follow stop
screen-follow status
screen-follow trace --last 20
screen-follow              # GUI (Klic-basiert)
```

## Integration mit Nemotron Omni
- `screen-follow record --video` = Rolling Buffer Quelle für Omni
- ffmpeg extrahiert 4-Sekunden-Clips → base64 → NVIDIA NIM
- Omni analysiert temporal (Conv3D): Seitenübergänge, Captchas, Fehler

## Architektur
- **EventBus** (Combine) — zentraler Event-Publisher
- **SystemEventTap** — EIN CGEventTap für Maus + Tastatur + Scroll
- **ScreenRecorder** — ScreenCaptureKit + AVAssetWriter
- **EventAuditLogger** — JSONL-Audit-Trail
- **Klic-basiert** — cursor trails, keyboard overlay, mouse effects (MIT)

## graphify

This project has a graphify knowledge graph at graphify-out/.

Rules:
- Before answering architecture or codebase questions, read graphify-out/GRAPH_REPORT.md for god nodes and community structure
- If graphify-out/wiki/index.md exists, navigate it instead of reading raw files
- For cross-module "how does X relate to Y" questions, prefer `graphify query "<question>"`, `graphify path "<A>" "<B>"`, or `graphify explain "<concept>"` over grep — these traverse the graph's EXTRACTED + INFERRED edges instead of scanning files
- After modifying code files in this session, run `graphify update .` to keep the graph current (AST-only, no API cost)
