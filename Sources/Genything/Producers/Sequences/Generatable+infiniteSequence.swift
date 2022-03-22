import Foundation

// MARK: Produce

extension Generator {
    /// Returns: An infinite sequence of this generator's values
    ///
    /// - Warning: The resulting sequence is infinite
    ///
    /// - Parameters:
    ///   - randomSource: The randomSource to be used for generation
    ///
    /// - Returns: The Sequence
    func asInfiniteSequence(randomSource: RandomSource = .default()) -> InfiniteSequence<T> {
        InfiniteSequence {
            next(randomSource)
        }
    }
}
