import AppKit
import ApplicationServices

let app = NSApplication.shared
app.setActivationPolicy(.accessory)

let delegate = AppDelegate()
app.delegate = delegate

print("🖱️ screen-follow v0.1.0 — Cursor + Klicks + Tastatur + Video + Audit")
print("   Menu-Bar Icon: Klick für Settings")
print("   CLI: screen-follow record | stop | status | trace")

app.run()
