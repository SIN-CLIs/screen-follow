import XCTest
@testable import ScreenFollow

final class ConfigurationTests: XCTestCase {
    func test_default_output_directory() { let cfg = Configuration(); XCTAssertFalse(cfg.outputDirectory.isEmpty) }
    func test_default_frame_rate() { let cfg = Configuration(); XCTAssertGreaterThan(cfg.frameRate, 0) }
}
