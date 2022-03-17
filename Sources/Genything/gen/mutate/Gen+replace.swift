// MARK: Mutate

public extension Gen {
    /// Returns: A generator that replaces the receivers' nil values with the replacement
    ///
    /// - Parameters:
    ///   - replacement: A replacement for nil values of the unwrapped type
    func replaceNil<R>(with replacement: R) -> Gen<R> where T == R? {
        Gen<R> { ctx -> R in
            generate(context: ctx) ?? replacement
        }
    }
}
