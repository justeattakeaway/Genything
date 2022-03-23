extension DeferredGenerators {
    /// A generator which produces results by shuffling the provided list and drawing values until empty, then reshuffles
    ///
    /// - Attention: This generator has been lifted into a deferred generator to make it clear that repeated access will mutate the state of the internal index. When sharing this generator share it as it's wrapped `DeferredGenerator` type and only `start()` the generator when you are ready to store the stateful reference.
    ///
    /// Best visualized with a playing card metaphor
    ///     - the dealer shuffles the deck of cards and deals cards 1 by 1 until no more cards remain
    ///     - the dealer reshuffles the deck and repeats
    ///
    /// The same `value` cannot be redrawn until all other values are drawn
    ///
    /// - SeeAlso: https://developer.apple.com/documentation/gameplaykit/gkshuffleddistribution
    static func shuffleLoop<Elements>(_ collection: Elements) -> DeferredGenerator<AnyGenerator<Elements.Element>> where Elements: Swift.Collection {
        DeferredGenerator {
            ShuffleLoop(collection).eraseToAnyGenerator()
        }
    }
}

/// A generator which produces results by shuffling the provided list and drawing values until empty, then reshuffles
///
/// - Warning: In order to provide the shuffling functionality the Generator is stateful and requires a randomSource up-front
///
/// Best visualized with a playing card metaphor
///     - the dealer shuffles the deck of cards and deals cards 1 by 1 until no more cards remain
///     - the dealer reshuffles the deck and repeats
///
/// The same `value` cannot be redrawn until all other values are drawn
///
/// - SeeAlso: https://developer.apple.com/documentation/gameplaykit/gkshuffleddistribution
private class ShuffleLoop<Elements>: Generator where Elements: Swift.Collection {

    /// Creates a shuffled loop Generator for a collection of elements.
    ///
    /// - Precondition: The collection must not be empty.
    /// - Parameter collection: The collection of elements to loop.
    public init(_ collection: Elements) {
        assert(collection.startIndex != collection.endIndex)

        self.collection = Array(collection)
    }

    /// The element that this generator produces
    public typealias T = Elements.Element

    /// The collection from which this generator takes it's values
    public private(set) var collection: [T]
    /// An index which tracks our position in the collection
    public private(set) var index = 0

    /// Produces the next element from this generator
    public func next(_ randomSource: RandomSource) -> T {
        defer { collection.formIndex(after: &index) }
        if index >= collection.endIndex || !hasDrawnElements {
            index = collection.startIndex
            collection = collection.shuffled(using: &randomSource.rng)
            hasDrawnElements = true
        }
        return collection[index]
    }

    /// A flag to indicate if this generator has been used to draw a value before. This is used to defer the shuffling until we have a random source.
    private var hasDrawnElements = false
}
