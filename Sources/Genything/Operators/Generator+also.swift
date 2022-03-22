extension Generator {
    /// Invokes the provided closure for each value produced by the receiver in order to perform intermediary actions or side-effects
    ///
    /// - Returns: A generator which which produces identical values to the receiver
    public func also(_ run: @escaping (T) -> Void) -> AnyGenerator<T> {
        AnyGenerator { ctx in
            let value = next(ctx)
            run(value)
            return value
        }
    }
}
