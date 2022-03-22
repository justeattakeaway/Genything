import Foundation

// MARK: Combine

extension Generator {
    /// Returns: A generator which randomly selects values from either the receiver or the `other` generator
    ///
    /// - Parameters:
    ///    - other: Another generator which may get selected to produce values
    ///    - otherProbability: The probability that the the right generator will be selected from
    ///
    /// - Returns: The generator
    public func or<Other>(_ other: Other, otherProbability: Double = 0.5) -> AnyGenerator<T> where Other: Generator,
        Other.T == Self.T {
        Generators.either(left: self, right: other, rightProbability: otherProbability)
    }
}
