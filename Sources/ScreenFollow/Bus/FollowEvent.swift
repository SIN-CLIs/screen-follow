import Foundation

enum FollowEvent {
    case mouseMoved(x: Double, y: Double)
    case mouseDown(button: Int, x: Double, y: Double)
    case mouseUp(button: Int, x: Double, y: Double)
    case keyDown(keyCode: UInt16, characters: String)
    case keyUp(keyCode: UInt16)
    case scroll(deltaX: Int, deltaY: Int)
    
    var auditType: String {
        switch self {
        case .mouseMoved: return "mouse_moved"
        case .mouseDown: return "mouse_down"
        case .mouseUp: return "mouse_up"
        case .keyDown: return "key_down"
        case .keyUp: return "key_up"
        case .scroll: return "scroll"
        }
    }
}
