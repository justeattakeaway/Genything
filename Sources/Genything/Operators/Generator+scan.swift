extension Generator {
    /// Returns: A generator that transforms the receivers' values by providing the current element to a closure along with the last value produced by the resulting Generator.
    ///
    /// - Warning: The resulting generator will become stateful
    ///
    /// - Parameters:
    ///   - initialResult: The first value to combine and transform with the receiver's values.
    ///   - nextPartialResult: A closure which transforms the receiver's current value and the last value produced by the resulting generator.
    func scan<R>(_ initialResult: R, _ nextPartialResult: @escaping (R, T) -> R) -> AnyGenerator<R> {
        Scan(source: self, initialResult: initialResult, nextPartialResult: nextPartialResult)
            .eraseToAnyGenerator()
    }
}

// MARK: - Scan

private final class Scan<Source, R>: Generator where Source: Generator {

    // MARK: Lifecycle

    init(
        source: Source,
        initialResult: R,
        nextPartialResult: @escaping (R, Source.T) -> R
    ) {
        self.source = source
        self.initialResult = initialResult
        self.nextPartialResult = nextPartialResult
    }

    // MARK: Public

    public func next(_ randomSource: RandomSource) -> R {
        let nextResult = nextPartialResult(previousResult, source.next(randomSource))
        previousResult = nextResult
        return nextResult
    }

    // MARK: Internal

    typealias T = R

    let source: Source
    let initialResult: R
    let nextPartialResult: (R, Source.T) -> R

    lazy var previousResult = initialResult

}