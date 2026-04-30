# benchmarks.md — screen-follow

## Ziel
- **CPU:** < 10 % auf Apple Silicon (M1)
- **RAM:** < 150 MB bei 1080p
- **Datei:** ~100 MB/min für 1080p-Video

## Messumgebung
- MacBook Air M1, 16 GB, macOS 14
- 2560x1600 Retina, Swift 6 Release

## Ergebnisse (v0.2.1, vorläufig)
- CPU: ~8 % (alle Kerne)
- RAM: ~130 MB
- Datei: ~95 MB/min

## Optimierung
- AVAssetWriter-Einstellungen
- 15 fps für Audit-only
- Hardware-Encoder
