import Foundation
import Combine

struct AuditEvent: Codable {
    let ts: TimeInterval
    let type: String
    var x: Double?
    var y: Double?
    var button: Int?
    var keyCode: Int?
    var characters: String?
    var deltaX: Int?
    var deltaY: Int?
    var elementRole: String?
    var elementLabel: String?
}

class EventAuditLogger: ObservableObject {
    static let shared = EventAuditLogger()
    @Published var isLogging = false
    
    private var fileHandle: FileHandle?
    private var logURL: URL?
    private var cancellables = Set<AnyCancellable>()
    private var recentEvents: [AuditEvent] = []
    private let maxRecent = 1000
    
    func startLogging(to url: URL) throws {
        if !FileManager.default.fileExists(atPath: url.path) {
            FileManager.default.createFile(atPath: url.path, contents: nil)
        }
        fileHandle = try FileHandle(forWritingTo: url)
        fileHandle?.seekToEndOfFile()
        logURL = url
        isLogging = true
        
        EventBus.shared.publisher.sink { [weak self] event in
            self?.log(event: event)
        }.store(in: &cancellables)
    }
    
    func stopLogging() {
        try? fileHandle?.close()
        fileHandle = nil
        cancellables.removeAll()
        isLogging = false
    }
    
    func lastEvents(count: Int) -> [AuditEvent] {
        return Array(recentEvents.suffix(count))
    }
    
    private func log(event: FollowEvent) {
        var entry = AuditEvent(ts: Date().timeIntervalSince1970, type: event.auditType)
        switch event {
        case .mouseMoved(let x, let y): entry.x = x; entry.y = y
        case .mouseDown(let btn, let x, let y, let el):
            entry.button = btn; entry.x = x; entry.y = y
            entry.elementRole = el?.role; entry.elementLabel = el?.label
        case .mouseUp(let btn, let x, let y): entry.button = btn; entry.x = x; entry.y = y
        case .keyDown(let kc, let chars): entry.keyCode = Int(kc); entry.characters = chars
        case .keyUp(let kc): entry.keyCode = Int(kc)
        case .scroll(let dx, let dy): entry.deltaX = dx; entry.deltaY = dy
        }
        
        recentEvents.append(entry)
        if recentEvents.count > maxRecent { recentEvents.removeFirst() }
        
        guard isLogging, let fh = fileHandle,
              let data = try? JSONEncoder().encode(entry),
              var line = String(data: data, encoding: .utf8) else { return }
        line += "\n"
        fh.write(line.data(using: .utf8)!)
    }
}
