import Foundation

// MARK: Build

public extension Gen {
    /// Returns: A generator which randomly produces values form the provided list
    ///
    /// - Parameter values: The values which this generator will randomly select from
    ///
    /// - Returns: The generator
    static func of(_ values: [T]) -> Gen<T> {
        Gen<T> {
            values.randomElement(using: &$0.rng)!
        }
    }
}
