# AGENTS.md — screen-follow

## Was es ist
Ultimatives macOS Screen-Agent-Companion. Cursor + Klicks + Tastatur + Video + Audit.

## CLI
```bash
screen-follow record              # Start recording
screen-follow record --video      # Mit Video
screen-follow stop
screen-follow status
screen-follow trace --last 50
```

## Technik
- Swift 6 + SwiftUI
- ScreenCaptureKit
- CGEventTap
- JSONL Audit-Log

## Permissions
Input Monitoring + Screen Recording + Accessibility
