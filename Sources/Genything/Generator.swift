/// Represents a type which can be generated from. The type is passed a `RandomSource` and is expected to use this source for any random operations such that the generator is deterministic. By controlling how this `RandomSource` is shared the generator's values can also be controlled such that they are independent if that is your desire. e.g. One generator does not affect other generators.
///
/// - Note: The generator protocol has no requirement to be completely stateless. The type might generate random elements or follow some pattern, and this patterns may rely on this generators previous generations. Therefore, sharing a generator between unrelated contexts should be done with care or consider wrapping the Generator into a `LazyGenerator`.
public protocol Generator {
    /// The type of element which this Generator produces
    associatedtype T
    /// Produces the next element from this generator using the provided random source
    ///
    /// - Parameter randomSource: A source of random to be used by upstream generators
    func next(_ randomSource: RandomSource) -> T
}
