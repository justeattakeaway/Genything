public extension StatefulGen {
    /// Returns: A generator which produces results by shuffling the provided list and drawing values until empty, then reshuffles
    ///
    /// Best visualized with a playing card metaphor
    ///     - the dealer shuffles the deck of cards and deals cards 1 by 1 until no more cards remain
    ///     - the dealer reshuffles the deck and repeats
    ///
    /// The same `value` cannot be redrawn until all other values are drawn
    ///
    /// - SeeAlso: https://developer.apple.com/documentation/gameplaykit/gkshuffleddistribution
    static func shuffledDistribution(_ values: [T]) -> StatefulGen<T> {
        assert(!values.isEmpty, "`StatefulGen.shuffledDistribution(values:)` was invoked with an empty list of values")

        return StatefulGen<T?>.looping(
            StatefulGen<T?>.inContext { ctx in
                StatefulGen<T>.iterate(values.shuffled(using: &ctx.rng))
            }
        )
    }
}
