extension Range where Bound: RandomInRangeable {
    /// Returns: A generator which produces arbitrary elements in the receiver's space of possibile values
    ///
    /// - Precondition: The range must not be empty.
    /// - Returns: A generator of arbitrary elements from this range.
    public var arbitrary: AnyGenerator<Bound> {
        RandomInRange(self).eraseToAnyGenerator()
    }
}

extension ClosedRange where Bound: RandomInRangeable {
    /// Returns: A generator which produces arbitrary elements in the receiver's space of possibile values
    ///
    /// - Precondition: The range must not be empty.
    /// - Returns: A generator of arbitrary elements from this range.
    public var arbitrary: AnyGenerator<Bound> {
        RandomInClosedRange(self).eraseToAnyGenerator()
    }
}

private struct RandomInRange<T>: Generator where T: RandomInRangeable {
    let range: Range<T>
    init(_ range: Range<T>) {
        assert(!range.isEmpty, "`arbitrary` was invoked on an empty range")
        self.range = range
    }

    public func next(_ randomSource: RandomSource) -> T {
        T.random(in: range, using: &randomSource.rng)
    }
}

private struct RandomInClosedRange<T>: Generator where T: RandomInRangeable {
    let range: ClosedRange<T>
    init(_ range: ClosedRange<T>) {
        assert(!range.isEmpty, "`arbitrary` was invoked on an empty range")
        self.range = range
    }

    public func next(_ randomSource: RandomSource) -> T {
        T.random(in: range, using: &randomSource.rng)
    }
}
