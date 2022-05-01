extension Generator {
    /// Returns: A generator that transforms the receivers' values by providing the current element to a closure along with the last value produced by the resulting Generator.
    ///
    /// - Warning: The resulting generator accumulates state. Shared access of the same instance may have unintended effects. Be careful not to expose this generator as a singleton. When sharing the definition use a computed variable, a function, or wrap it with a `LazyGenerator` so that different generator instanced are always created on access.
    ///
    /// - Parameters:
    ///   - initialResult: The first value to combine and transform with the receiver's values.
    ///   - nextPartialResult: A closure which transforms the receiver's current value and the last value produced by the resulting generator.
    public func scan<R>(_ initialResult: R, _ nextPartialResult: @escaping (R, T) -> R) -> AnyGenerator<R> {
        Generators.Scan(source: self, initialResult: initialResult, nextPartialResult: nextPartialResult)
            .eraseToAnyGenerator()
    }
}

extension Generators {
    final class Scan<Source, R>: Generator where Source: Generator {

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
}
