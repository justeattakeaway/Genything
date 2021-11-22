import Foundation

// MARK: Mutate

public extension Gen {
    /// Returns: A generator that wraps the receivers' values in an optional
    ///
    /// - Parameters:
    ///   - nilProbability: The probability that the optional will be `nil`
    ///
    /// - Returns: A `Gen` generator
    func orNil(nilProbability: Double = 0.5) -> Gen<T?> {
        let some = map { a -> T? in a } // Wrap A in Optional
        return .either(left: some, right: .constant(nil), rightProbability: nilProbability)
        
    }
}
