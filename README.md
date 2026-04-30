# screen-follow

> Das visuelle Gedächtnis der Stealth Quad.  
> Nimmt macOS-Bildschirme inklusive Mausklicks, Tastenanschlägen und Cursor-Spuren auf – für Debugging, QS und Compliance.

## Installation

```bash
git clone https://github.com/SIN-CLIs/screen-follow.git
cd screen-follow
swift build -c release
cp .build/release/screen-follow /usr/local/bin/
```

**Voraussetzungen:** macOS 14+, Swift 6

## Schnellstart

```bash
screen-follow record --video           # Aufnahme mit Video
screen-follow status                   # Status prüfen
screen-follow stop                     # Aufnahme stoppen
screen-follow trace --last 50          # Letzte 50 Events
```

Ohne Argumente startet die Menüleisten-App mit Live-Overlays.

## Features

- 🎥 Hardwarebeschleunigte Bildschirmaufnahme (ScreenCaptureKit)
- 🖱️ Mausklick-Visualisierung (Ringe, Ripple)
- ⌨️ Tastatur-Overlay (live)
- 📋 JSONL-Audit-Trail jeder Aktion
- 🧵 Zentraler Event-Bus (Combine)
- 🕹️ CLI + Menüleisten-App

## Integration

`screen-follow` wird vom [`stealth-runner`](https://github.com/OpenSIN-AI/stealth-runner) orchestriert und liefert das visuelle Protokoll zu den Aktionen von `skylight-cli`.

## Lizenz

MIT – siehe [LICENSE](LICENSE)
