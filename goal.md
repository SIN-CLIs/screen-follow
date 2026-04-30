# goal.md — screen-follow

## Mission
`screen-follow` ist das **visuelle Gedächtnis der Stealth Quad**.  
Es zeichnet lückenlos auf, was der Benutzer oder die Automatisierung (skylight-cli) auf dem Bildschirm tut, und macht jede Aktion später nachvollziehbar.

### Kernziele
- **Video + Audit-Trail** mit einem einzigen Befehl starten
- **Maus & Tastatur** sichtbar machen (Cursor-Spotlight, Klickringe, Tasten-Overlay)
- **Erkennbare Beweiskette** für Debugging, QS und Compliance
- **Nahtlose Integration** in die Stealth-Triade (stealth-runner orchestriert record/stop/trace)
- **Minimaler Ressourcenverbrauch** durch hardwarebeschleunigtes ScreenCaptureKit
- **Datenschutz** – alle Daten bleiben lokal, keine Cloud

## Warum?
In einer komplett unsichtbaren Robotersteuerung fehlte bisher die Möglichkeit, das tatsächliche visuelle Ergebnis zu prüfen.  
`screen-follow` schließt diese Lücke – es ist die Dashcam des Automatisierungs-Frameworks.
