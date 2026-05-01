# brain.md - Systemwissen (2026-05-01)

## screen-follow Kern
- **Tech:** Swift, ScreenCaptureKit + AVAssetWriter
- **CLI:** `record --video` (MP4 + Audio), `stop`, `status`, `trace --last N`
- **Erzeugt:** MP4-Videodateien + JSONL-Audit-Trail (EventBus, SystemEventTap)
- **Rolling Buffer:** 4-Sekunden-Clips für Omni temporal analysis
- **Integration:** `screen-follow record --video` → ffmpeg clip → Omni Conv3D
- **Ausgabedatei:** `/tmp/omni_session.mp4` (via `--output`)

## Nutzung in stealth-runner
```bash
# 1. Daueraufnahme starten (vor Build/Debug)
screen-follow record --video --output /tmp/omni_session.mp4

# 2. Im LiveOmniMonitor: rolling buffer extrahiert 4s-Clips
ffmpeg -sseof -4 -i /tmp/omni_session.mp4 -c copy /tmp/omni_clip.mp4

# 3. Omni analysiert temporal (Conv3D)
→ Seitenübergänge, Captchas, Fehler

# 4. Nach Session: Post-Mortem-Analyse
python3 -m runner.video_analyzer --last flow
```

## Stealth-Quad
- **VERIFY layer** – visuelles Gedächtnis der Stealth Quad
- Live-Video-Quelle für Omni Rolling Video Buffer
- Post-Mortem-Analyse via `runner/video_analyzer.py` (stealth-runner)

## Graphify
- 252 nodes, 17 communities
- Auto-Rebuild via post-commit hook
