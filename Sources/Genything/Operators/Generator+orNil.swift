import Foundation

// MARK: Mutate

extension Generator {
    /// Returns: A generator that wraps the receivers' values in an optional
    ///
    /// - Parameters:
    ///   - nilProbability: The probability that the optional will be `nil`
    ///
    /// - Returns: A `Gen` generator
    public func orNil(nilProbability: Double = 0.5) -> AnyGenerator<T?> {
        map { a -> T? in a }
            .or(Generators.constant(nil), otherProbability: nilProbability)
    }
}
