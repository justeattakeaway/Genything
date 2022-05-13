extension Generators {
    /// A Generator that generates a given `Sequence` of elements. When the generator exhausts the elements in the sequence, it will begin to return nil.
    ///
    /// - Warning: The resulting generator accumulates state. Shared access of the same instance may have unintended effects. Be careful not to expose this generator as a singleton. When sharing the definition use a computed variable, a function, or wrap it with a `LazyGenerator` so that different generator instanced are always created on access.
    public static func iterate<Elements>(_ sequence: Elements) -> AnyGenerator<Elements.Element?> where Elements: Sequence {
        Iterate(sequence).eraseToAnyGenerator()
    }

    /// A Generator that generates a given `Sequence` of elements. When the generator exhausts the elements in the sequence, it will begin to return nil.
    ///
    /// - Warning: The resulting generator accumulates state. Shared access of the same instance may have unintended effects. Be careful not to expose this generator as a singleton. When sharing the definition use a computed variable, a function, or wrap it with a `LazyGenerator` so that different generator instanced are always created on access.
    public static func iterate<T>(_ sequence: T...) -> AnyGenerator<T?> {
        iterate(sequence)
    }


    /// A Generator that generates a given `Sequence` of elements. When the generator exhausts the elements in the sequence, it will begin to return nil.
    ///
    /// - Warning: This generator is stateful and cannot be restarted. Pay attention to how the reference is being retained and do not share the generator to unsuspecting consumers.
    final class Iterate<Elements>: Generator where Elements: Sequence {

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
}
