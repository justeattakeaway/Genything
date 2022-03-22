import Foundation

// MARK: Produce

extension Generator {
    /// Returns: An array of values from the generator
    ///
    /// - Parameters:
    ///   - count: The amount of values to generate, default's to the randomSource's `iterations` value
    ///   - randomSource: The randomSource to be used for generation
    ///
    /// - Returns: An array of generated values
    public func take(
        _ count: Int,
        randomSource: RandomSource = .default
    ) -> [T] {
        Array(asSequence(size: count, randomSource: randomSource))
    }
}
