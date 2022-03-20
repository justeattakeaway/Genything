import Foundation

// MARK: Build

public extension Generators {
    /// Returns: A generator which randomly produces values form the provided list
    ///
    /// - Warning: The values list must not be empty
    ///
    /// - Parameter values: The values which this generator will randomly select from
    ///
    /// - Returns: The generator
    static func of<T>(_ values: [T]) -> AnyGenerator<T> {
        values.arbitrary
    }
}