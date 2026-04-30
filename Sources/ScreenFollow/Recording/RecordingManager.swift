import Foundation

final class RecordingManager {
    static let shared = RecordingManager()
    private let lockFileName = "screen-follow-recording.lock"
    private var lockFileURL: URL {
        FileManager.default.temporaryDirectory.appendingPathComponent(lockFileName)
    }
    var isRecording: Bool { FileManager.default.fileExists(atPath: lockFileURL.path) }
    func markRecordingStarted() {
        let pid = ProcessInfo.processInfo.processIdentifier
        try? "\(pid)".write(to: lockFileURL, atomically: true, encoding: .utf8)
    }
    func markRecordingStopped() {
        try? FileManager.default.removeItem(at: lockFileURL)
    }
    func getRecordingPID() -> Int? {
        guard let content = try? String(contentsOf: lockFileURL, encoding: .utf8) else { return nil }
        return Int(content.trimmingCharacters(in: .whitespacesAndNewlines))
    }
}
