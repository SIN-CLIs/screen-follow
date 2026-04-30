# architecture.md — screen-follow

## Überblick
`screen-follow` ist eine hybride **CLI + Menüleisten-App** für macOS 14+, geschrieben in Swift.

## Komponenten

### 1. Event-Infrastruktur (`Bus/`)
- **SystemEventTap** – einziger, systemweiter CGEvent-Tap für Maus, Tastatur & Scrollen  
- **EventBus** (Combine) – verteilt Events an alle interessierten Module  
- **FollowEvent** – vereinheitlichtes Event-Modell

### 2. Aufnahmekern (`Recording/`)
- **ScreenRecorder** – startet/stoppt `SCStream` und schreibt via `AVAssetWriter` eine Videodatei  
- **Configuration** – steuert Video ja/nein, Ausgabepfad, max. Länge  
- **RecordingManager** – prozessübergreifende Status-Lockdatei (CLI-GUI-Kommunikation)

### 3. Audit-Trail (`Audit/`)
- **EventAuditLogger** – schreibt jedes Event als JSON-Zeile in JSONL-Datei  
- Bietet `lastEvents(count:)` zum schnellen Auslesen per CLI

### 4. Visualisierung (`Monitors/`, `Views/`)
- **InputManager** – abonniert den EventBus und malt Overlays (Cursor-Trail, Klickringe, Tasten-Overlay)  
- **Overlay-Fenster** – transparent, nicht-interagierend, schwebend über allen Spaces

### 5. CLI-Interface (`main.swift`)
- Reine Swift-Standardbibliothek, keine externen Dependencies  
- `record [--video] [--output path] [--duration s]`  
- `stop` | `status` | `trace --last n` | `gui [--stop]`  
- Ohne Argumente startet die Menüleisten-App

## Zusammenspiel
```
[Benutzer / stealth-runner]
       │ CLI-Befehle
       ▼
   main.swift (entscheidet GUI/CLI)
       │
       ├─ CLI-Modus ──► ScreenRecorder + EventAuditLogger + EventBus
       │
       └─ GUI-Modus ──► KlicApp (startet SystemEventTap)
                          │
                          ├─► EventBus ──► InputManager (Overlays)
                          └─► EventBus ──► EventAuditLogger (JSONL)
```

## Designentscheidungen
- **Ein Tap für alles** vermeidet Konflikte durch macOS-Limit  
- **Combine-EventBus** entkoppelt Module  
- **Lock-Datei** erlaubt Statusabfrage ohne XPC
