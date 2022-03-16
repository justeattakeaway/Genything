import Foundation

// MARK: Combine

public extension Generatables {
    /// Returns: A generator which randomly selects values from either the `left` or `right` generator
    ///
    /// - Parameters:
    ///    - left: A generator which may get selected to produce values
    ///    - right: A generator which may get selected to produce values
    ///    - rightProbability: The probability that the the right generator will be selected from
    ///
    /// - Returns: The generator
    static func either<G1: Generatable, G2: Generatable>(left: G1, right: G2, rightProbability: Double = 0.5) -> Generatables.Either<G1, G2> {
        Generatables.Either(left, right, probability: rightProbability)
    }
}

extension Generatables {
    public struct Either<A, B>: Generatable where A: Generatable, B: Generatable, A.T == B.T {

        public let a: A
        public let b: B
        public let probability: Double

        private let probabilityRange: ClosedRange<Double> = 0.0...1.0

        public init(_ a: A, _ b: B, probability: Double = 0.5) {
            self.a = a
            self.b = b
            self.probability = probability
        }

        public func start() -> Gen<A.T> {
            let aGen = a.start()
            let bGen = b.start()
            return Gen
                .from(probabilityRange)
                .flatMap { value -> Gen<T> in
                    if value <= probability {
                        return bGen
                    } else {
                        return aGen
                    }
                }
                .start()
        }
    }
}
