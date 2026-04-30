# TROUBLESHOOTING.md

## Event Tap startet nicht
→ Systemeinstellungen → Datenschutz → Bedienungshilfen → Terminal/App aktivieren → Neustart

## Video ohne Overlays
→ `record --video` verwenden (nicht nur `record`)  
→ Accessibility-Permission prüfen  
→ Andere Event-Taps beenden

## Aufnahme friert ein
→ `screen-follow status` prüfen  
→ Speicherplatz checken  
→ `screen-follow stop` + Neustart

## `trace` zeigt nichts
→ Aufnahme muss laufen  
→ Logdatei existiert in `/tmp/screen-follow-audit.jsonl`

## GUI-Icon fehlt
→ Bartender o.ä. versteckt es  
→ `screen-follow` ohne Argumente starten
