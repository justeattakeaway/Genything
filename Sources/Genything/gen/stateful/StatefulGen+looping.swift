import Foundation

// MARK: Build

extension Generatables {
    /// A generatable that generates by looping over a collection of elements.
    public struct Loop<T, Elements>: Generatable where Elements: Swift.Collection, Elements.Element == T {
        public let collection: Elements

        /// Creates a looping generatable for a collection of elements.
        ///
        /// - Parameter collection: The collection of elements to loop.
        public init(collection: Elements) {
            assert(collection.startIndex != collection.endIndex)

            self.collection = collection
        }

        public func start() -> Gen<T> {
            var i = collection.startIndex
            return Gen { ctx in
                defer {
                    collection.formIndex(after: &i)
                }
                if i >= collection.endIndex {
                    i = collection.startIndex
                }
                return collection[i]
            }
        }
    }
}
