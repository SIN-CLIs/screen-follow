import AppKit
import CoreGraphics

class OverlayWindowController: NSWindowController {
    private var highlightView: HighlightView!
    private var eventMonitor: Any?
    private var isActive = true
    
    convenience init() {
        let window = NSWindow(
            contentRect: NSScreen.main?.frame ?? .zero,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )
        window.isOpaque = false
        window.backgroundColor = .clear
        window.level = .screenSaver
        window.ignoresMouseEvents = true
        window.collectionBehavior = [.canJoinAllSpaces, .stationary, .transient]
        self.init(window: window)
        
        highlightView = HighlightView(frame: window.contentView?.bounds ?? .zero)
        window.contentView = highlightView
        
        startMouseTracking()
    }
    
    func toggle() {
        isActive.toggle()
        window?.setIsVisible(isActive)
    }
    
    private func startMouseTracking() {
        eventMonitor = NSEvent.addGlobalMonitorForEvents(matching: .mouseMoved) { [weak self] event in
            self?.updateCursorPosition(event)
        }
    }
    
    private func updateCursorPosition(_ event: NSEvent) {
        guard isActive else { return }
        let point = NSEvent.mouseLocation
        highlightView.cursorPosition = point
    }
}
