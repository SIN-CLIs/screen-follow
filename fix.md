# fix.md — screen-follow

## v0.2.0 – Struktur & CLI
- Grundgerüst aus Proposal umgesetzt  
- `ScreenRecorder` mit `ScreenCaptureKit` und `AVAssetWriter`  
- CLI: `record`, `stop`, `status`, `trace`, `gui`  
- Menüleisten-App als GUI-Modus  
- JSONL-Audit-Trail mit `EventAuditLogger`

## v0.2.1 – EventBus & Refactor
- **Zentraler EventBus** anstelle separater Taps  
- **SystemEventTap** als einzige Quelle für Maus-/Tastaturevents  
- **RecordingManager** für prozessübergreifenden Status (Lock-Datei)  
- **Video-Output im CLI aktiviert** (`--video` Flag)  
- **CLI `trace`** gibt letzte N Einträge aus  
- Klic-Integration (cursor trails, keyboard overlay, mouse effects)  
- Code in `Bus/`, `Recording/`, `Audit/`, `CLI/` organisiert

## Geplant für v0.3.0
- Audio-Aufnahme  
- Multi-Display-Unterstützung  
- GUI-Vorschaufenster  
- Automatischer Accessibility-Prompt
