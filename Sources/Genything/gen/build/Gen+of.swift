import Foundation

// MARK: Build

public extension Gen {
    /// Returns: A generator which randomly produces values form the provided list
    ///
    /// - Warning: The values list must not be empty
    ///
    /// - Parameter values: The values which this generator will randomly select from
    ///
    /// - Returns: The generator
    static func of(_ values: [T]) -> AnyGeneratable<T> {
        assert(!values.isEmpty, "`Gen.of(values:)` was invoked with an empty list of values")

        return Gen<T> {
            values.randomElement(using: &$0.rng)!
        }.eraseToAnyGeneratable()
    }
}
