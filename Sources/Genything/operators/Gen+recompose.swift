public extension Generator {
    func recompose(_ compose: @escaping (inout T, Composer) -> Void) -> AnyGenerator<T> {
        AnyGenerator { context in
            var next = next(context)
            compose(&next, Composer(context: context))
            return next
        }
    }
}
