// MARK: Combine

public extension Generator {
    /// Returns: A generator which iterates the elements of `sequence`. When exhausted the generator will switch to producing values from the receiving generator.
    ///
    /// - Parameters:
    ///    - values: Array of values which will be produced in order before the receiver takes over
    ///
    /// - Returns: The generator
    func startWith<S: Swift.Sequence>(_ sequence: S) -> AnyGenerator<T> where S.Element == T {
        StartWith(source: self, sequence: sequence).eraseToAnyGenerator()
    }
}

final private class StartWith<Source, Elements>: Generator where Elements: Swift.Sequence, Source: Generator, Source.T == Elements.Element {
    let source: Source
    var iterator: Elements.Iterator
    /// Creates a Generators for a sequence of elements.
    ///
    /// - Parameter sequence: The sequence of elements to generate.
    public init(source: Source, sequence: Elements) {
        self.source = source
        self.iterator = sequence.makeIterator()
    }

    public func next(_ context: Context) -> Source.T {
        iterator.next() ?? source.next(context)
    }
}
