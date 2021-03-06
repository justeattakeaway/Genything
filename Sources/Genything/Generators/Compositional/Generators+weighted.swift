// MARK: Combine

extension Generators {
    /// Returns: A generator which produces values from the provided generators according to their weights
    ///
    /// The probability of choosing a weighted generator is equal to the generator's weight divided by the total weight
    ///
    /// - Precondition: All weights must be greater than zero
    /// - Parameter weights: Pairing of generators to their (positive) weights
    /// - Returns: The generator
    public static func weighted<T>(_ weights: [(weight: Int, generator: AnyGenerator<T>)]) -> AnyGenerator<T> {
        assert(
            weights.allSatisfy { $0.weight > 0 },
            "`Gen.weighted(weights:)` called with impossible weights. Ratios must be one or greater."
        )

        let total = weights
            .map { $0.weight }
            .reduce(0, +)

        return (0 ..< total).arbitrary.flatMap { roll -> AnyGenerator<T> in
            var currWeight = 0
            return weights.first { weight, _ in
                currWeight += weight
                return roll < currWeight
            }!.generator
        }
    }

    /// Returns: A generator which produces values from the provided constant values according to their weights
    ///
    /// The probability of choosing a weighted value is equal to the value's weight divided by the total weight
    ///
    /// - SeeAlso: ``weighted(_:)``
    ///
    /// - Parameter weights: Pairing of generators with their weights
    ///
    /// - Returns: The generator
    public static func weighted<T>(_ weights: [(Int, T)]) -> AnyGenerator<T> {
        weighted(weights.map { weight, value in
            (weight, Generators.constant(value).eraseToAnyGenerator())
        })
    }
}
