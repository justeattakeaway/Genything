public extension Generator {
    func regenerate(_ generate: @escaping (inout T, Context) -> Void) -> AnyGenerator<T> {
        AnyGenerator { context in
            var next = next(context)
            generate(&next, context)
            return next
        }
    }
}
