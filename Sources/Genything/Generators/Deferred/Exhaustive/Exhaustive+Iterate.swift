extension Exhaustive {
    static func iterate<Elements>(_ sequence: Elements) -> DeferredGenerator<AnyGenerator<Elements.Element?>> where Elements: Swift.Sequence {
        DeferredGenerator {
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
