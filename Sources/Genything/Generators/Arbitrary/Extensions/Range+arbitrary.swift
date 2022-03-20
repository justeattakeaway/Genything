public extension Range where Bound: RandomInRangeable {
    var arbitrary: AnyGenerator<Bound> {
        assert(!isEmpty, "`arbitrary` was invoked on an empty range")
        return AnyGenerator { context in
            Bound.random(in: self, using: &context.rng)
        }
    }
}

public extension ClosedRange where Bound: RandomInRangeable {
    var arbitrary: AnyGenerator<Bound> {
        assert(!isEmpty, "`arbitrary` was invoked on an empty range")
        return AnyGenerator { context in
            Bound.random(in: self, using: &context.rng)
        }
    }
}
