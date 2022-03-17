// MARK: Combine

public extension Generator {
    /// Returns: A generator which iterates the elements of `sequence`. When exhausted the generator will switch to producing values from the receiving generator.
    ///
    /// - Parameters:
    ///    - values: Array of values which will be produced in order before the receiver takes over
    ///
    /// - Returns: The generator
    func startWith<S: Swift.Sequence>(_ sequence: S) -> AnyGenerator<T> where S.Element == T {
        Generators.Iterate(sequence).switchUnwrap(eraseToAnyGenerator())
    }
}
