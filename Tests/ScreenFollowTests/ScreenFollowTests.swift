import XCTest
import Combine
@testable import ScreenFollow

final class EventBusTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()

    func test_bus_publishes_mouse_event() {
        let bus = EventBus()
        let expectation = expectation(description: "mouse event received")

        bus.publisher
            .sink { event in
                if case .mouseDown = event { expectation.fulfill() }
                else { XCTFail("Wrong event type: \(event)") }
            }
            .store(in: &cancellables)

        let info = ElementInfo(role: "AXButton", label: "Start", path: "window/button")
        bus.post(.mouseDown(button: 0, x: 100, y: 200, element: info))
        wait(for: [expectation], timeout: 1.0)
    }

    func test_bus_publishes_key_event() {
        let bus = EventBus()
        let expectation = expectation(description: "key event received")

        bus.publisher
            .sink { event in
                if case .keyDown = event { expectation.fulfill() }
            }
            .store(in: &cancellables)

        bus.post(.keyDown(keyCode: 36, characters: "\n"))
        wait(for: [expectation], timeout: 1.0)
    }

    func test_audit_type_strings() {
        XCTAssertEqual(FollowEvent.mouseMoved(x: 0, y: 0).auditType, "mouse_moved")
        XCTAssertEqual(FollowEvent.mouseDown(button: 0, x: 0, y: 0, element: nil).auditType, "mouse_down")
        XCTAssertEqual(FollowEvent.keyDown(keyCode: 0, characters: "").auditType, "key_down")
        XCTAssertEqual(FollowEvent.scroll(deltaX: 0, deltaY: -300).auditType, "scroll")
    }
}
