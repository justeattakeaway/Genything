public extension Gen {
    /// Invokes the provided closure for each value produced by the receiver in order to perform intermediary actions or side-effects
    ///
    /// - Returns: A generator which which produces identical values to the receiver
    func also(_ run: @escaping (T) throws -> Void) rethrows -> Gen<T> {
        Gen<T> { ctx in
            let value = generate(context: ctx)
            try run(value)
            return value
        }
    }
}
