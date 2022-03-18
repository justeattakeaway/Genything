import Foundation

// MARK: Build

extension Generators {
    /// A Generator that generates by looping over a collection of elements.
    final public class Loop<Elements>: Generator where Elements: Swift.Collection {

        public typealias T = Elements.Element

        public let collection: Elements
        private(set) public var index: Elements.Index

        /// Creates a looping Generator for a collection of elements.
        ///
        /// - Parameter collection: The collection of elements to loop.
        public init(_ collection: Elements) {
            assert(collection.startIndex != collection.endIndex)

            self.collection = collection
            self.index = collection.startIndex
        }

        public func next(_ context: Context) -> T {
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
