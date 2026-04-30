import AppKit
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusItem: NSStatusItem!
    private var overlayController: OverlayWindowController?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        setupMenuBar()
        startOverlay()
        print("✅ screen-follow läuft — Cursor-Overlay aktiv")
    }
    
    private func setupMenuBar() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem.button?.title = "🖱️"
        
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Toggle Cursor Highlight", action: #selector(toggleCursor), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        statusItem.menu = menu
    }
    
    @objc func toggleCursor() {
        overlayController?.toggle()
    }
    
    private func startOverlay() {
        overlayController = OverlayWindowController()
        overlayController?.showWindow(nil)
    }
}
