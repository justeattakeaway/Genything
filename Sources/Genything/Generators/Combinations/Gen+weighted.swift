import Foundation

// MARK: Build

public extension Generators {

    /// Alias pairing a weighted probability to a generator
    typealias WeightedGenerator<T> = (weight: Int, generator: AnyGenerator<T>)

    /// Returns: A generator which produces values from the provided generators according to their weights
    ///
    /// The probability of choosing a weighted generator is equal to the generator's weight divided by the total weight
    ///
    /// - Parameter weights: Pairing of generators with their weights
    ///
    /// - Returns: The generator
    static func weighted<T>(_ weights: [WeightedGenerator<T>]) -> AnyGenerator<T> {
        assert(weights.allSatisfy { $0.weight > 0 }, "`Gen.weighted(weights:)` called with impossible weights. Ratios must be one or greater.")

        let total = weights.map { $0.weight }.reduce(0, +)
        return Generators.from(0..<total).flatMap { roll -> AnyGenerator<T> in
            var currWeight = 0
            return weights.first { (weight, _) in
                currWeight += weight
                return roll < currWeight
            }!.generator
        }
    }

    /// Returns: A generator which produces values from the provided constant values according to their weights
    ///
    /// The probability of choosing a weighted value is equal to the value's weight divided by the total weight
    ///
    /// - SeeAlso: `weighted(weights:)`
    ///
    /// - Parameter weights: Pairing of generators with their weights
    ///
    /// - Returns: The generator
    static func weighted<T>(_ weights: [(Int, T)]) -> AnyGenerator<T> {
        weighted(
            weights.map { (weight, value) in
                (weight, Generators.Constant(value).eraseToAnyGenerator())
            }
        )
    }
}
