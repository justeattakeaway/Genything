import Foundation

/// Replaces instances of `target` in the receiver `String` by the response of the callback `replacement`
///
/// - Parameters:
///   - target: The substring that should be replaced
///   - replacement: A callback which returns the value to use for replacement
///
/// - Returns: A `String` with all instances of `target` replaced by the `replacement`
private extension String {
    func replacingOccurences(of target: String, _ replacement: @escaping () -> String) -> String {
        var result = self

        while let rangeToReplace = result.range(of: target) {
            result = result.replacingCharacters(in: rangeToReplace, with: replacement())
        }

        return result
    }
}

public extension Gen {
    /// Returns: A generator of strings which replace `character` in `source` by the content of the receiver's generator
    ///
    /// The receiver's contents will be coerced by interpolation to type `String`
    ///
    /// - Parameters:
    ///   - substring: The substring that should be replaced
    ///   - source: The source or template `String` that will be modified
    ///
    /// - Returns: The `String` generator
    func replacingOccurrences(of substring: String, in source: String) -> Gen<String> {
        Gen<String> { ctx in
            source.replacingOccurences(of: substring) {
                "\(generate(context: ctx))"
            }
        }
    }

    /// Returns: A generator of strings which modify the `source` by replacing all occurence of `replace` strings by their associated generator
    ///
    /// - Parameters:
    ///   - source: The source or template `String` that will be modified
    ///   - generators: Tuple of substring to replace with associated generator
    ///
    /// - Returns: The `String` generator
    static func replacing(_ source: String, with generators: [(replace: String, by: Gen<String>)]) -> Gen<String> {
        Gen<String> { ctx in
            var result = source

            generators.forEach { (substring, gen) in
                result = result.replacingOccurences(of: substring) {
                    gen.generate(context: ctx)
                }
            }

            return result
        }
    }
}
