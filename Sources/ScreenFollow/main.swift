import Foundation
import AppKit
import SwiftUI

let args = CommandLine.arguments

if args.count >= 2 {
    switch args[1] {
    case "record":
        let url = args.count > 2 ? args[2] : "/tmp/screen-follow-recording.mov"
        print("🎥 Recording to \(url)")
        print("⚠️  GUI mode required. Start without args: screen-follow")
        exit(0)
    case "stop":
        print("⏹️  Stop — send SIGTERM to screen-follow process")
        exit(0)
    case "status":
        print("🖱️  screen-follow v0.2.0")
        print("   Cursor Trails: ✅")
        print("   Keyboard Display: ✅")
        print("   Recording: ✅ (ScreenCaptureKit)")
        print("   JSONL Audit: ✅")
        exit(0)
    case "version", "--version", "-v":
        print("screen-follow v0.2.0")
        exit(0)
    case "help", "--help", "-h":
        print("screen-follow — Ultimate Screen Agent Companion")
        print("COMMANDS: record | stop | status | version")
        exit(0)
    default:
        print("Unknown: \(args[1]). Try: screen-follow help")
        exit(1)
    }
}

// Launch GUI
_ = NSApplication.shared
KlicApp.main()
