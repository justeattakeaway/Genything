/// Represents a type which can be generated from
public protocol Generator: Generatable {
    /// The type of element which this Generator produces
    associatedtype T
    /// Produces the next element from this generator using the provided random source
    ///
    /// - Parameter randomSource: A source of random to be used by upstream generators
    func next(_ randomSource: RandomSource) -> T
}

extension Generator {
    /// This generator has already been started, so it is returned
    public func start() -> Self {
        self
    }
}
