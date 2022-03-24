public struct RandomizedGenerator<G: Generator> {
    let wrapped: G
    let randomSource: RandomSource

    public init(_ wrapped: G, randomSource: RandomSource) {
        self.wrapped = wrapped
        self.randomSource = randomSource
    }

    public func next() -> G.T {
        wrapped.next(randomSource)
    }
}

extension Generator {
    public func randomize(with randomSource: RandomSource) -> RandomizedGenerator<Self> {
        RandomizedGenerator(self, randomSource: randomSource)
    }
}

extension RandomizedGenerator {
    /// Returns: A randomized generator that transforms it's wrapped generator
    ///
    /// - Parameters:
    ///   - transform: A function which transforms the wrapped generator
    public func map<R: Generator>(_ transform: @escaping (G) -> R) -> RandomizedGenerator<R> {
        RandomizedGenerator<R>(transform(wrapped), randomSource: randomSource)
    }
}

// MARK: Produce

extension RandomizedGenerator {
    /// Returns: A sequence of this generator's values which will produce `nil` after `size` iterations
    ///
    /// - Warning: The sequence (like all sequences) may be destructively consumed by iteration.
    ///     As a consequence, don't assume that multiple for-in loops will restart from the beginning.
    ///
    /// - SeeAlso: https://developer.apple.com/documentation/swift/sequence
    ///
    /// - Parameters:
    ///   - size: The amount of iterations before this sequence will begin to return `nil`
    ///   - randomSource: The RandomSource to be used for generation
    ///
    /// - Returns: The Sequence
    public func sequence(_ maxLength: Int) -> AnySequence<G.T> {
        AnySequence(sequence().prefix(maxLength))
    }

    /// Returns: A sequence of this generator's values which will produce infinite elements
    ///
    /// - Warning: The sequence (like all sequences) may be destructively consumed by iteration. As a consequence, don't assume that multiple for-in loops will restart from the same place. Even if you are re-seeding the random source.
    ///
    /// - SeeAlso: https://developer.apple.com/documentation/swift/sequence
    ///
    /// - Returns: The infinite sequence
    public func sequence() -> RandomizedGeneratorSequence<G> {
        RandomizedGeneratorSequence(self)
    }

    /// Returns: An array of values from the generator
    ///
    /// - Parameters:
    ///   - count: The amount of values to generate
    ///
    /// - Returns: An array of generated values
    public func take(_ count: Int) -> [G.T] {
        Array(sequence(count))
    }
}
