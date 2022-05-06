extension RandomSource {
    /// Drops the specified elements from the wrapped RandomNumberGenerator.
    ///
    /// - Attention: The generator will still have to internally generate the values.
    ///
    /// - Precondition: The provided `count` should be positive
    ///
    /// - Returns: The receiving RandomSource after the specified values have been dropped
    public func dropFirst(_ count: Int = 1) -> RandomSource {
        assert(count >= 0, "`dropFirst(count:)` called with a negative count")
        for _ in 0 ..< count {
            _ = rng.next()
        }
        return self
    }
}
