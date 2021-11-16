import Foundation

public extension Gen {
    /**
     * Returns a new generator which produces strings by concatenating the elements of the generator sequence, adding the given separator between each generated element.
     */
    static func join(_ generators: [Gen<String>], separator: String = "") -> Gen<String> {
        Gen<String>
            .traverse(generators)
            .map { $0.joined(separator: separator) }
    }
}
