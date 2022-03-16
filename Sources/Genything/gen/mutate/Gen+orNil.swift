import Foundation

// MARK: Mutate

public extension Generatable {
    /// Returns: A generator that wraps the receivers' values in an optional
    ///
    /// - Parameters:
    ///   - nilProbability: The probability that the optional will be `nil`
    ///
    /// - Returns: A `Gen` generator
    func orNil(nilProbability: Double = 0.5) -> AnyGeneratable<T?> {
        Generatables.Either(map { a -> T? in a },
                            Generatables.Constant(nil),
                            probability: nilProbability)
        .eraseToAnyGeneratable()
    }
}
