# Graph Report - screen-follow  (2026-05-01)

## Corpus Check
- 26 files · ~17,141 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 252 nodes · 341 edges · 15 communities detected
- Extraction: 94% EXTRACTED · 6% INFERRED · 0% AMBIGUOUS · INFERRED: 19 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_Community 0|Community 0]]
- [[_COMMUNITY_Community 1|Community 1]]
- [[_COMMUNITY_Community 2|Community 2]]
- [[_COMMUNITY_Community 3|Community 3]]
- [[_COMMUNITY_Community 4|Community 4]]
- [[_COMMUNITY_Community 5|Community 5]]
- [[_COMMUNITY_Community 6|Community 6]]
- [[_COMMUNITY_Community 7|Community 7]]
- [[_COMMUNITY_Community 8|Community 8]]
- [[_COMMUNITY_Community 9|Community 9]]
- [[_COMMUNITY_Community 10|Community 10]]
- [[_COMMUNITY_Community 11|Community 11]]
- [[_COMMUNITY_Community 12|Community 12]]
- [[_COMMUNITY_Community 13|Community 13]]
- [[_COMMUNITY_Community 14|Community 14]]

## God Nodes (most connected - your core abstractions)
1. `InputManager` - 26 edges
2. `AppDelegate` - 17 edges
3. `KeyboardMonitor` - 14 edges
4. `UserPreferences` - 12 edges
5. `FollowEventTests` - 9 edges
6. `MouseButton` - 9 edges
7. `KeyModifier` - 9 edges
8. `ScreenRecorder` - 8 edges
9. `MouseMonitor` - 7 edges
10. `FollowEvent` - 7 edges

## Surprising Connections (you probably didn't know these)
- `EventBusTests` --inherits--> `XCTestCase`  [EXTRACTED]
  Tests/ScreenFollowTests/ScreenFollowTests.swift →   _Bridges community 6 → community 8_
- `AppDelegate` --inherits--> `NSObject`  [EXTRACTED]
  Sources/ScreenFollow/KlicApp.swift →   _Bridges community 3 → community 7_
- `KeyboardMonitor` --inherits--> `ObservableObject`  [EXTRACTED]
  Sources/ScreenFollow/Monitors/KeyboardMonitor.swift →   _Bridges community 7 → community 9_
- `InputManager` --inherits--> `ObservableObject`  [EXTRACTED]
  Sources/ScreenFollow/Utilities/InputManager.swift →   _Bridges community 7 → community 2_
- `EventAuditLogger` --inherits--> `ObservableObject`  [EXTRACTED]
  Sources/ScreenFollow/Audit/EventAuditLogger.swift →   _Bridges community 7 → community 4_

## Communities

### Community 0 - "Community 0"
Cohesion: 0.07
Nodes (28): CaseIterable, Identifiable, EventType, keyboard, mouse, InputEvent, InputEventType, keyDown (+20 more)

### Community 1 - "Community 1"
Cohesion: 0.09
Nodes (16): PreviewProvider, View, AboutView, ConfigurationView, InputManager, RadioButton, SettingsSectionView, ContentView (+8 more)

### Community 2 - "Community 2"
Cohesion: 0.18
Nodes (1): InputManager

### Community 3 - "Community 3"
Cohesion: 0.15
Nodes (5): App, AppDelegate, KlicApp, NSApplication, String

### Community 4 - "Community 4"
Cohesion: 0.12
Nodes (6): AuditEvent, EventAuditLogger, SystemEventTap, Codable, Int, RecordingManager

### Community 5 - "Community 5"
Cohesion: 0.1
Nodes (20): Equatable, KeyboardEvent, MouseButton, extra1, extra2, left, middle, other (+12 more)

### Community 6 - "Community 6"
Cohesion: 0.12
Nodes (10): EventBus, ElementInfo, FollowEvent, keyDown, keyUp, mouseDown, mouseMoved, mouseUp (+2 more)

### Community 7 - "Community 7"
Cohesion: 0.14
Nodes (6): MouseMonitor, NSObject, ObservableObject, ScreenRecorder, SCStreamDelegate, SCStreamOutput

### Community 8 - "Community 8"
Cohesion: 0.14
Nodes (3): ConfigurationTests, FollowEventTests, XCTestCase

### Community 9 - "Community 9"
Cohesion: 0.22
Nodes (1): KeyboardMonitor

### Community 10 - "Community 10"
Cohesion: 0.15
Nodes (1): UserPreferences

### Community 11 - "Community 11"
Cohesion: 0.22
Nodes (4): NSViewRepresentable, BlurEffectView, InputOverlayView, MouseEventPassthrough

### Community 12 - "Community 12"
Cohesion: 0.29
Nodes (2): Logger, OSLogType

### Community 13 - "Community 13"
Cohesion: 0.4
Nodes (3): AnyObject, CLIStatusReporter, ScreenRecorderDelegate

### Community 14 - "Community 14"
Cohesion: 1.0
Nodes (1): Notification.Name

## Knowledge Gaps
- **43 isolated node(s):** `NSApplication`, `mouseMoved`, `mouseDown`, `mouseUp`, `keyDown` (+38 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **Thin community `Community 2`** (26 nodes): `.keyboardEvent()`, `InputManager`, `.cancelAllEventTimers()`, `.checkMonitoringStatus()`, `.clearAllEvents()`, `.filterRepeatKeyEvents()`, `.hideOverlay()`, `.init()`, `.removeDuplicateEvents()`, `.restartMonitoring()`, `.scheduleClearEventTimer()`, `.setAutoHideDelay()`, `.setInputTypeVisibility()`, `.setOpacityPreference()`, `.setupSubscriptions()`, `.shouldKeepEvent()`, `.showDemoInputs()`, `.showDemoMode()`, `.showOverlay()`, `.showOverlayManually()`, `.showReadyDemo()`, `.startMonitoring()`, `.stopMonitoring()`, `.updateActiveInputTypes()`, `.updateAllEvents()`, `.updateOpacity()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 9`** (14 nodes): `KeyboardMonitor`, `.addToRecentEvents()`, `.createEventTap()`, `.deinit()`, `.flagForModifier()`, `.handleCGEvent()`, `.init()`, `.isDuplicateEvent()`, `.isModifierKey()`, `.keyCodeToString()`, `.setupSubscription()`, `.startMonitoring()`, `.stopMonitoring()`, `KeyboardMonitor.swift`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 10`** (13 nodes): `UserPreferences.swift`, `UserPreferences`, `.getAutoHideDelay()`, `.getMinimalDisplayMode()`, `.getOverlayOpacity()`, `.getShowKeyboardInput()`, `.getShowMouseInput()`, `.registerDefaults()`, `.setAutoHideDelay()`, `.setMinimalDisplayMode()`, `.setOverlayOpacity()`, `.setShowKeyboardInput()`, `.setShowMouseInput()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 12`** (8 nodes): `Logger.swift`, `Logger`, `.debug()`, `.error()`, `.exception()`, `.info()`, `.warning()`, `OSLogType`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 14`** (2 nodes): `NotificationNames.swift`, `Notification.Name`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `ElementInfo` connect `Community 6` to `Community 4`?**
  _High betweenness centrality (0.195) - this node is a cross-community bridge._
- **Why does `AppDelegate` connect `Community 3` to `Community 1`, `Community 7`?**
  _High betweenness centrality (0.163) - this node is a cross-community bridge._
- **Why does `OverlayTheme` connect `Community 0` to `Community 1`, `Community 3`?**
  _High betweenness centrality (0.137) - this node is a cross-community bridge._
- **What connects `NSApplication`, `mouseMoved`, `mouseDown` to the rest of the system?**
  _43 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Community 0` be split into smaller, more focused modules?**
  _Cohesion score 0.07 - nodes in this community are weakly interconnected._
- **Should `Community 1` be split into smaller, more focused modules?**
  _Cohesion score 0.09 - nodes in this community are weakly interconnected._
- **Should `Community 4` be split into smaller, more focused modules?**
  _Cohesion score 0.12 - nodes in this community are weakly interconnected._