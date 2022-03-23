public protocol Deferred {
    associatedtype G
    func start() -> G
}

public protocol Generatable: Deferred where G: Generator {}

public struct DeferredGenerator<G: Generator>: Generatable {
    private let starter: () -> G

    public init(_ starter: @escaping () -> G) {
        self.starter = starter
    }

    public func start() -> G {
        starter()
    }
}

extension Generatable {
    /// Returns: A generatable that transforms it's wrapped generator after it is started
    ///
    /// - Parameters:
    ///   - transform: A function which transforms the wrapped generator
    public func map<R: Generator>(_ transform: @escaping (G) -> R) -> DeferredGenerator<R> {
        DeferredGenerator {
            transform(start())
        }
    }
}
