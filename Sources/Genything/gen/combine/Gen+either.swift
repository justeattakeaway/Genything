import Foundation

// MARK: Combine

public extension Gen {
    /// Returns: A generator which randomly selects values from either the `left` or `right` generator
    ///
    /// - Parameters:
    ///    - left: A generator which may get selected to produce values
    ///    - right: A generator which may get selected to produce values
    ///    - rightProbability: The probability that the the right generator will be selected from
    ///
    /// - Returns: The generator
    static func either(left: Gen<T>, right: Gen<T>, rightProbability: Double = 0.5) -> Gen<T> {
        left.or(right, otherProbability: rightProbability)
    }
}
