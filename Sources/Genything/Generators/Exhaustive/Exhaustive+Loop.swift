extension Exhaustive {
    /// A Generator that generates by looping over a collection of elements.
    public final class Loop<Elements>: Generator where Elements: Swift.Collection {

        // MARK: Lifecycle

        /// Creates a looping Generator for a collection of elements.
        ///
        /// - Parameter collection: The collection of elements to loop.
        public init(_ collection: Elements) {
            assert(collection.startIndex != collection.endIndex)

            self.collection = collection
            index = collection.startIndex
        }

        // MARK: Public

        public typealias T = Elements.Element

        public let collection: Elements
        public private(set) var index: Elements.Index

        public func next(_: RandomSource) -> T {
            defer {
                collection.formIndex(after: &index)
            }
            if index >= collection.endIndex {
                index = collection.startIndex
            }
            return collection[index]
        }
    }
}
