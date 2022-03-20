// MARK: Mutate

public extension Generator {
    /// Returns: A generator that replaces the receivers' nil values with the replacement
    ///
    /// - Parameters:
    ///   - replacement: A replacement for nil values of the unwrapped type
    func replaceNil<R>(with replacement: R) -> AnyGenerator<R> where T == R? {
        AnyGenerator { ctx in
            next(ctx) ?? replacement
        }
    }
}
