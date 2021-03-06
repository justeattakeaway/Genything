extension Generator {

    /// Returns: A generator that for each iteration repeatedly generates values until a suitable match can be found
    ///
    /// - Warning: If the filtered condition is rare enough this function will become infinitely complex and will run forever
    /// e.g. `Int.arbitrary.filter { $0 == 999 }` has a `$1/Int.max$` probability of occuring and will be nearly infinite
    ///
    /// - Parameters:
    ///   - isIncluded: A function which returns true if the value should be included
    ///
    /// - Returns: A generator that for each iteration repeatedly generates values until a suitable match can be found
    public func filter(_ isIncluded: @escaping (T) -> Bool) -> AnyGenerator<T> {
        Generators.Filter(source: self, isIncluded: isIncluded).eraseToAnyGenerator()
    }

}

extension Generators {
    struct Filter<Source>: Generator where Source: Generator {
        let source: Source
        let isIncluded: (Source.T) -> Bool

        public func next(_ randomSource: RandomSource) -> Source.T {
            while true {
                let candidate = source.next(randomSource)
                if isIncluded(candidate) {
                    return candidate
                }
            }
        }
    }
}
