# architecture_decision_record.md

## ADR-001: Zentraler EventBus
**Status:** Akzeptiert  
**Entscheidung:** Ein SystemEventTap → Combine EventBus  
**Grund:** macOS erlaubt nur einen CGEventTap pro Event-Typ

## ADR-002: Lock-Datei für Status-IPC
**Status:** Akzeptiert  
**Entscheidung:** PID-Datei im Temp-Verzeichnis  
**Grund:** Minimal, einfach, keine XPC/DistributedNotifications nötig

## ADR-003: Kein externes ArgumentParser-Paket
**Status:** Akzeptiert  
**Entscheidung:** Manuelles CLI-Parsing  
**Grund:** Null Dependencies, geringes Supply-Chain-Risiko

## ADR-004: Video-Overlays durch transparente Fenster
**Status:** Akzeptiert  
**Entscheidung:** Native `.floating`-Fenster  
**Grund:** Automatisch im ScreenCaptureKit-Video, kein Compositing
