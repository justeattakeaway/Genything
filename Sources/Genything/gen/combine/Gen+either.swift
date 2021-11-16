import Foundation

public extension Gen {
    /**
     * Returns a generator which produces values from either left or right generators
     * Using `rightProbability` to control the probability of a right value occuring
     */
    static func either(left: Gen<T>, right: Gen<T>, rightProbability: Double = 0.5) -> Gen<T> {
        let probabilityRange = 0.0...1.0
        assert(
            probabilityRange.contains(rightProbability),
            "A probability between 0.0 and 1.0 must be specified. Found: \(rightProbability)"
        )

        return Gen<Double>.from(probabilityRange).flatMap {
            if $0 <= rightProbability {
                return right
            } else {
                return left
            }
        }
    }
}
