/// A LazyGenerator defers the initialization of a generator until a later time. This should be used when generators have state requirements which might cause them to behave in unexpected ways when shared or recreated.
///
/// The wrapped Generator can be safely transformed while retaining the lazy initialization via `map(transform:)`
public struct LazyGenerator<G: Generator> {
    /// Initializes the DeferredGenerator with a starter factory that produces a Generator when started
    public init(_ starter: @escaping () -> G) {
        self.starter = starter
    }

    /// Produce a generator using the wrapped factory
    public func start() -> G {
        starter()
    }

    /// Returns: A generatable that transforms it's wrapped generator. The transformations will be deferred until after the Generatable has been started allowing for transformations that can be shared safely.
    ///
    /// - Parameters:
    ///   - transform: A function which transforms the wrapped generator
    public func map<R: Generator>(_ transform: @escaping (G) -> R) -> LazyGenerator<R> {
        LazyGenerator<R> {
            transform(start())
        }
    }

    private let starter: () -> G

}
