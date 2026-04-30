# api.md — screen-follow

## Kern-APIs

### EventBus
- `EventBus.shared.publisher: AnyPublisher<FollowEvent, Never>`
- `EventBus.shared.post(_ event: FollowEvent)`

### ScreenRecorder
- `ScreenRecorder().startRecording(to:) async throws`
- `ScreenRecorder().stopRecording() async`
- `protocol ScreenRecorderDelegate`

### EventAuditLogger
- `EventAuditLogger.shared.lastEvents(count:) -> [AuditEvent]`
- `EventAuditLogger.shared.startLogging(to:)`

### RecordingManager
- `RecordingManager.shared.isRecording: Bool`
- `RecordingManager.shared.markRecordingStarted() / Stopped()`

## Erweiterung
Neue Visualisierungen abonnieren einfach den EventBus:

```swift
EventBus.shared.publisher
    .compactMap { event in
        if case .mouseDown(let btn, let x, let y) = event { return (btn, x, y) }
        return nil
    }
    .sink { btn, x, y in /* Effekte */ }
```
