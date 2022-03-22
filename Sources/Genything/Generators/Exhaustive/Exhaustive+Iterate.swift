extension Exhaustive {
    /// A Generator that generates a given sequence of elements.
    ///
    /// When the generator exhausts the elements in the sequence, it will begin to return nil.
    public final class Iterate<T, Elements>: Generator where Elements: Swift.Sequence, Elements.Element == T {

        // MARK: Lifecycle

        /// Creates a Generators for a sequence of elements.
        ///
        /// - Parameter sequence: The sequence of elements to generate.
        public init(_ sequence: Elements) {
            iterator = sequence.makeIterator()
        }

        // MARK: Public

        public func next(_: RandomSource) -> T? {
            iterator.next()
        }

        // MARK: Internal

        var iterator: Elements.Iterator

    }
}
