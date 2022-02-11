import Foundation

// MARK: Build

public extension Gen {
    /// Returns: A generator which produces the result of shuffling the provided list
    ///
    /// - Warning: The values list must not be empty

    /// - Parameter values: The values which this generator will shuffle
    ///
    /// - Returns: The generator
    static func shuffled(_ values: [T]) -> Gen<[T]> {
        assert(!values.isEmpty, "`Gen.shuffled(values:)` was invoked with an empty list of values")

        return Gen<[T]> { ctx in
            values.shuffled(using: &ctx.rng)
        }
    }
}
