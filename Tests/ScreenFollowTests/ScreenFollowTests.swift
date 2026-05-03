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

    func test_bus_publishes_scroll_event() {
        let bus = EventBus()
        let expectation = expectation(description: "scroll event received")
        bus.publisher
            .sink { event in
                if case .scroll = event { expectation.fulfill() }
            }
            .store(in: &cancellables)
        bus.post(.scroll(deltaX: 0, deltaY: -100))
        wait(for: [expectation], timeout: 1.0)
    }

    func test_bus_publishes_element_focus() {
        let bus = EventBus()
        let expectation = expectation(description: "elementFocus event received")
        bus.publisher
            .sink { event in
                if case .elementFocused = event { expectation.fulfill() }
            }
            .store(in: &cancellables)
        let info = ElementInfo(role: "AXTextField", label: "Email", path: "dialog/textfield")
        bus.post(.elementFocused(element: info))
        wait(for: [expectation], timeout: 1.0)
    }

    func test_bus_multiple_subscribers() {
        let bus = EventBus()
        var count = 0
        let sub1 = bus.publisher.sink { _ in count += 1 }
        let sub2 = bus.publisher.sink { _ in count += 1 }
        bus.post(.mouseMoved(x: 50, y: 60))
        _ = sub1; _ = sub2
        XCTAssertEqual(count, 2)
    }
}
