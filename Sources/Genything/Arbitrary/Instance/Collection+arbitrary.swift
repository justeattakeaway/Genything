extension Collection {
    /// Returns: A generator which randomly produces values form the receiving collection
    ///
    /// - Precondition: The collection must not be empty
    ///
    /// - Returns: The generator
    public var arbitrary: AnyGenerator<Element> {
        assert(!isEmpty, "`arbitrary` was invoked on an empty collection")
        return AnyGenerator { randomSource in
            randomElement(using: &randomSource.rng)!
        }
    }
}
