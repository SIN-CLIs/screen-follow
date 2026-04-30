# successful.md — screen-follow

## Erfolgskriterien

### 1. Automatisierte Aufzeichnung einer Webumfrage
- `stealth-runner` startet `screen-follow record --video`  
- `skylight-cli` führt Klickabläufe aus  
- Nach Beendigung liegt eine **.mp4-Datei** vor, die Mausbewegungen, Klicks und Tastatureingaben zeigt  
- JSONL-Trail ist lückenlos und mit `unmask-cli`-Logs synchronisierbar

### 2. Manuelles Debugging
- Entwickler startet `screen-follow record`  
- Fehler wird provoziert  
- `screen-follow trace --last 50` zeigt sofort die letzten Events  
- Video zeigt exakt, was passiert ist → Fehlerursache in Minuten identifiziert

### 3. Compliance-Nachweis
- Audit-Trail über eine Stunde  
- JSONL-Datei als unveränderliches Beweisprotokoll  
- Video bestätigt visuell, dass keine unerwünschten Dialoge übersehen wurden

### 4. Minimaler Overhead
- CPU < 10 % auf Apple Silicon  
- Overlays ohne spürbare Verzögerung

## Erfolg in der Stealth Quad
`screen-follow` hat seinen Zweck erfüllt, wenn keine Automatisierungs-Session mehr ohne die Frage „Haben wir ein Video davon?" läuft.
