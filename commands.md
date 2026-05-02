# commands.md — screen-follow CLI-Befehle

## Installation

```bash
git clone https://github.com/SIN-CLIs/screen-follow.git
cd screen-follow
swift build -c release
cp .build/release/screen-follow /usr/local/bin/
# Voraussetzung: macOS 14+, Swift 6
```

## Screen Recording Permission (EINMALIG)

macOS System Settings → Privacy & Security → Screen Recording → `screen-follow.app` erlauben.

## Kernbefehle

```bash
# Aufnahme starten (Video + Events)
screen-follow record --video --output /tmp/session.mp4

# Aufnahme stoppen
screen-follow stop

# Status prüfen
screen-follow status

# Letzte N Events als JSONL
screen-follow trace --last 50

# GUI (Menüleisten-App mit Live-Overlays)
screen-follow
```

## Video-Analyse mit Nemotron Omni (stealth-runner)

```bash
# Nach Session: Fehler finden
python3 -m runner.video_analyzer --last errors

# Flow-Analyse
python3 -m runner.video_analyzer --last flow

# Captcha-Erkennung
python3 -m runner.video_analyzer --last captcha

# Spezifisches Video analysieren
python3 -m runner.video_analyzer /tmp/session.mp4 flow
```

## Rolling Video Buffer (Live Omni Monitor Integration)

`screen-follow record --video` liefert die Quelle für LiveOmniMonitor:
```bash
# In stealth-runner
python3 -c "
from runner.live_omni_monitor import LiveOmniMonitor
m = LiveOmniMonitor(fps=1.0, debug=True)
m.start('https://heypiggy.com/?page=dashboard')
m.run_continuous(max_steps=100)
"
# → screen-follow liefert MP4
# → ffmpeg extrahiert 4-Sekunden-Clips
# → base64 → NVIDIA NIM
# → Omni analysiert temporal (Conv3D)
```

## Event-Bus (JSONL Audit Trail)

Jede Aktion (Maus, Tastatur, Scroll) wird als JSONL geloggt:
```bash
# Events anschauen
cat ~/.screen-follow/events.jsonl | python3 -c "
import sys,json
for line in sys.stdin:
    e=json.loads(line)
    print(f'{e[\"type\"]}: {e[\"data\"][:80]}')
" | tail -50

# Event-Typ filtern
cat ~/.screen-follow/events.jsonl | python3 -c "
import sys,json
for line in sys.stdin:
    e=json.loads(line)
    if e['type'] in ('mouse_click','key_press'):
        print(f'{e[\"type\"]}: {e}')
"
```

## Integration mit Stealth-Quad

```bash
# 1. playstealth startet Chrome
playstealth launch --url 'https://heypiggy.com/?page=dashboard'
PID=$!

# 2. screen-follow zeichnet auf (Background)
screen-follow record --video --output /tmp/session.mp4

# 3. skylight-cli klickt (Hauptfenster)
skylight-cli click --pid $PID --element-index 42

# 4. unmask-cli sniffet (SENSE)
unmask inspect https://heypiggy.com/survey/123

# 5. stealth-runner orchestriert
PYTHONPATH=~/dev/stealth-runner python3 runner/step.py "https://..."

# 6. Aufnahme stoppen
screen-follow stop

# 7. Post-Mortem
python3 -m runner.video_analyzer --last errors
```

## Klic-App (Live-Overlays)

Klic = visual mouse trail overlay (MIT Lizenz):
```bash
screen-follow              # GUI mit cursor trails, ripple, keyboard overlay
screen-follow record       # ohne GUI, nur CLI + background recording
```

## Troubleshooting

```bash
# Keine Aufnahme möglich → Permission prüfen
screen-follow status
# → "Screen Recording Permission: NOT GRANTED"

# Permission erteilen
open "x-apple.systempreferences:com.apple.preference.security?Privacy_ScreenCapture"

# Swift Build fehlgeschlagen
swift build -c release  # im repo
```