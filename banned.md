# banned.md — Verbotene Patterns für screen-follow

## 🚫 BANNED TOOLS

| Tool | Warum | Alternative |
|------|-------|-------------|
| `pyautogui` | Mausbewegung captured nicht richtig | `screen-follow` own recording |
| `ffmpeg` mit falschen Parametern | CRF zu niedrig → zu große Dateien | `screen-follow` default (CRF ~28-40) |

## 🚫 BANNED PATTERNS

```bash
# ❌ Recording ohne Screen Permission
screen-follow record  # ohne Permission → leere Datei

# ❌ Klic GUI in Production
screen-follow  # → Overlay overhead

# ❌ Output ohne .mp4 Endung
screen-follow record --output /tmp/video  # ffmpeg can't infer

# ❌ Unkomprimierte Formate
screen-follow record --output /tmp/video.avi  # Plattenplatz verschwendet

# ❌ Ohne mkdir in nicht-existierendem Verzeichnis
screen-follow record --output /tmp/newdir/session.mp4  # fails

# ❌ Manuell ffmpeg ohne CRF-Limit
ffmpeg -i ... -crf 0  # 100MB/min → Platten voll
```

## 🔒 RICHTIGE ALTERNATIVEN

```bash
# ✅ Permission zuerst
screen-follow status
# → "Screen Recording Permission: GRANTED"

# ✅ Production: CLI only, no GUI
screen-follow record --video --output /tmp/session.mp4

# ✅ Background recording
screen-follow record --video --output /tmp/session.mp4 &

# ✅ Output mit korrektem Verzeichnis
mkdir -p /tmp/sessions
screen-follow record --video --output /tmp/sessions/$(date +%Y%m%d).mp4

# ✅ Nach Code-Änderung: Graphify
graphify update ~/dev/screen-follow
```

## 🔒 SEMGREP (in stealth-runner)

Falls screen-follow Code in stealth-runner integriert:
→ 11 semgrep Regeln blockieren BANNED Muster VOR Commit.