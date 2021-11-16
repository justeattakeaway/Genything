import Foundation

public extension Gen {
    /// Returns: A generator of strings which replace `character` in `source` by the content of the receiver's generator
    ///
    /// The receiver's contents will be coerced by interpolation to type `String`
    ///
    /// - Parameters:
    ///   - character: The character that should be replaced
    ///   - source: The source or template `String` that will be modified
    ///
    /// - Returns: The `String` generator
    func replacingOccurrences(of character: Character, in source: String) -> Gen<String> {
        Gen<String> { ctx in
            var result: String = ""

            for ch in source {
                if ch == character {
                    result += "\(generate(context: ctx))"
                } else {
                    result.append(ch)
                }
            }

            return result
        }
    }
}
