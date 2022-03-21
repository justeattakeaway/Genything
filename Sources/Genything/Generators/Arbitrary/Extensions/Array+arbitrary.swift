//public extension Array {
//    var arbitrary: AnyGenerator<Element> {
//        assert(!isEmpty, "`arbitrary` was invoked on an empty array")
//        return AnyGenerator { randomSource in
//            randomElement(using: &randomSource.rng)!
//        }
//    }
//}

public extension Collection {
    var arbitrary: AnyGenerator<Element> {
        assert(!isEmpty, "`arbitrary` was invoked on an empty collection")
        return AnyGenerator { randomSource in
            randomElement(using: &randomSource.rng)!
        }
    }
}
