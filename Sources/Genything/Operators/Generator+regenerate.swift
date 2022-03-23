extension Generator {
    /// Apply additional changes to an already created element on the receiving generator
    ///
    /// - Attention: This generate block is executed for each generated value, only truly arbitrary generators should be created in this block. If a generator which relies on it's own state is created in this block it will be recreated for each generated value. If a stateful generator is desired to be used you must hold the reference outside the block.
    ///
    /// - Parameters:
    ///   - generate: A block which provides the previously generated value as an inout parameter, allowing you to make changes to the properties contained within if they are variable. To do so the random source is also provided as the second argument.
    ///
    /// - Returns: A generator which produces modified values of type `T`
    public func regenerate(_ generate: @escaping (inout T, RandomSource) -> Void) -> AnyGenerator<T> {
        AnyGenerator { randomSource in
            var next = next(randomSource)
            generate(&next, randomSource)
            return next
        }
    }
}
