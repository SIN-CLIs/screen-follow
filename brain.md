# brain.md — screen-follow

## Wissensbasis
`screen-follow` trifft keine autonomen Entscheidungen, sondern zeichnet auf. Die darin steckende Intelligenz liegt in der Interpretation:

- **Entscheidungsgrundlage:** Der Audit-Trail enthält jeden Klick und Tastendruck  
- **QS-Regeln (extern):** stealth-runner kann den JSONL-Trail parsen  
- **Wiederholbare Tests:** Gleiche Eingabe → gleiche Aufnahme

## Logik der Aufzeichnung
1. Jedes Event wird **sofort** in die JSONL-Datei geschrieben (kein Buffer)  
2. Video und Trail sind über Zeitstempel synchronisierbar  
3. Overlays im Video sind **immer** Teil der Aufnahme (vom System als Teil des Bildschirms erfasst)

## Warum kein „intelligenter" Detektor?
Bewusst einfach gehalten – `screen-follow` ist ein passiver Datenlieferant.  
Die Analyse überlassen wir spezialisierten Komponenten.
