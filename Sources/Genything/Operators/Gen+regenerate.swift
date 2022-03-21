public extension Generator {
    func regenerate(_ generate: @escaping (inout T, RandomSource) -> Void) -> AnyGenerator<T> {
        AnyGenerator { randomSource in
            var next = next(randomSource)
            generate(&next, randomSource)
            return next
        }
    }
}
