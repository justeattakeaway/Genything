/// Represents a type which can be generated from
public protocol Generator: Generatable {
    associatedtype T
    func next(_ randomSource: RandomSource) -> T
}

extension Generator {
    public func start() -> Self {
        self
    }
}

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
