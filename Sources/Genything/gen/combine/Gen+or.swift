import Foundation

// MARK: Combine

public extension Gen {
    /// Returns: A generator which randomly selects values from either the receiver or the `other` generator
    ///
    /// - Parameters:
    ///    - other: Another generator which may get selected to produce values
    ///    - otherProbability: The probability that the the right generator will be selected from
    ///
    /// - Returns: The generator
    func or(_ other: Gen<T>, otherProbability: Double = 0.5) -> Gen<T> {
        let probabilityRange = 0.0...1.0
        assert(
            probabilityRange.contains(otherProbability),
            "A probability between 0.0 and 1.0 must be specified. Found: \(otherProbability)"
        )

        return Gen<Double>.from(probabilityRange).flatMap {
            if $0 <= otherProbability {
                return other
            } else {
                return self
            }
        }
    }
}
