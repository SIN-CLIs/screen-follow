# learn.md — KRITISCHE Learnings für screen-follow

## 🔑 Screen Recording Permission MUSS erteilt sein

Falls `screen-follow record` nicht startet:
→ System Settings → Privacy & Security → Screen Recording → screen-follow.app erlauben.
→ Nach Erteilung: App neu starten.

## 🔑 IMMER aufnehmen (Background, auch bei Tests)

**FALSCH**: Nur aufnehmen wenn "wichtig".
**PROBLEM**: Fehler passieren unerwartet. Ohne Recording kein Post-Mortem.
**RICHTIG**: Immer `screen-follow record --video --output /tmp/session.mp4 &`
→ Background-Prozess, stört nichts, hilft bei Fehlern.

## 🔑 Rolling Video Buffer für LiveEye

screen-follow ist nicht nur für Post-Mortem.
LiveOmniMonitor nutzt es als Quelle:
- MP4 → ffmpeg → 4-Sekunden-Clip
- Clip → base64 → NVIDIA NIM
- Omni → Conv3D → temporale Analyse
→ Erkennt Seitenübergänge, Captchas, Fehler in Echtzeit.

## 🔑 Event JSONL = Audit Trail für Debugging

Jede Mausbewegung, jeder Tastendruck wird geloggt.
Bei Fehlern: `screen-follow trace --last 50` → zeigt exakt was passierte.
→ Mausbewegung an falsche Position? → Koordinaten-Fehler in skylight-cli.
→ Zu schnelle Tastatureingabe? → Timing-Problem in answer_logic.

## 🔑 Video-Analyse nach jeder Session

```bash
python3 -m runner.video_analyzer --last errors
# → Zeigt Frame(s) wo was schiefging
# → next session: Problem已知 → schneller
```

## 🔑 Klic (cursor trail) nur für Demo/Dev

Klic-Overlay (cursor ripple, keyboard visualizer) ist für:
- Demo-Videos
- Developer Debugging
- Präsentationen

**NICHT** für Production: Overhead, Performance-Einbußen.
Production: `screen-follow record` (CLI, ohne GUI).

## 🔑 Swift 6 + macOS 14+ erforderlich

Falls Build fehlschlägt:
```bash
swift --version  # muss 6.x sein
sw_vers          # muss 14.x sein
```
Ältere Versionen: Code anpassen oder upgraden.

## 🔑 Output-Pfad muss existieren

```bash
# FALSCH
screen-follow record --video --output /tmp/doesnt-exist-dir/file.mp4

# RICHTIG (Verzeichnis existiert)
mkdir -p /tmp/sessions
screen-follow record --video --output /tmp/sessions/session-$(date +%Y%m%d).mp4
```

## 🔑 Graphify nach Code-Änderungen

Falls Swift-Code geändert:
```bash
graphify update ~/dev/screen-follow
```
→ Knowledge Graph aktuell halten.