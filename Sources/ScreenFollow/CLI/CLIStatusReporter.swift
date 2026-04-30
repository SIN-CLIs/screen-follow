import Foundation

protocol ScreenRecorderDelegate: AnyObject {
    func recorderDidStart(_ recorder: ScreenRecorder)
    func recorderDidStop(_ recorder: ScreenRecorder, error: Error?)
}

final class CLIStatusReporter: ScreenRecorderDelegate {
    func recorderDidStart(_ recorder: ScreenRecorder) {
        print("[\(Date.now)] Recording started")
    }
    func recorderDidStop(_ recorder: ScreenRecorder, error: Error?) {
        if let error = error {
            print("[\(Date.now)] Recording stopped with error: \(error.localizedDescription)")
        } else {
            print("[\(Date.now)] Recording stopped successfully")
        }
    }
}
