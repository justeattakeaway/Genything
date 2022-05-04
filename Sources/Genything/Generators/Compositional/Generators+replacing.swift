// MARK: Combine

extension Generators {
    /// Returns: A generator of strings which modify the `source` by replacing all occurence of `replace` strings by their associated generator
    ///
    /// - Parameters:
    ///   - source: The source or template `String` that will be modified
    ///   - generators: Tuple of substring to replace with associated generator
    ///
    /// - Returns: The `String` generator
    public static func replacing<G>(_ source: String, with generators: [(replace: String, by: G)]) -> AnyGenerator<String>
        where G: Generator, G.T == String {
        AnyGenerator { ctx in
            var result = source

            generators.forEach { substring, gen in
                result = result.replacingOccurences(of: substring) {
                    gen.next(ctx)
                }
            }

            return result
        }
    }
}
