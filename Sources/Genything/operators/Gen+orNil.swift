import Foundation

// MARK: Mutate

public extension Generator {
    /// Returns: A generator that wraps the receivers' values in an optional
    ///
    /// - Parameters:
    ///   - nilProbability: The probability that the optional will be `nil`
    ///
    /// - Returns: A `Gen` generator
    func orNil(nilProbability: Double = 0.5) -> AnyGenerator<T?> {
        Generators.Either(map { a -> T? in a },
                            Generators.Constant(nil),
                            probability: nilProbability)
        .eraseToAnyGenerator()
    }
}
