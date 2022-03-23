import Foundation

// MARK: Produce

extension Generator {
    /// Returns: A sequence of this generator's values which will produce `nil` after `size` iterations
    ///
    /// - Warning: The sequence (like all sequences) may be destructively consumed by iteration.
    ///     As a consequence, don't assume that multiple for-in loops will restart from the beginning.
    ///
    /// - SeeAlso: https://developer.apple.com/documentation/swift/sequence
    ///
    /// - Parameters:
    ///   - size: The amount of iterations before this sequence will begin to return `nil`
    ///   - randomSource: The RandomSource to be used for generation
    ///
    /// - Returns: The Sequence
    public func sequence(_ maxLength: Int, randomSource: RandomSource) -> AnySequence<T> {
        sequence(randomSource: randomSource).prefix(maxLength)
    }

    /// Returns: A sequence of this generator's values which will produce infinite elements
    ///
    /// - Warning: The sequence (like all sequences) may be destructively consumed by iteration. As a consequence, don't assume that multiple for-in loops will restart from the same place. Even if you are re-seeding the random source.
    ///
    /// - SeeAlso: https://developer.apple.com/documentation/swift/sequence
    ///
    /// - Parameters:
    ///   - randomSource: The RandomSource to be used for generation
    ///
    /// - Returns: The infinite sequence
    public func sequence(randomSource: RandomSource) -> AnySequence<T> {
        AnySequence(
            GeneratorSequence(self, randomSource: randomSource)
        )
    }
}
