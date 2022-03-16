import Foundation

// MARK: Combine

public extension Generatable {
    /// Returns: A generator which randomly selects values from either the receiver or the `other` generator
    ///
    /// - Parameters:
    ///    - other: Another generator which may get selected to produce values
    ///    - otherProbability: The probability that the the right generator will be selected from
    ///
    /// - Returns: The generator
    func or(_ other: Gen<T>, otherProbability: Double = 0.5) -> Generatables.Either<T> {
        Generatables.Either(startPrimary: start, startOther: other.start, probability: otherProbability)
    }
}
