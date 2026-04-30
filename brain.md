# brain.md — screen-follow v0.2.1

> **Stealth Quad Verify Layer** — Video + JSONL Audit + Element-Label-Logging

## Architektur
- **EventBus** (Combine) — zentraler Publisher
- **SystemEventTap** — EIN CGEventTap für Maus + Tastatur + Scroll
- **ScreenRecorder** — ScreenCaptureKit + AVAssetWriter
- **EventAuditLogger** — JSONL mit elementRole + elementLabel via AXUIElementCopyElementAtPosition
- **Klic-basiert** — Cursor Trails, Keyboard Overlay, Mouse Effects (MIT)

## CLI
```
screen-follow              → GUI (Live-Overlays + Audit)
screen-follow record --video → Video + JSONL
screen-follow status        → Recording-Status
screen-follow trace --last 50 → Audit-Events
screen-follow stop          → Aufnahme beenden
```

## Integration in stealth-runner
`learn_from_session()` in `stealth-runner/src/stealth_runner/learn.py` liest den Audit-Log und generiert Skills.
