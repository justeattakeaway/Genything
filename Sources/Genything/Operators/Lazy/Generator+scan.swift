extension Generator {
    /// Returns: A generator that transforms the receivers' values by providing the current element to a closure along with the last value produced by the resulting Generator.
    ///
    /// - Warning: The resulting generator will begin to accumulate state. It has been lifted to a `DeferredGenerator` to make this abundantly clear. When sharing the resulting generator share it with it's wrapped `DeferredGenerator` type and only `start()` the generator when you are prepared to store the stateful reference.
    ///
    /// - Parameters:
    ///   - initialResult: The first value to combine and transform with the receiver's values.
    ///   - nextPartialResult: A closure which transforms the receiver's current value and the last value produced by the resulting generator.
    func scan<R>(_ initialResult: R, _ nextPartialResult: @escaping (R, T) -> R) -> LazyGenerator<AnyGenerator<R>> {
        LazyGenerator {
            Scan(source: self, initialResult: initialResult, nextPartialResult: nextPartialResult)
                .eraseToAnyGenerator()
        }
    }
}

// MARK: - Scan

private final class Scan<Source, R>: Generator where Source: Generator {

    init(
        source: Source,
        initialResult: R,
        nextPartialResult: @escaping (R, Source.T) -> R
    ) {
        self.source = source
        self.initialResult = initialResult
        self.nextPartialResult = nextPartialResult
    }

    public func next(_ randomSource: RandomSource) -> R {
        let nextResult = nextPartialResult(previousResult, source.next(randomSource))
        previousResult = nextResult
        return nextResult
    }

    typealias T = R

    let source: Source
    let initialResult: R
    let nextPartialResult: (R, Source.T) -> R

    lazy var previousResult = initialResult

}
