// MARK: Produce

extension Generator {
    /// Returns: An array of values from the generator
    ///
    /// - Parameters:
    ///   - count: The amount of values to generate
    ///   - randomSource: The randomSource to be used for generation
    ///
    /// - Returns: An array of generated values
    public func take(
        _ count: Int,
        randomSource: RandomSource
    ) -> [T] {
        Array(sequence(count, randomSource: randomSource))
    }
}
