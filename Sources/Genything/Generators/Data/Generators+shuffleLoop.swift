extension Generators {
    /// A generator which produces results by shuffling the provided list and drawing values until empty, then reshuffles
    ///
    /// Best visualized with a playing card metaphor
    ///     - the dealer shuffles the deck of cards and deals cards 1 by 1 until no more cards remain
    ///     - the dealer reshuffles the deck and repeats
    ///
    /// The same `value` cannot be redrawn until all other values are drawn
    ///
    /// - SeeAlso: https://developer.apple.com/documentation/gameplaykit/gkshuffleddistribution
    /// - Warning: The resulting generator accumulates state. Shared access of the same instance may have unintended effects. Be careful not to expose this generator as a singleton. When sharing the definition use a computed variable, a function, or wrap it with a `LazyGenerator` so that different generator instanced are always created on access.
    public static func shuffleLoop<Elements>(_ collection: Elements) -> AnyGenerator<Elements.Element>
        where Elements: Collection {
        ShuffleLoop(collection).eraseToAnyGenerator()
    }

    /// A generator which produces results by shuffling the provided list and drawing values until empty, then reshuffles
    ///
    /// Best visualized with a playing card metaphor
    ///     - the dealer shuffles the deck of cards and deals cards 1 by 1 until no more cards remain
    ///     - the dealer reshuffles the deck and repeats
    ///
    /// The same `value` cannot be redrawn until all other values are drawn
    ///
    /// - SeeAlso: https://developer.apple.com/documentation/gameplaykit/gkshuffleddistribution
    /// - Warning: The resulting generator accumulates state. Shared access of the same instance may have unintended effects. Be careful not to expose this generator as a singleton. When sharing the definition use a computed variable, a function, or wrap it with a `LazyGenerator` so that different generator instanced are always created on access.
    public static func shuffleLoop<T>(_ collection: T...) -> AnyGenerator<T> {
        shuffleLoop(collection)
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
    class ShuffleLoop<Elements>: Generator where Elements: Collection {

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

}
