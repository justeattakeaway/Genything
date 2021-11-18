import Foundation

// MARK: Combine

public extension Gen {
    /// Returns: A new generator which produces strings by concatenating the elements of the generator sequence, adding the given separator between each generated element.
    ///
    /// - Parameters:
    ///    - generators: The generator which will be joined together to form a string
    ///    - separator: A string to insert between each of the elements in this sequence. The default separator is an empty string
    ///
    /// - Returns: The generator
    static func join(_ generators: [Gen<String>], separator: String = "") -> Gen<String> {
        Gen<String>
            .collect(generators)
            .map { $0.joined(separator: separator) }
    }
}
