import Foundation

// MARK: Combine

extension Generators {
    /// Returns: A generator which randomly selects values from either the `left` or `right` generator
    ///
    /// - Parameters:
    ///    - left: A generator which may get selected to produce values
    ///    - right: A generator which may get selected to produce values
    ///    - rightProbability: The probability that the the right generator will be selected from
    ///
    /// - Returns: The generator
    public static func either<G1, G2>(left: G1, right: G2, rightProbability: Double = 0.5) -> AnyGenerator<G1.T>
        where G1: Generator, G2: Generator, G1.T == G2.T {
        Either(left, right, probability: rightProbability).eraseToAnyGenerator()
    }
}

// MARK: - Either

private struct Either<A, B>: Generator where A: Generator, B: Generator, A.T == B.T {

    public init(_ a: A, _ b: B, probability: Double = 0.5) {
        self.a = a
        self.b = b
        self.probability = probability
    }

    public let a: A
    public let b: B
    public let probability: Double

    public func next(_ randomSource: RandomSource) -> A.T {
        let value = Double.random(in: probabilityRange, using: &randomSource.rng)

        if value <= probability {
            return b.next(randomSource)
        }

        return a.next(randomSource)
    }

    private let probabilityRange: ClosedRange<Double> = 0.0 ... 1.0

}
