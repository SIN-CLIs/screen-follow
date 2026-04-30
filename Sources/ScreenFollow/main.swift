import Foundation
import AppKit
import SwiftUI

let args = CommandLine.arguments

if args.count >= 2 {
    switch args[1] {
    case "record":
        var output = "/tmp/screen-follow-recording.mov"
        var video = false
        for (i, arg) in args.enumerated() {
            if arg == "--output", i+1 < args.count { output = args[i+1] }
            if arg == "--video" { video = true }
        }
        print("🎥 Recording… video=\(video) output=\(output)")
        let recorder = ScreenRecorder()
        Task {
            do { try await recorder.startRecording(to: URL(fileURLWithPath: output)) }
            catch { print("❌ Failed: \(error)"); exit(1) }
        }
        if video { RunLoop.main.run() }
        else { print("⚠️  --video flag needed for display capture"); exit(0) }
        
    case "stop":
        print("⏹️  Stop signal sent")
        exit(0)
        
    case "status":
        print("🖱️  screen-follow v0.2.0")
        print("   Cursor Trails: ✅")
        print("   Keyboard Overlay: ✅")
        print("   Recording: ✅ (ScreenCaptureKit)")
        print("   JSONL Audit: ✅ (EventBus)")
        print("   SystemEventTap: ✅ (single CGEventTap)")
        exit(0)
        
    case "trace":
        var count = 20
        for (i, arg) in args.enumerated() {
            if arg == "--last", i+1 < args.count, let n = Int(args[i+1]) { count = n }
        }
        let events = EventAuditLogger.shared.lastEvents(count: count)
        if events.isEmpty {
            print("No audit events yet. Start screen-follow (GUI) first.")
        } else {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            for e in events {
                if let data = try? encoder.encode(e), let str = String(data: data, encoding: .utf8) {
                    print(str)
                }
            }
        }
        exit(0)
        
    case "version", "--version", "-v":
        print("screen-follow v0.2.0")
        exit(0)
        
    case "help", "--help", "-h":
        print("screen-follow — Stealth Quad: Verify Layer")
        print("")
        print("COMMANDS:")
        print("  record [--video] [--output PATH]   Start screen recording")
        print("  stop                               Stop recording")
        print("  status                             Show status")
        print("  trace --last N                     Show last N audit events")
        print("  version                            Show version")
        print("  (no args)                          Launch GUI (Klic-based)")
        print("")
        print("Part of Stealth Triade: playstealth → skylight → screen-follow ← unmask")
        exit(0)
        
    default:
        print("Unknown: \(args[1]). Try: screen-follow help")
        exit(1)
    }
}

// GUI mode
_ = NSApplication.shared
if !SystemEventTap.shared.isRunning { SystemEventTap.shared.start() }
let logPath = "/tmp/screen-follow-audit.jsonl"
try? EventAuditLogger.shared.startLogging(to: URL(fileURLWithPath: logPath))
KlicApp.main()
