import Foundation

// MARK: Mutate

public extension Generator {
    /// Returns: A generator that only produces values which pass the test `isIncluded`
    ///
    /// - Warning: If the filtered condition is rare enough this function can become infinitely complex
    /// e.g. `Int.arbitrary.filter { $0 == 0 }` has a `$1/Int.max$` probability of occuring and will be nearly infinite
    ///
    /// - Parameters:
    ///   - isIncluded: A function which returns true if the value should be included
    ///
    /// - Returns: The filtered generator
    func filter(_ isIncluded: @escaping (T) -> Bool) -> AnyGenerator<T> {
        Filter(source: self, isIncluded: isIncluded).eraseToAnyGenerator()
    }
}

private struct Filter<Source>: Generator where Source: Generator {
    let source: Source
    let isIncluded: (Source.T) -> Bool

    public func next(_ context: Context) -> Source.T {
        while(true) {
            let value = source.next(context)
            if isIncluded(value) {
                return value
            }
        }
    }
}
