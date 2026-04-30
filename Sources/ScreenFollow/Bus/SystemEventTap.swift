import CoreGraphics
import ApplicationServices

final class SystemEventTap {
    static let shared = SystemEventTap()
    private var eventTap: CFMachPort?
    private var runLoopSource: CFRunLoopSource?
    var isRunning = false
    
    func start() {
        guard !isRunning else { return }
        let eventMask = (1 << CGEventType.mouseMoved.rawValue)
                      | (1 << CGEventType.leftMouseDown.rawValue)
                      | (1 << CGEventType.leftMouseUp.rawValue)
                      | (1 << CGEventType.rightMouseDown.rawValue)
                      | (1 << CGEventType.rightMouseUp.rawValue)
                      | (1 << CGEventType.keyDown.rawValue)
                      | (1 << CGEventType.keyUp.rawValue)
                      | (1 << CGEventType.scrollWheel.rawValue)
        
        let selfPtr = Unmanaged.passUnretained(self).toOpaque()
        guard let tap = CGEvent.tapCreate(tap: .cgSessionEventTap, place: .headInsertEventTap,
            options: .defaultTap, eventsOfInterest: CGEventMask(eventMask),
            callback: { (_, type, event, refcon) -> Unmanaged<CGEvent>? in
                let mySelf = Unmanaged<SystemEventTap>.fromOpaque(refcon!).takeUnretainedValue()
                mySelf.handle(type: type, event: event)
                return Unmanaged.passRetained(event)
            }, userInfo: selfPtr)
        else { print("⚠️  EventTap failed — Accessibility?"); return }
        
        eventTap = tap
        runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, tap, 0)
        CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, .commonModes)
        CGEvent.tapEnable(tap: tap, enable: true)
        isRunning = true
    }
    
    func stop() {
        guard let tap = eventTap else { return }
        CGEvent.tapEnable(tap: tap, enable: false)
        if let rls = runLoopSource { CFRunLoopRemoveSource(CFRunLoopGetCurrent(), rls, .commonModes) }
        eventTap = nil; runLoopSource = nil; isRunning = false
    }
    
    private func elementAt(point: CGPoint) -> ElementInfo? {
        var element: AXUIElement?
        let result = AXUIElementCopyElementAtPosition(AXUIElementCreateSystemWide(), Float(point.x), Float(point.y), &element)
        guard result == .success, let el = element else { return nil }
        var roleRef: CFTypeRef?, labelRef: CFTypeRef?
        AXUIElementCopyAttributeValue(el, kAXRoleAttribute as CFString, &roleRef)
        AXUIElementCopyAttributeValue(el, kAXDescriptionAttribute as CFString, &labelRef)
        if labelRef == nil { AXUIElementCopyAttributeValue(el, kAXTitleAttribute as CFString, &labelRef) }
        let role = (roleRef as? String) ?? "unknown"
        let label = (labelRef as? String) ?? ""
        return ElementInfo(role: role, label: label, path: "")
    }
    
    private func handle(type: CGEventType, event: CGEvent) {
        let loc = event.location
        switch type {
        case .mouseMoved: EventBus.shared.post(.mouseMoved(x: loc.x, y: loc.y))
        case .leftMouseDown:
            let el = elementAt(point: loc)
            EventBus.shared.post(.mouseDown(button: 0, x: loc.x, y: loc.y, element: el))
        case .rightMouseDown:
            let el = elementAt(point: loc)
            EventBus.shared.post(.mouseDown(button: 1, x: loc.x, y: loc.y, element: el))
        case .leftMouseUp: EventBus.shared.post(.mouseUp(button: 0, x: loc.x, y: loc.y))
        case .rightMouseUp: EventBus.shared.post(.mouseUp(button: 1, x: loc.x, y: loc.y))
        case .keyDown:
            let kc = UInt16(event.getIntegerValueField(.keyboardEventKeycode))
            var chars = [UniChar](repeating: 0, count: 4)
            var len = 0
            event.keyboardGetUnicodeString(maxStringLength: 4, actualStringLength: &len, unicodeString: &chars)
            EventBus.shared.post(.keyDown(keyCode: kc, characters: String(utf16CodeUnits: chars, count: len)))
        case .keyUp:
            EventBus.shared.post(.keyUp(keyCode: UInt16(event.getIntegerValueField(.keyboardEventKeycode))))
        case .scrollWheel:
            EventBus.shared.post(.scroll(deltaX: Int(event.getIntegerValueField(.scrollWheelEventDeltaAxis2)),
                                          deltaY: Int(event.getIntegerValueField(.scrollWheelEventDeltaAxis1))))
        default: break
        }
    }
}
