extension Generator {
    public func recompose(_ compose: @escaping (inout T, Composer) -> Void) -> AnyGenerator<T> {
        AnyGenerator { randomSource in
            var next = next(randomSource)
            compose(&next, Composer(randomSource: randomSource))
            return next
        }
    }
}
