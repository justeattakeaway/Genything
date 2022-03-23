extension Generator {
    /// Returns: A generator which iterates the elements of `sequence`. When exhausted the generator will switch to producing values from the receiving generator.
    ///
    /// - Warning: The resulting generator will become stateful
    ///
    /// - Parameters:
    ///    - values: Array of values which will be produced in order before the receiver takes over
    ///
    /// - Returns: The generator
    func startWith<S: Swift.Sequence>(_ sequence: S) -> AnyGenerator<T> where S.Element == T {
        StartWith(source: self, sequence: sequence).eraseToAnyGenerator()
    }
}

// MARK: - StartWith

private final class StartWith<Source, Elements>: Generator where Elements: Swift.Sequence, Source: Generator,
    Source.T == Elements.Element {

    /// Creates a Generators for a sequence of elements.
    ///
    /// - Parameter sequence: The sequence of elements to generate.
    public init(source: Source, sequence: Elements) {
        self.source = source
        iterator = sequence.makeIterator()
    }

    public func next(_ randomSource: RandomSource) -> Source.T {
        iterator.next() ?? source.next(randomSource)
    }

    let source: Source
    var iterator: Elements.Iterator
}
