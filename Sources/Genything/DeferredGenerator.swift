/// Types conforming to Generatable store a Generator factory, so that the concrete Generator is not created until started. This can be done for Generators with state requirements which might behave in unexpected ways when shared or recreated.
///
/// The wrapped Generator can be safely transformed in the same abstract and deferred manner via `map(transform:)`
public protocol Generatable {
    /// The type of Generator which we can start
    associatedtype G: Generator
    /// Create and return the Generator
    func start() -> G
}

/// A DeferredGenerator can be started at a later time. This can be done for Generators with state requirements which might behave in unexpected ways when shared or recreated.
///
/// The wrapped Generator can be safely transformed in the same abstract and deferred manner via `map(transform:)`
public struct DeferredGenerator<G: Generator>: Generatable {
    private let starter: () -> G

    /// Initializes the DeferredGenerator with a starter factory that produces a Generator when started
    public init(_ starter: @escaping () -> G) {
        self.starter = starter
    }

    /// Produce a generator using the wrapped factory
    public func start() -> G {
        starter()
    }
}

extension Generatable {
    /// Returns: A generatable that transforms it's wrapped generator. The transformations will be deferred until after the Generatable has been started allowing for transformations that can be shared safely.
    ///
    /// - Parameters:
    ///   - transform: A function which transforms the wrapped generator
    public func map<R: Generator>(_ transform: @escaping (G) -> R) -> DeferredGenerator<R> {
        DeferredGenerator {
            transform(start())
        }
    }
}
