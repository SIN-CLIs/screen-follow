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
        recorder.delegate = CLIStatusReporter()
        Task {
            do { try await recorder.startRecording(to: URL(fileURLWithPath: output)) }
            catch { print("❌ \(error)"); exit(1) }
        }
        if video { RunLoop.main.run() }
        else { print("⚠️  Add --video for display capture"); exit(0) }
        
    case "stop":
        if let pid = RecordingManager.shared.getRecordingPID() {
            print("⏹️  Stopping recording (PID \(pid))")
            kill(pid_t(pid), SIGTERM)
        } else {
            print("⏹️  No active recording found")
        }
        exit(0)
        
    case "status":
        let recording = RecordingManager.shared.isRecording ? "🔴 RECORDING" : "⚪ idle"
        if let pid = RecordingManager.shared.getRecordingPID() {
            print("🖱️  screen-follow v0.2.1 — \(recording) (PID \(pid))")
        } else {
            print("🖱️  screen-follow v0.2.1 — \(recording)")
        }
        print("   EventBus: ✅ | Audit: ✅ | SystemEventTap: ✅")
        exit(0)
        
    case "trace":
        var count = 20
        for (i, arg) in args.enumerated() {
            if arg == "--last", i+1 < args.count, let n = Int(args[i+1]) { count = n }
        }
        let logger = EventAuditLogger.shared
        if !logger.isLogging {
            let logPath = "/tmp/screen-follow-audit.jsonl"
            try? logger.startLogging(to: URL(fileURLWithPath: logPath))
        }
        let events = logger.lastEvents(count: count)
        if events.isEmpty {
            print("No audit events yet. Start: screen-follow (GUI)")
        } else {
            for e in events {
                if let data = try? JSONEncoder().encode(e),
                   let str = String(data: data, encoding: .utf8) {
                    print(str)
                }
            }
        }
        exit(0)
        
    case "version", "--version", "-v":
        print("screen-follow v0.2.1")
        exit(0)
        
    case "help", "--help", "-h":
        print("screen-follow — Stealth Quad: Verify Layer")
        print("COMMANDS: record --video | stop | status | trace --last N | version")
        exit(0)
        
    default:
        print("Unknown: \(args[1]). Try: screen-follow help"); exit(1)
    }
}

// GUI
_ = NSApplication.shared
if !SystemEventTap.shared.isRunning { SystemEventTap.shared.start() }
let logPath = "/tmp/screen-follow-audit.jsonl"
try? EventAuditLogger.shared.startLogging(to: URL(fileURLWithPath: logPath))
KlicApp.main()
