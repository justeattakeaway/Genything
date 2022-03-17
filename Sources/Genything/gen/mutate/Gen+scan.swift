// MARK: Mutate

public extension Gen {
    /// Returns: A generator that transforms the receivers' values by providing the current element to a closure along with the last value produced by the resulting Generator.
    ///
    /// - Parameters:
    ///   - initialResult: The first value to combine and transform with the receiver's values.
    ///   - nextPartialResult: A closure which transforms the receiver's current value and the last value produced by the resulting generator.
    func scan<Result>(_ initialResult: Result, _ nextPartialResult: @escaping (Result, T) -> Result) -> Gen<Result> {
        var last = initialResult
        return Gen<Result> { ctx in
            let next = nextPartialResult(last, generate(context: ctx))
            last = next
            return next
        }
    }
}
