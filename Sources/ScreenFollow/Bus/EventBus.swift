import Combine

final class EventBus {
    static let shared = EventBus()
    private let subject = PassthroughSubject<FollowEvent, Never>()
    var publisher: AnyPublisher<FollowEvent, Never> { subject.eraseToAnyPublisher() }
    func post(_ event: FollowEvent) { subject.send(event) }
}
