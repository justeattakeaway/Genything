extension Generator {
    /// Discards the specified generations of elements before elements can be produced.
    ///
    /// - Warning: The resulting generator is stateful. Sharing the same reference may not lead to a expected result.
    ///
    /// - Attention: The generator will still have to internally generate the values. If you only need to advance the RandomSource you may use ``RandomSource/dropFirst(_:)``
    ///
    /// - Precondition: The provided `count` should be positive
    ///
    /// - Returns: A generator that begins to generate values after the provided generation count
    public func dropFirst(_ count: Int = 1) -> AnyGenerator<T> {
        assert(count >= 0, "`dropFirst(count:)` called with a negative count")
        
        return Generators.Drop(source: self, count: count).eraseToAnyGenerator()
    }
}

extension Generators {
    final class Drop<Source>: Generator where Source: Generator {
        init(source: Source, count: Int) {
            self.source = source
            self.count = count
        }

        func next(_ randomSource: RandomSource) -> Source.T {
            if isFirst {
                for _ in 0 ..< count {
                    _ = source.next(randomSource)
                }
                isFirst = false
            }
            return source.next(randomSource)
        }

        private var isFirst = true
        
        let source: Source
        let count: Int
    }
}
