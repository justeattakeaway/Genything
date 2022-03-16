import Foundation

// MARK: Mutate

public extension Generatable {
    /// Returns: A generator that wraps the receivers' values in an optional
    ///
    /// - Parameters:
    ///   - nilProbability: The probability that the optional will be `nil`
    ///
    /// - Returns: A `Gen` generator
    func orNil(nilProbability: Double = 0.5) -> Generatables.Either<Self, T?> {
        Generatables<T?>.either(left: map { a -> T? in a },
                       right: Gen<T?>.constant(nil),
                       rightProbability: nilProbability)
    }
}
