//public extension Array {
//    var arbitrary: AnyGenerator<Element> {
//        assert(!isEmpty, "`arbitrary` was invoked on an empty array")
//        return AnyGenerator { context in
//            randomElement(using: &context.rng)!
//        }
//    }
//}

public extension Collection {
    var arbitrary: AnyGenerator<Element> {
        assert(!isEmpty, "`arbitrary` was invoked on an empty collection")
        return AnyGenerator { context in
            randomElement(using: &context.rng)!
        }
    }
}
