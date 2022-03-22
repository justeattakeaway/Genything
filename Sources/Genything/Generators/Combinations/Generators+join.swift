import Foundation

// MARK: Combine

extension Generators {
    /// Returns: A new generator which produces strings by concatenating the elements of the generator collection, adding the given separator between each generated element.
    ///
    /// - Parameters:
    ///    - generators: The generator which will be joined together to form a string
    ///    - separator: A string to insert between each of the elements in this collection. The default separator is an empty string
    ///
    /// - Returns: The generator
    public static func join<G>(_ generators: [G], separator: String = "") -> AnyGenerator<String> where G: Generator,
        G.T == String {
        Generators
            .collect(generators)
            .map { $0.joined(separator: separator) }
    }
}
