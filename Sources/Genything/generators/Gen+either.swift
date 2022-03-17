import Foundation

// MARK: Combine

public extension Generators {
    /// Returns: A generator which randomly selects values from either the `left` or `right` generator
    ///
    /// - Parameters:
    ///    - left: A generator which may get selected to produce values
    ///    - right: A generator which may get selected to produce values
    ///    - rightProbability: The probability that the the right generator will be selected from
    ///
    /// - Returns: The generator
    static func either<G1: Generator, G2: Generator>(left: G1, right: G2, rightProbability: Double = 0.5) -> Generators.Either<G1, G2> {
        Generators.Either(left, right, probability: rightProbability)
    }
}

extension Generators {
    public struct Either<A, B>: Generator where A: Generator, B: Generator, A.T == B.T {

        public let a: A
        public let b: B
        public let probability: Double

        private let probabilityRange: ClosedRange<Double> = 0.0...1.0

        public init(_ a: A, _ b: B, probability: Double = 0.5) {
            self.a = a
            self.b = b
            self.probability = probability
        }

        public func next(_ context: Context) -> A.T {
            let value = Double.random(in: probabilityRange, using: &context.rng)

            if value <= probability {
                return b.next(context)
            }

            return a.next(context)
        }
    }
}
