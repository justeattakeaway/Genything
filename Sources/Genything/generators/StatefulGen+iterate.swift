// MARK: Build

extension Generators {
    /// A Generator that generates a given sequence of elements.
    ///
    /// When the generator exhausts the elements in the sequence, it will begin to return nil.
    final public class Iterate<T, Elements>: Generator where Elements: Swift.Sequence, Elements.Element == T {
        var iterator: Elements.Iterator

        /// Creates a Generators for a sequence of elements.
        ///
        /// - Parameter sequence: The sequence of elements to generate.
        public init(_ sequence: Elements) {
            self.iterator = sequence.makeIterator()
        }

        public func next(_ context: Context) -> T? {
            iterator.next()
        }
    }
}
