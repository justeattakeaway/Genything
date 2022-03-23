extension Generator {
    /// Apply additional changes to an already created element on the receiving generator
    ///
    /// - Attention: This composition block is executed for each generated value, only truly arbitrary generators should be created in this block. If a generator which relies on it's own state is created in this block it will be recreated for each generated value. If a stateful generator is desired to be used you must hold the reference outside the block.
    ///
    /// - Parameters:
    ///   - compose: A block which provides the previously generated value as an inout parameter, allowing you to make changes to the properties contained within if they are variable. To do so the composer is also provided as the second argument.
    ///
    /// - Returns: A generator which produces modified values of type `T`
    public func recompose(_ compose: @escaping (inout T, Composer) -> Void) -> AnyGenerator<T> {
        AnyGenerator { randomSource in
            var next = next(randomSource)
            compose(&next, Composer(randomSource: randomSource))
            return next
        }
    }
}
