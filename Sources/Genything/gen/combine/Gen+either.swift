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
    static func either<T, G1: Generatable, G2: Generatable>(left: G1, right: G2, rightProbability: Double = 0.5) -> Generatables.Either<T> where G1.T == T, G2.T == T {
        Generatables.Either(primarySource: left.start(), otherSource: right.start(), probability: rightProbability)
    }
}

extension Generatables {
    public struct Either<T>: Generatable {
        internal init(startPrimary: () -> Gen<T>, startOther: () -> Gen<T>, probability: Double) {
            self.startPrimary = primarySource
            self.startOther = otherSource
            self.probability = probability

            assert(
                probabilityRange.contains(probability),
                "A probability between 0.0 and 1.0 must be specified. Found: \(probability)"
            )
        }

        let startPrimary: () -> Gen<T>
        let startOther: () -> Gen<T>
        let probability: Double
        let probabilityRange: ClosedRange<Double> = 0.0...1.0

        public func start() -> Gen<T> {
            Gen
                .from(probabilityRange)
                .flatMap { value -> Gen<T> in
                    if value <= probability {
                        return otherSource
                    } else {
                        return primarySource
                    }
                }
                .start()
        }
    }
}
