extension DeferredGenerators {
    /// A Generator that generates a given `Sequence` of elements. When the generator exhausts the elements in the sequence, it will begin to return nil.
    ///
    /// - Attention: This generator has been lifted into a deferred generator to make it clear that repeated access will mutate the state of the internal index. When sharing this generator share it as it's wrapped `DeferredGenerator` type and only `start()` the generator when you are ready to store the stateful reference.
    static func iterate<Elements>(_ sequence: Elements) -> LazyGenerator<AnyGenerator<Elements.Element?>> where Elements: Swift.Sequence {
        LazyGenerator {
            Iterate(sequence).eraseToAnyGenerator()
        }
    }
}

/// A Generator that generates a given `Sequence` of elements. When the generator exhausts the elements in the sequence, it will begin to return nil.
///
/// - Warning: This generator is stateful and cannot be restarted. Pay attention to how it to how the reference is being retained and do not share the generator to unsuspecting consumers.
private class Iterate<Elements>: Generator where Elements: Swift.Sequence {

    /// Creates a Generator for a sequence of elements.
    ///
    /// - Parameter sequence: The sequence of elements to generate from.
    public init(_ sequence: Elements) {
        iterator = sequence.makeIterator()
    }

    /// Produces the next value in the sequence (or nil if it becomes exhausted).
    public func next(_: RandomSource) -> Elements.Element? {
        iterator.next()
    }

    /// An iterator for the provided sequence Elements
    var iterator: Elements.Iterator

}
