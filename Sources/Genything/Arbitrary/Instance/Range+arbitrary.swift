extension Range where Bound: RandomInRangeable {
    /// Returns: A generator which produces arbitrary elements in the receiver's space of possibile values
    ///
    /// - Precondition: The range must not be empty.
    /// - Returns: A generator of arbitrary elements from this range.
    public var arbitrary: AnyGenerator<Bound> {
        assert(!isEmpty, "`arbitrary` was invoked on an empty range")
        return AnyGenerator { randomSource in
            Bound.random(in: self, using: &randomSource.rng)
        }
    }
}

extension ClosedRange where Bound: RandomInRangeable {
    /// Returns: A generator which produces arbitrary elements in the receiver's space of possibile values
    ///
    /// - Precondition: The range must not be empty.
    /// - Returns: A generator of arbitrary elements from this range.
    public var arbitrary: AnyGenerator<Bound> {
        assert(!isEmpty, "`arbitrary` was invoked on an empty range")
        return AnyGenerator { randomSource in
            Bound.random(in: self, using: &randomSource.rng)
        }
    }
}
