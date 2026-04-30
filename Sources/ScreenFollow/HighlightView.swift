import AppKit
import CoreGraphics

class HighlightView: NSView {
    var cursorPosition: CGPoint = .zero {
        didSet { needsDisplay = true }
    }
    
    private var clickRipples: [ClickRipple] = []
    
    struct ClickRipple {
        let position: CGPoint
        var radius: CGFloat = 0
        var opacity: CGFloat = 1.0
        let maxRadius: CGFloat = 60
    }
    
    override init(frame: NSRect) {
        super.init(frame: frame)
        wantsLayer = true
        layer?.isOpaque = false
        
        NSEvent.addGlobalMonitorForEvents(matching: .leftMouseDown) { [weak self] _ in
            self?.addRipple()
        }
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func addRipple() {
        let ripple = ClickRipple(position: cursorPosition)
        clickRipples.append(ripple)
        needsDisplay = true
        
        Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { [weak self] timer in
            guard let self = self, let idx = self.clickRipples.indices.first else { timer.invalidate(); return }
            self.clickRipples[idx].radius += 2
            self.clickRipples[idx].opacity -= 0.02
            if self.clickRipples[idx].radius > self.clickRipples[idx].maxRadius {
                self.clickRipples.remove(at: idx)
            }
            self.needsDisplay = true
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        let ctx = NSGraphicsContext.current?.cgContext
        
        // Cursor Circle
        ctx?.setFillColor(NSColor.systemBlue.withAlphaComponent(0.3).cgColor)
        ctx?.fillEllipse(in: CGRect(x: cursorPosition.x - 20, y: cursorPosition.y - 20, width: 40, height: 40))
        
        ctx?.setStrokeColor(NSColor.systemBlue.withAlphaComponent(0.6).cgColor)
        ctx?.setLineWidth(2)
        ctx?.strokeEllipse(in: CGRect(x: cursorPosition.x - 25, y: cursorPosition.y - 25, width: 50, height: 50))
        
        // Click Ripples
        for ripple in clickRipples {
            ctx?.setStrokeColor(NSColor.systemRed.withAlphaComponent(ripple.opacity).cgColor)
            ctx?.setLineWidth(3)
            ctx?.strokeEllipse(in: CGRect(
                x: ripple.position.x - ripple.radius,
                y: ripple.position.y - ripple.radius,
                width: ripple.radius * 2,
                height: ripple.radius * 2
            ))
        }
    }
}
