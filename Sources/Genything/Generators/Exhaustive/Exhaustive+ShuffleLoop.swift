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

        // MARK: Lifecycle

        /// Creates a shuffled loop Generator for a collection of elements.
        ///
        /// - Parameter collection: The collection of elements to loop.
        public init(_ collection: Elements, randomSource: RandomSource) {
            assert(collection.startIndex != collection.endIndex)

            self.collection = collection.shuffled(using: &randomSource.rng)
            self.randomSource = randomSource
        }

        // MARK: Public

        public typealias T = Elements.Element

        public private(set) var collection: [T]
        public private(set) var index = 0

        public func next(_: RandomSource) -> T {
            defer {
                collection.formIndex(after: &index)
            }
            if index >= collection.endIndex {
                collection = collection.shuffled(using: &randomSource.rng)
                index = collection.startIndex
            }
            return collection[index]
        }

        // MARK: Private

        private let randomSource: RandomSource

    }
}
