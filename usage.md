# usage.md — screen-follow

## CLI-Kommandos

### `record`
Startet Aufnahme. Optionen: `--video`, `--output <Pfad>`, `--duration <Sekunden>`

### `stop`
Signalisiert allen laufenden Aufnahmen, sich zu beenden.

### `status`
Gibt aus, ob aktuell eine Aufnahme läuft + PID.

### `trace --last <n>`
Gibt die letzten `n` Zeilen des Audit-Logs aus.

### `gui [--stop]`
Startet/beendet die Menüleisten-App.

## Workflow

```bash
# Debugging
screen-follow record --video
# Aktion ausführen
screen-follow stop
screen-follow trace --last 50
open /tmp/screen-follow-*.mp4
```
