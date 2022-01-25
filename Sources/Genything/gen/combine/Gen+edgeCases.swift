import Foundation

// MARK: Combine

public extension Gen {
    /// Returns: A generator which randomly selects values from either the receiver or the edge cases
    ///
    /// - Note: The probability is determined by `Context.edgeCaseProbability`
    ///
    /// - Parameters:
    ///    - edgeCases: An array of edgecases
    ///
    /// - Returns: The generator
    func withEdgeCases(_ edgeCases: [T]) -> Gen<T> {
        Gen<T>.inContext { ctx in
            self.or(Gen.of(edgeCases), otherProbability: ctx.edgeCaseProbability)
        }
    }

    /// Returns: A generator which randomly selects values from either the receiver or the edge cases
    ///
    /// - Note: The probability is determined by `Context.edgeCaseProbability`
    ///
    /// - Parameters:
    ///    - edgeCases: Another generator which may get selected to produce values
    ///
    /// - Returns: The generator
    func withEdgeCases(_ edgeCases: Gen<T>) -> Gen<T> {
        Gen<T>.inContext { ctx in
            self.or(edgeCases, otherProbability: ctx.edgeCaseProbability)
        }
    }
}
