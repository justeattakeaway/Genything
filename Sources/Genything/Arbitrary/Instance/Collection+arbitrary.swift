extension Collection {
    /// Returns: A generator which randomly produces values form the receiving collection
    ///
    /// - Precondition: The collection must not be empty
    ///
    /// - Returns: The generator
    public var arbitrary: AnyGenerator<Element> {
        ArbitraryElement(self).eraseToAnyGenerator()
    }
}

private struct ArbitraryElement<Elements>: Generator where Elements: Collection {
    let collection: Elements
    init(_ collection: Elements) {
        assert(!collection.isEmpty, "`ArbitraryElement` generator initialized with empty collection")
        self.collection = collection
    }

    public func next(_ randomSource: RandomSource) -> Elements.Element {
        collection.randomElement(using: &randomSource.rng)!
    }
}
