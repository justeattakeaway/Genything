extension Generators {
    /// Returns: A generator which produces the result of shuffling the provided list
    ///
    /// - Precondition: Values may not be empty.
    /// - Parameter values: The (non-empty) values which this generator will shuffle
    /// - Returns: The generator
    public static func shuffled<T>(_ values: [T]) -> AnyGenerator<[T]> {
        Shuffled(values).eraseToAnyGenerator()
    }

    /// Returns: A generator which produces the result of shuffling the provided list
    ///
    /// - Precondition: Values may not be empty.
    /// - Parameter values: The (non-empty) values which this generator will shuffle
    /// - Returns: The generator
    public static func shuffled<T>(_ values: T...) -> AnyGenerator<[T]> {
        shuffled(values)
    }
}

// MARK: - Shuffled

private struct Shuffled<T>: Generator {
    let values: [T]

    init(_ values: [T]) {
        assert(!values.isEmpty, "`Gen.shuffled(values:)` was invoked with an empty list of values")
        self.values = values
    }

    func next(_ randomSource: RandomSource) -> [T] {
        values.shuffled(using: &randomSource.rng)
    }
}
