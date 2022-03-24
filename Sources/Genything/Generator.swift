/// Represents a type which can be generated from
public protocol Generator {
    /// The type of element which this Generator produces
    associatedtype T
    /// Produces the next element from this generator using the provided random source
    ///
    /// - Parameter randomSource: A source of random to be used by upstream generators
    func next(_ randomSource: RandomSource) -> T
}
