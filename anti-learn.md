# anti-learn.md — ANTI-PATTERNS für screen-follow

## ❌ Ohne Permission aufnehmen

**FALSCH**: `screen-follow record` ohne Screen Recording Permission.
**PROBLEM**: Leere Datei, kein Nutzen.
**RICHTIG**: System Settings → Screen Recording → erlauben. Oder `screen-follow status`.

## ❌ Klic-GUI in Production

**FALSCH**: `screen-follow` (mit GUI) im Production-Workflow.
**PROBLEM**: Overlay overhead, Performance-Einbußen, visuell ablenkend.
**RICHTIG**: `screen-follow record --video` (CLI, background).

## ❌ Nur bei "wichtigen" Sessions aufnehmen

**FALSCH**: Aufnahme nur bei Demo oder wichtigen Surveys.
**PROBLEM**: Fehler passieren unerwartet.
**RICHTIG**: Immer aufnehmen. Speicher ist billig. Fehler-Debugging ist teuer.

## ❌ Falsches Output-Format

**FALSCH**: `--output /tmp/video` (ohne .mp4 Endung).
**PROBLEM**: ffmpeg kann nicht inferieren.
**RICHTIG**: `--output /tmp/session.mp4` (mit .mp4 Endung).

## ❌ Output-Pfad ohne mkdir

**FALSCH**: Output-Verzeichnis existiert nicht.
**PROBLEM**: Recording startet nicht.
**RICHTIG**: `mkdir -p /tmp/sessions && screen-follow record ...`

## ❌ Video zu groß lassen (kein CRF-Limit)

**FALSCH**: Unkomprimierte AVI oder extrem hohe Bitrate.
**PROBLEM**: Festplatte voll, kein Speicherplatz für mehrere Sessions.
**RICHTIG**: Default MP4 (H.264) nutzen, CRF ~28-40 für gute Balance.

## ❌ Graphify ignorieren nach Code-Änderung

**FALSCH**: Swift-Änderungen ohne `graphify update .`
**PROBLEM**: Knowledge Graph veraltet, cross-module Fragen falsch beantwortet.
**RICHTIG**: Nach jeder Änderung: `graphify update ~/dev/screen-follow`

## ❌ Incompatible Swift-Version nutzen

**FALSCH**: Code mit Swift 5 Features auf Swift 6 kompilieren.
**PROBLEM**: Build fail, "concurrent import not allowed", etc.
**RICHTIG**: Swift 6 Features nutzen (Actor, async/await strict), Code ist für Swift 6 geschrieben.