/// A `RandomizedGenerator` wrapped as a `Sequence` which also acts as it's own `Iterator`
///
/// Length
/// ==============
/// This Sequence is infinite! Do not attempt to for-in the contents without limiting the sequence. To limit the sequence you can make use of Sequence operators such as `prefix()`.
///
/// Repeated Access
/// ==============
/// This sequence is destructively consumed by iteration. As a consequence, don’t assume that multiple for-in loops will either resume iteration or restart from the beginning:
public struct RandomizedGeneratorSequence<G>: Sequence, IteratorProtocol
    where G: Generator {

    /// The wrapped generator
    let generator: RandomizedGenerator<G>

    /// Initializes a `RandomizedGenerator` conforming to `Sequence` which also acts as it's own `Iterator`
    public init(_ generator: RandomizedGenerator<G>) {
        self.generator = generator
    }

    /// Produces the next value from the `RandomizedGenerator`
    public func next() -> G.T? {
        generator.next()
    }
}
