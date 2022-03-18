import Foundation

// MARK: Build

public extension Generators {
    /// Returns: A generator which produces the result of shuffling the provided list
    ///
    /// - Warning: The values list must not be empty
    ///
    /// - Parameter values: The values which this generator will shuffle
    ///
    /// - Returns: The generator
    static func shuffled<T>(_ values: [T]) -> AnyGenerator<[T]> {
        assert(!values.isEmpty, "`Gen.shuffled(values:)` was invoked with an empty list of values")

        return AnyGenerator<[T]> { ctx in
            values.shuffled(using: &ctx.rng)
        }
    }
}
