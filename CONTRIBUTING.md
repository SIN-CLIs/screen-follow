# CONTRIBUTING.md — screen-follow

## Entwicklungsumgebung
- macOS 14+ (ScreenCaptureKit)
- Swift 6, Xcode 15+
- Keine externen Pakete — nur System-Frameworks

## Wie beitragen?
1. Issue erstellen
2. Branch: `feature/xyz` oder `fix/xyz`
3. `swift build` + manuelle CLI-Tests
4. Pull Request mit Beschreibung

## Commit-Regeln
`feat:` Feature | `fix:` Bugfix | `docs:` Doku | `refactor:` Umbau | `test:` Tests

## Code-Konventionen
- `guard` für Fehler, keine Force-Unwraps
- Combine-Publisher als `AnyPublisher`
- Enum-Cases für Events (wie `FollowEvent`)
