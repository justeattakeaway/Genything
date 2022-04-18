extension Generator {
    /// Returns: A generator that transforms the receivers' values into a value of type `R`
    ///
    /// - Parameters:
    ///   - transform: A function capable of transforming the receiver's values to type `R`
    ///
    /// - Returns: A `Gen` generator of values of type `R`
    public func map<R>(_ transform: @escaping (T) -> R) -> AnyGenerator<R> {
        Map(source: self, transform: transform).eraseToAnyGenerator()
    }
}

// MARK: - Map

private struct Map<Source, T>: Generator where Source: Generator {
    let source: Source
    let transform: (Source.T) -> T

    public func next(_ randomSource: RandomSource) -> T {
        transform(source.next(randomSource))
    }
}
