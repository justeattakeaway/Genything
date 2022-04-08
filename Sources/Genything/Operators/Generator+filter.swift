extension Generator {
    /// Returns: A generator that only produces values which pass the test `isIncluded`
    ///
    /// - Warning: If the filtered condition is rare enough this function will become infinitely complex and will run forever
    /// e.g. `Int.arbitrary.filter { $0 == 999 }` has a `$1/Int.max$` probability of occuring and will be nearly infinite
    ///
    /// - Parameters:
    ///   - isIncluded: A function which returns true if the value should be included
    ///
    /// - Returns: A `Gen` generator.
    func filter(_ isIncluded: @escaping (T) -> Bool) -> AnyGenerator<T> {
        Filter(source: self, isIncluded: isIncluded).eraseToAnyGenerator()
    }
}

// MARK: - Filter

private struct Filter<Source>: Generator where Source: Generator {
    let source: Source
    let isIncluded: (Source.T) -> Bool

    public func next(_ randomSource: RandomSource) -> Source.T {
        while(true) {
            let candidate = source.next(randomSource)
            if isIncluded(candidate) {
                return candidate
            }
        }
    }
}

