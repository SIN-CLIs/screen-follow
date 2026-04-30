# SECURITY.md — screen-follow

## Prinzipien
- **Lokal:** Alle Daten bleiben auf der Festplatte. Keine Cloud, keine Telemetrie.
- **Permissions:** Screen Recording + Accessibility müssen explizit erteilt werden.
- **Audit-Integrität:** JSONL ist Append-Only, wird nicht verändert.

## Empfehlungen
- Ausgabedateien nicht in Cloud-Sync-Ordner legen
- Aufnahmen nach Analyse löschen
- FileVault für temp-Verzeichnis (Standard auf modernen Macs)

## Schwachstellen melden
Bitte als privates Security-Issue oder an Maintainer-Email.
