extension Generator {
    /// Returns: A generator which iterates the elements of `sequence`. When exhausted the generator will switch to producing values from the receiving generator.
    ///
    /// - Warning: The resulting generator accumulates state. Shared access of the same instance may have unintended effects. Be careful not to expose this generator as a singleton. When sharing the definition use a computed variable, a function, or wrap it with a `LazyGenerator` so that different generator instanced are always created on access.
    ///
    /// - Parameters:
    ///    - values: Array of values which will be produced in order before the receiver takes over
    ///
    /// - Returns: The generator
    public func startWith<S: Sequence>(_ sequence: S) -> AnyGenerator<T> where S.Element == T {
        SwitchOnNil(start: Generators.iterate(sequence), end: self).eraseToAnyGenerator()
    }
}

// MARK: - NilSwitch

final class SwitchOnNil<StartSource, EndSource>: Generator where StartSource: Generator, EndSource: Generator,
    StartSource.T == EndSource.T? {

    /// Creates a Generators for a sequence of elements.
    ///
    /// - Parameter sequence: The sequence of elements to generate.
    public init(start: StartSource, end: EndSource) {
        self.start = start
        self.end = end
    }

    public func next(_ randomSource: RandomSource) -> EndSource.T {
        if switched {
            return end.next(randomSource)
        }

        if let candidate = start.next(randomSource) {
            return candidate
        } else {
            switched = true
            return next(randomSource)
        }
    }

    private(set) var switched = false

    private let start: StartSource
    private let end: EndSource
}
