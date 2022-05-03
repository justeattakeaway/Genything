extension Generator {
    /// Prefixes the generator's output with the provided sequence.
    ///
    /// - Warning: The resulting generator is stateful. Sharing the same reference may not lead to a expected result.
    ///
    /// - Parameters:
    ///    - values: Array of values which will be produced in order before the receiver takes over
    ///
    /// - Returns: A generator that prefixes a sequence of elements prior to this generator's elements.
    public func prepend<S: Sequence>(_ sequence: S) -> AnyGenerator<T> where S.Element == T {
        Generators.SwitchOnNil(start: Generators.iterate(sequence), end: self).eraseToAnyGenerator()
    }
}
