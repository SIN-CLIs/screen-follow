import ScreenCaptureKit
import AVFoundation

class ScreenRecorder: NSObject, ObservableObject, SCStreamDelegate, SCStreamOutput {
    @Published var isRecording = false
    weak var delegate: ScreenRecorderDelegate?
    
    private var stream: SCStream?
    private var assetWriter: AVAssetWriter?
    private var videoInput: AVAssetWriterInput?
    
    func startRecording(to url: URL) async throws {
        let content = try await SCShareableContent.excludingDesktopWindows(false, onScreenWindowsOnly: true)
        guard let mainDisplay = content.displays.first else { return }
        let filter = SCContentFilter(display: mainDisplay, excludingApplications: [], exceptingWindows: [])
        
        let config = SCStreamConfiguration()
        config.width = 1920; config.height = 1080
        config.pixelFormat = kCVPixelFormatType_32BGRA
        config.queueDepth = 6
        
        stream = SCStream(filter: filter, configuration: config, delegate: self)
        let writer = try AVAssetWriter(url: url, fileType: .mov)
        let vs: [String: Any] = [AVVideoCodecKey: AVVideoCodecType.h264, AVVideoWidthKey: 1920, AVVideoHeightKey: 1080]
        videoInput = AVAssetWriterInput(mediaType: .video, outputSettings: vs)
        videoInput?.expectsMediaDataInRealTime = true
        guard let vi = videoInput, writer.canAdd(vi) else { return }
        writer.add(vi); writer.startWriting(); writer.startSession(atSourceTime: .zero)
        assetWriter = writer
        
        try stream?.addStreamOutput(self, type: .screen, sampleHandlerQueue: .main)
        try await stream?.startCapture()
        isRecording = true
        RecordingManager.shared.markRecordingStarted()
        delegate?.recorderDidStart(self)
    }
    
    func stopRecording() async {
        try? await stream?.stopCapture()
        videoInput?.markAsFinished()
        await assetWriter?.finishWriting()
        isRecording = false
        RecordingManager.shared.markRecordingStopped()
        delegate?.recorderDidStop(self, error: nil)
    }
    
    func stream(_ stream: SCStream, didOutputSampleBuffer sampleBuffer: CMSampleBuffer, of type: SCStreamOutputType) {
        guard type == .screen, let vi = videoInput, vi.isReadyForMoreMediaData else { return }
        vi.append(sampleBuffer)
    }
}
