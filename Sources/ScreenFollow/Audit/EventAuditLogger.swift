import Foundation

struct AuditEvent: Codable {
    let timestamp: TimeInterval
    let type: String
    let detail: String
}

class EventAuditLogger: ObservableObject {
    @Published var isLogging = false
    private var fileHandle: FileHandle?
    private var logURL: URL?
    
    func startLogging(to url: URL) throws {
        if !FileManager.default.fileExists(atPath: url.path) {
            FileManager.default.createFile(atPath: url.path, contents: nil)
        }
        fileHandle = try FileHandle(forWritingTo: url)
        fileHandle?.seekToEndOfFile()
        logURL = url
        isLogging = true
    }
    
    func stopLogging() {
        try? fileHandle?.close()
        fileHandle = nil
        isLogging = false
    }
    
    func log(type: String, detail: String) {
        guard isLogging, let fh = fileHandle else { return }
        let event = AuditEvent(timestamp: Date().timeIntervalSince1970, type: type, detail: detail)
        guard let data = try? JSONEncoder().encode(event),
              var line = String(data: data, encoding: .utf8) else { return }
        line += "\n"
        fh.write(line.data(using: .utf8)!)
    }
}
