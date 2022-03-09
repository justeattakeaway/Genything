import Foundation

// MARK: Build

public extension Gen {
    /// Returns: A generator which produces the result of shuffling the provided list
    ///
    /// - Warning: The values list must not be empty
    ///
    /// - Parameter values: The values which this generator will shuffle
    ///
    /// - Returns: The generator
    static func shuffled(_ values: [T]) -> Gen<[T]> {
        assert(!values.isEmpty, "`Gen.shuffled(values:)` was invoked with an empty list of values")

        return Gen<[T]> { ctx in
            values.shuffled(using: &ctx.rng)
        }
    }

    /// Returns: A generator which produces results by shuffling the provided list and drawing values until empty, then reshuffles
    ///
    /// Best visualized with a playing card metaphor
    ///     - the dealer shuffles the deck of cards and deals cards 1 by 1 until no more cards remain
    ///     - the dealer reshuffles the deck and repeats
    ///
    /// The same `value` cannot be redrawn until all other values are drawn
    ///
    /// - SeeAlso: https://developer.apple.com/documentation/gameplaykit/gkshuffleddistribution
    static func shuffledDistribution(_ values: [T]) -> Gen<T> {
        assert(!values.isEmpty, "`Gen.shuffledDistribution(values:)` was invoked with an empty list of values")

        return Gen<T?>.looping(
            Gen<T?>.inContext { ctx in
                Gen.iterate(values.shuffled(using: &ctx.rng))
            }
        )
    }
}
