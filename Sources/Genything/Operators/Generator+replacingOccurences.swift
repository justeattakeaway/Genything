extension Generator {
    /// Returns: A generator of strings which replace `character` in `source` by the content of the receiver's generator
    ///
    /// The receiver's contents will be coerced by interpolation to type `String`
    ///
    /// - Parameters:
    ///   - substring: The substring that should be replaced
    ///   - source: The source or template `String` that will be modified
    ///
    /// - Returns: The `String` generator
    public func replacingOccurrences(of substring: String, in source: String) -> AnyGenerator<String> {
        AnyGenerator { ctx in
            source.replacingOccurences(of: substring) {
                "\(next(ctx))"
            }
        }
    }
}
