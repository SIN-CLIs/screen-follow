# testing.md — screen-follow

## Manuelle Test-Routine

1. `swift build` — muss ohne Fehler durchlaufen
2. `screen-follow` (ohne Args) — Usage ausgeben
3. `screen-follow` (ohne Args, GUI) — Menüleisten-App startet
4. `screen-follow record --video --duration 5` — Video existiert, abspielbar
5. `screen-follow trace --last 3` — zeigt JSON-Zeilen
6. `screen-follow status` — "Recording is active" oder "idle"
7. `screen-follow stop` — beendet Aufnahme

## Zukünftige Unit-Tests
- SystemEventTap Mock
- EventBus Verteilung
- EventAuditLogger Schreib-/Lese-Test
- RecordingManager Lock-Datei
