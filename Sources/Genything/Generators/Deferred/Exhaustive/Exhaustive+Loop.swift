extension Exhaustive {
    static func loop<Elements>(_ collection: Elements) -> DeferredGenerator<AnyGenerator<Elements.Element>> where Elements: Swift.Collection {
        DeferredGenerator {
            Loop(collection).eraseToAnyGenerator()
        }
    }
}

/// A stateful Generator which produces elements by looping over a collection of elements.
///
/// - Warning: This generator is stateful and cannot be restarted. Pay attention to how it to how the reference is being retained and do not share the generator to unsuspecting consumers.
private class Loop<Elements>: Generator where Elements: Swift.Collection {

    /// Creates a Generator that loops the provided collection of elements.
    ///
    /// - Precondition: The collection must not be empty.
    /// - Parameter collection: The collection of elements to loop.
    public init(_ collection: Elements) {
        assert(collection.startIndex != collection.endIndex)

        self.collection = collection
        index = collection.startIndex
    }

    /// The collection from which this generator takes it's values
    public let collection: Elements
    /// An index which tracks our position in the collection
    public private(set) var index: Elements.Index

    /// Produces the next element from this generator
    public func next(_: RandomSource) -> Elements.Element {
        defer {
            collection.formIndex(after: &index)
        }
        if index >= collection.endIndex {
            index = collection.startIndex
        }
        return collection[index]
    }
}
