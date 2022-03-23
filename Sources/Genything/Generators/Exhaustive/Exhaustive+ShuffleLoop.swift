extension Exhaustive {
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
    final class ShuffleLoop<Elements>: Generator where Elements: Swift.Collection {

        /// Creates a shuffled loop Generator for a collection of elements.
        ///
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
