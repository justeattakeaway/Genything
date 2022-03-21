public extension Range where Bound: RandomInRangeable {
    var arbitrary: AnyGenerator<Bound> {
        assert(!isEmpty, "`arbitrary` was invoked on an empty range")
        return AnyGenerator { randomSource in
            Bound.random(in: self, using: &randomSource.rng)
        }
    }
}

public extension ClosedRange where Bound: RandomInRangeable {
    var arbitrary: AnyGenerator<Bound> {
        assert(!isEmpty, "`arbitrary` was invoked on an empty range")
        return AnyGenerator { randomSource in
            Bound.random(in: self, using: &randomSource.rng)
        }
    }
}
