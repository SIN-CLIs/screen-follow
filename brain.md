# brain.md - Systemwissen (2026-05-01)

## screen-follow Kern
- **Tech:** Swift, ScreenCaptureKit + AVAssetWriter
- **CLI:** record --video, stop, status, trace --last N
- **Erzeugt:** MP4-Videodateien + JSONL-Audit-Trail
- **Rolling Buffer:** 4-Sekunden-Clips für Omni temporal analysis
- **Integration:** screen-follow record → ffmpeg clip → Omni Conv3D

## Stealth-Quad
- VERIFY layer
- Live-Monitor für Omni Rolling Video Buffer
- Post-Mortem-Analyse via `runner/video_analyzer.py`

## Graphify
- 252 nodes, 17 communities
