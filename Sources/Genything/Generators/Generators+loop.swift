extension Generators {
    /// A stateful generator which produces elements by looping over a collection of elements.
    ///
    /// Since this generator will comprehensibly examine all elements of the collection it can be used to display all possible configurations or test all possible values when the problem space is small and known.
    ///
    /// - Warning: The resulting generator accumulates state. Shared access of the same instance may have unintended effects. Be careful not to expose this generator as a singleton. When sharing the definition use a computed variable, a function, or wrap it with a `LazyGenerator` so that different generator instanced are always created on access.
    public static func loop<Elements>(_ collection: Elements) -> AnyGenerator<Elements.Element> where Elements: Collection {
        Loop(collection).eraseToAnyGenerator()
    }

    /// A stateful generator which produces elements by looping over a collection of elements.
    ///
    /// Since this generator will comprehensibly examine all elements of the collection it can be used to display all possible configurations or test all possible values when the problem space is small and known.
    ///
    /// - Warning: The resulting generator accumulates state. Shared access of the same instance may have unintended effects. Be careful not to expose this generator as a singleton. When sharing the definition use a computed variable, a function, or wrap it with a `LazyGenerator` so that different generator instanced are always created on access.
    public static func loop<T>(_ collection: T...) -> AnyGenerator<T> {
        loop(collection)
    }
}

/// A stateful generator which produces elements by looping over a collection of elements.
///
/// Since this generator will comprehensibly examine all elements of the collection it can be used to display all possible configurations or test all possible values when the problem space is small and known.
///
/// - Warning: This generator is stateful and cannot be restarted. Pay attention to how the reference is being retained and do not share the generator to unsuspecting consumers.
class Loop<Elements>: Generator where Elements: Collection {

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
