/// Declares that a type can be used to generate an infinite sequence of values of the associatedtype `T`.
///
/// A Generators typically creates values using a `RandomSource`. If the `RandomSource` is not shared between multiple generators, then they are said to be independent e.g. One generator does not affect the randomness of any other generators.
///
/// - Note: The generator protocol has no requirement to be random nor is there any requirement to be stateless. The generator might generate random elements or follow some predetermined pattern. Therefore, sharing a generator between unrelated contexts should be done with care.
public protocol Generator {
    /// The type of element which this Generator produces
    associatedtype T
    /// Produces the next element from this generator using the provided random source
    ///
    /// - Parameter randomSource: A source of random to be used by upstream generators
    func next(_ randomSource: RandomSource) -> T
}
