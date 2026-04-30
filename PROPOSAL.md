# screen-follow — Ultimate macOS Screen Agent Companion

> Fusioniert die besten Features aus 6 Open-Source-Tools in EIN natives macOS-App + CLI.
> **Cursor-Visualisierung + Klick-Effekte + Keystroke-Display + Video-Recording + JSONL-Audit-Trail**

## Warum?

Alle existierenden Tools machen NUR einen Teil:
- `mac-mouse-highlighter`: Cursor + Klicks, aber KEINE Tastatur, KEIN Recording
- `CursorFlow`: Cursor + Tastatur-Display, aber KEIN Recording, KEIN Audit
- `Captr`: Screen-Recording + Events, aber KEINE Cursor-Visualisierung
- `uitrace`: JSONL-Trace, aber KEIN Video, KEINE Cursor-Effekte
- `ScreenMuse`: Video + HTTP-API, aber nur macOS 14+
- `Steve CLI`: JSONL, aber KEIN GUI, KEIN Video

**screen-follow macht ALLES. In EINEM Tool. Kostenlos. Open Source.**

---

## Features (Fusion aus allen Quellen)

### 🖱️ Cursor-Visualisierung (von mac-mouse-highlighter + CursorFlow)
- [ ] Circle-Highlight (gefüllt, Gradient)
- [ ] Spotlight-Modus (Screen dimmen außer Cursor-Bereich)
- [ ] Ring-Modus (leuchtender Ring um Cursor)
- [ ] Mouse-Trails (farbige Partikel-Spur, von CursorFlow)
- [ ] Alle Effekte per Menu-Bar toggelbar

### 👆 Klick-Effekte (von mac-mouse-highlighter)
- [ ] Ripple (expandierender Kreis beim Klick)
- [ ] Color Flash (kurzer Farb-Blitz)
- [ ] Shrink & Bounce (Feder-Animation)
- [ ] Linke vs rechte Maustaste unterscheidbar

### ⌨️ Keystroke-Display (von CursorFlow)
- [ ] Tastatur-Overlay (zeigt gedrückte Tasten + Shortcuts)
- [ ] Semi-transparent, positionierbar (unten Mitte)
- [ ] Zeigt: "Enter", "Cmd+Option", "Shift+Cmd+A" etc.
- [ ] Per Menu-Bar toggelbar

### 🎥 Screen-Recording (von Captr + ScreenMuse)
- [ ] ScreenCaptureKit (macOS 13+, hardware-beschleunigt)
- [ ] Audio optional mitschneiden
- [ ] Video mit Cursor-Effekten (Effekte sind Overlay → im Recording sichtbar)
- [ ] Chapter-Marker (von ScreenMuse)
- [ ] Start/Stop per CLI + Menu-Bar

### 📋 JSONL-Audit-Trail (von uitrace + Steve CLI)
- [ ] JEDE Aktion loggen: `{"ts":1234.5, "type":"click", "x":500, "y":300, "button":"left"}`
- [ ] `{"type":"keystroke", "key":"Enter", "modifiers":["Cmd"]}`
- [ ] `{"type":"scroll", "deltaY":-120}`
- [ ] `{"type":"app_switch", "from":"Chrome", "to":"Terminal"}`
- [ ] `{"type":"window_focus", "title":"HeyPiggy - ..."}`
- [ ] `{"type":"navigation", "url":"https://heypiggy.com"}`
- [ ] Striktes JSONL-Format, ein Event pro Zeile
- [ ] Pydantic-kompatibel (wie uitrace)

### 🔧 CLI-Interface (von Steve CLI)
```bash
screen-follow record              # Start recording
screen-follow record --video      # Mit Bildschirm-Aufnahme
screen-follow stop                # Stop
screen-follow status              # Läuft es?
screen-follow toggle-cursor       # Cursor-Effekte an/aus
screen-follow toggle-keystrokes   # Tastatur-Overlay an/aus
screen-follow trace --last 100    # Letzte 100 Events
screen-follow trace --format json # JSON-Output
screen-follow serve --port 8765   # HTTP-API (von ScreenMuse)
```

---

## Architektur

```
screen-follow/
├── Sources/
│   ├── ScreenFollowApp/          # Native macOS App (SwiftUI)
│   │   ├── App.swift
│   │   ├── MenuBarController.swift
│   │   └── SettingsView.swift
│   ├── CursorOverlay/            # Cursor-Visualisierung
│   │   ├── HighlightStyles/      # Circle, Spotlight, Ring
│   │   ├── ClickEffects/         # Ripple, Flash, Bounce
│   │   ├── MouseTrail/           # Partikel-Trail
│   │   └── OverlayWindow.swift
│   ├── KeystrokeOverlay/         # Tastatur-Display
│   │   ├── KeyEventMonitor.swift
│   │   └── KeystrokeHUD.swift
│   ├── Recording/                # ScreenCaptureKit
│   │   ├── ScreenRecorder.swift
│   │   ├── AudioRecorder.swift
│   │   └── ChapterMarkers.swift
│   ├── EventLogger/              # JSONL-Audit-Trail
│   │   ├── EventLogger.swift
│   │   ├── EventTypes.swift      # Pydantic-kompatible Structs
│   │   └── TraceAPI.swift
│   └── CLI/                      # Command-Line Interface
│       ├── main.swift            # screen-follow CLI
│       └── HTTPAPI.swift         # REST-API (optional)
├── Package.swift
├── AGENTS.md
├── brain.md
├── PROPOSAL.md                   # Diese Datei
└── LICENSE
```

---

## Technologie-Stack
- **Sprache:** Swift 6 (für App) + Python 3.12 (für CLI optional)
- **UI:** SwiftUI + AppKit (Menu Bar)
- **Recording:** ScreenCaptureKit (macOS 13+)
- **Event-Tap:** CGEventTap (Input Monitoring Permission)
- **Audit-Log:** JSONL (append-only, O_SYNC)
- **Permissions:** Input Monitoring, Screen Recording, Accessibility

---

## Vergleich: Wer kann was?

| Feature | M-M-H | CFlow | Captr | uitrace | S.Muse | **screen-follow** |
|---------|:---:|:---:|:---:|:---:|:---:|:---:|
| Cursor-Highlight | ✅ | ❌ | ❌ | ❌ | ❌ | ✅ |
| Mouse-Trails | ❌ | ✅ | ❌ | ❌ | ❌ | ✅ |
| Klick-Effekte | ✅ | ✅ | ❌ | ❌ | ❌ | ✅ |
| Keystroke-Display | ❌ | ✅ | ❌ | ❌ | ❌ | ✅ |
| Screen-Recording | ❌ | ❌ | ✅ | ❌ | ✅ | ✅ |
| JSONL-Audit | ❌ | ❌ | ✅ | ✅ | ❌ | ✅ |
| CLI | ❌ | ❌ | ❌ | ✅ | ❌ | ✅ |
| HTTP-API | ❌ | ❌ | ❌ | ❌ | ✅ | ✅ |
| Kostenlos | ✅ | 🟡 | ✅ | ✅ | ✅ | ✅ |
| Open Source | ✅ | ❌ | ✅ | ✅ | ✅ | ✅ |

---

## Nächste Schritte
1. Repo auf GitHub erstellen (SIN-CLIs/screen-follow)
2. Swift Package Struktur aufsetzen
3. Cursor-Highlight + Click-Effekte (Port von mac-mouse-highlighter)
4. Keystroke-Display (Port von CursorFlow-Konzept)
5. JSONL-Event-Logger
6. ScreenCaptureKit Recording
7. CLI-Interface
8. HTTP-API
