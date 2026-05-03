import XCTest
@testable import ScreenFollow

final class ConfigurationTests: XCTestCase {
    func test_default_output_directory() { let cfg = Configuration(); XCTAssertFalse(cfg.outputDirectory.isEmpty) }
    func test_default_frame_rate() { let cfg = Configuration(); XCTAssertGreaterThan(cfg.frameRate, 0) }
    func test_default_video_codec() { let cfg = Configuration(); XCTAssertFalse(cfg.videoCodec.isEmpty) }
    func test_default_recording_quality() { let cfg = Configuration(); XCTAssertFalse(cfg.recordingQuality.isEmpty) }
    func test_custom_output_directory() { let cfg = Configuration(outputDirectory: "/tmp/recording"); XCTAssertEqual(cfg.outputDirectory, "/tmp/recording") }
    func test_custom_frame_rate() { let cfg = Configuration(frameRate: 30); XCTAssertEqual(cfg.frameRate, 30) }
    func test_custom_quality_low() { let cfg = Configuration(recordingQuality: "low"); XCTAssertEqual(cfg.recordingQuality, "low") }
}
