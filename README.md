# screen-follow

[![CI](https://github.com/SIN-CLIs/screen-follow/actions/workflows/ci.yml/badge.svg)](https://github.com/SIN-CLIs/screen-follow/actions/workflows/ci.yml)
[![Graphify](https://img.shields.io/badge/Graphify-Knowledge%20Graph-2ea44f?logo=gitbook&logoColor=white)](graphify-out/graph.html)

> Das visuelle Gedächtnis der Stealth Suite.
> Nimmt macOS-Bildschirme inklusive Mausklicks, Tastenanschlägen und Cursor-Spuren auf – für Debugging, QS und Compliance.

## Installation

```bash
git clone https://github.com/SIN-CLIs/screen-follow.git
cd screen-follow
swift build -c release
cp .build/release/screen-follow /usr/local/bin/
```

**Voraussetzungen:** macOS 14+, Swift 6

## Schnellstart

```bash
screen-follow record --video           # Aufnahme mit Video
screen-follow status                   # Status prüfen
screen-follow stop                     # Aufnahme stoppen
screen-follow trace --last 50          # Letzte 50 Events
```

Ohne Argumente startet die Menüleisten-App mit Live-Overlays.

## Features

- 🎥 Hardwarebeschleunigte Bildschirmaufnahme (ScreenCaptureKit)
- 🖱️ Mausklick-Visualisierung (Ringe, Ripple)
- ⌨️ Tastatur-Overlay (live)
- 📋 JSONL-Audit-Trail jeder Aktion
- 🧵 Zentraler Event-Bus (Combine)
- 🕹️ CLI + Menüleisten-App

## Integration

`screen-follow` wird vom [`stealth-runner`](https://github.com/SIN-CLIs/stealth-runner) orchestriert und liefert das visuelle Protokoll zu den Aktionen von `skylight-cli`.

## Lizenz

MIT – siehe [LICENSE](LICENSE)

---

## 🔗 Stealth Suite

Part of the **SIN-CLIs Stealth Suite** — 17 Komponenten für autonome Browser-Automation:

| Layer | Repo | Technologie |
|-------|------|-------------|
| 🧠 Orchestrator | [stealth-runner](https://github.com/SIN-CLIs/stealth-runner) | Python |
| 🧠 ROUTER | [stealth-axiom](https://github.com/SIN-CLIs/stealth-axiom) | Python |
| 🖱️ ACT (CUA-ONLY) | [cua-touch](https://github.com/SIN-CLIs/cua-touch) | Python + Swift |
| 🎭 HIDE | [playstealth-cli](https://github.com/SIN-CLIs/playstealth-cli) | Python |
| 👁️ SENSE | [unmask-cli](https://github.com/SIN-CLIs/unmask-cli) | TypeScript |
| 📹 VERIFY | [screen-follow](https://github.com/SIN-CLIs/screen-follow) | Swift |
| 🔍 SCAN | [macos-ax-cli](https://github.com/SIN-CLIs/macos-ax-cli) | Swift |
| 🐙 AX-INDEXER | [ax-graph](https://github.com/SIN-CLIs/ax-graph) | Swift |
| 🔒 CAPTCHA | [stealth-captcha](https://github.com/SIN-CLIs/stealth-captcha) | Python |
| 🧩 SKILLS | [stealth-skills](https://github.com/SIN-CLIs/stealth-skills) | TS/Python |
| 🧱 CORE | [stealth-core](https://github.com/SIN-CLIs/stealth-core) | Python |
| 🧠 MIND | [stealth-mind](https://github.com/SIN-CLIs/stealth-mind) | Python |
| 🛡️ GUARDIAN | [stealth-guardian](https://github.com/SIN-CLIs/stealth-guardian) | Python |
| 🔄 SYNC | [stealth-sync](https://github.com/SIN-CLIs/stealth-sync) | Python |
| ⚡ SESSION | [stealth-session](https://github.com/SIN-CLIs/stealth-session) | Python |
| 🎯 DYNAMIC | [stealth-dynamic](https://github.com/SIN-CLIs/stealth-dynamic) | Python |
| 💀 LEGACY | [skylight-cli](https://github.com/SIN-CLIs/skylight-cli) | Swift |
| 🔬 SOTA | [stealth-sota](https://github.com/SIN-CLIs/stealth-sota) | Python |
| 💀 LEGACY | [computer-use-mcp](https://github.com/SIN-CLIs/computer-use-mcp) | TypeScript |


## 🔗 Stealth Suite

Part of the **SIN-CLIs Stealth Suite** — 16 Komponenten für autonome Browser-Automation:

| Layer | Repo | Technologie |
|-------|------|-------------|
| 🧠 Orchestrator | [stealth-runner](https://github.com/SIN-CLIs/stealth-runner) | Python |
| 🖱️ ACT (CUA-ONLY) | [cua-touch](https://github.com/SIN-CLIs/cua-touch) | Python + Swift |
| 🎭 HIDE | [playstealth-cli](https://github.com/SIN-CLIs/playstealth-cli) | Python |
| 👁️ SENSE | [unmask-cli](https://github.com/SIN-CLIs/unmask-cli) | TypeScript |
| 📹 VERIFY | [screen-follow](https://github.com/SIN-CLIs/screen-follow) | Swift |
| 🔍 SCAN | [macos-ax-cli](https://github.com/SIN-CLIs/macos-ax-cli) | Swift |
| 🐙 AX-INDEXER | [ax-graph](https://github.com/SIN-CLIs/ax-graph) | Swift |
| 🔒 CAPTCHA | [stealth-captcha](https://github.com/SIN-CLIs/stealth-captcha) | Python |
| 🧩 SKILLS | [stealth-skills](https://github.com/SIN-CLIs/stealth-skills) | TS/Python |
| 🧱 CORE | [stealth-core](https://github.com/SIN-CLIs/stealth-core) | Python |
| 🧠 MIND | [stealth-mind](https://github.com/SIN-CLIs/stealth-mind) | Python |
| 🛡️ GUARDIAN | [stealth-guardian](https://github.com/SIN-CLIs/stealth-guardian) | Python |
| 🔄 SYNC | [stealth-sync](https://github.com/SIN-CLIs/stealth-sync) | Python |
| ⚡ SESSION | [stealth-session](https://github.com/SIN-CLIs/stealth-session) | Python |
| 💀 LEGACY | [skylight-cli](https://github.com/SIN-CLIs/skylight-cli) | Swift |
| 💀 LEGACY | [computer-use-mcp](https://github.com/SIN-CLIs/computer-use-mcp) | TypeScript |

---
