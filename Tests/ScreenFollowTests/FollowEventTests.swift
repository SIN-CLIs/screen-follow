import XCTest
@testable import ScreenFollow

final class FollowEventTests: XCTestCase {
    func test_mouseDown_auditType() { XCTAssertEqual(FollowEvent.mouseDown(button: 0, x: 100, y: 200, element: nil).auditType, "mouse_down") }
    func test_mouseUp_auditType() { XCTAssertEqual(FollowEvent.mouseUp(button: 0, x: 300, y: 400).auditType, "mouse_up") }
    func test_mouseMoved_auditType() { XCTAssertEqual(FollowEvent.mouseMoved(x: 50, y: 60).auditType, "mouse_moved") }
    func test_keyDown_auditType() { XCTAssertEqual(FollowEvent.keyDown(keyCode: 36, characters: "\n").auditType, "key_down") }
    func test_keyUp_auditType() { XCTAssertEqual(FollowEvent.keyUp(keyCode: 36).auditType, "key_up") }
    func test_scroll_auditType() { XCTAssertEqual(FollowEvent.scroll(deltaX: 0, deltaY: -300).auditType, "scroll") }
    func test_enum_equality() { 
        let a = FollowEvent.mouseMoved(x: 0, y: 0)
        let b = FollowEvent.mouseMoved(x: 0, y: 0)
        XCTAssertEqual(a.auditType, b.auditType)
    }
    func test_mouseDown_coordinates() { let e = FollowEvent.mouseDown(button: 1, x: 640, y: 480, element: nil); XCTAssertEqual(e.auditType, "mouse_down") }
    func test_keyDown_with_characters() { let e = FollowEvent.keyDown(keyCode: 49, characters: "a"); XCTAssertEqual(e.auditType, "key_down") }
    func test_scroll_negative_deltaY() { let e = FollowEvent.scroll(deltaX: 0, deltaY: 100); XCTAssertEqual(e.auditType, "scroll") }
    func test_element_focused_auditType() {
        let info = ElementInfo(role: "AXButton", label: "Ok", path: "dialog/button")
        let e = FollowEvent.elementFocused(element: info)
        XCTAssertEqual(e.auditType, "element_focused")
    }
}
