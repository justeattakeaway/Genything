import Foundation

// MARK: Combine

public extension Gen {
    /// Returns: A generator which randomly selects values from either the receiver or the edge cases
    ///
    /// - Note: The probability is determined by `Context.edgeCaseProbability`
    /// - Parameter edgeCases: An array of edgecases
    /// - Returns: The generator
    func withEdgeCases(_ edgeCases: [T]) -> AnyGeneratable<T> {
        withEdgeCases(Gen.of(edgeCases))
    }

    /// Returns: A generator which randomly selects values from either the receiver or the edge cases
    ///
    /// - Note: The probability is determined by `Context.edgeCaseProbability`
    /// - Parameter edgeCases: Another generator which may get selected to produce values
    /// - Returns: The generator
    func withEdgeCases<G: Generatable>(_ edgeCases: G) -> G where G.T == T {
        Gen<T> { ctx in
            or(edgeCases, otherProbability: ctx.edgeCaseProbability)
                .generate(context: ctx)
        }.eraseToAnyGeneratable()
    }
}


