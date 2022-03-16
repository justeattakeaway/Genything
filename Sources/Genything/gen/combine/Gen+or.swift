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
    func or<B>(_ other: B, otherProbability: Double = 0.5) -> Generatables.Either<Self, B> where B: Generatable {
        Generatables.Either(self, other, probability: otherProbability)
    }
}
