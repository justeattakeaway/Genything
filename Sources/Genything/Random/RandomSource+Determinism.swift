import Foundation

// MARK: - Determinism

/// The `Determinism` affects the relative randomness of value generation
public enum Determinism {
    /// A random `Determinism` seeded by `seed`
    /// Subsequent runs using the same `RandomSource` are guaranteed to produce values in the same order
    case predetermined(seed: UInt64)

    /// A random `Determinism` seeded by a random value
    /// Subsequent runs using the same `RandomSource` will generate completely different random values
    case random
}

extension RandomSource {
    /// Initializes a `RandomSource` with a `Determinism`
    public convenience init(determinism: Determinism) {
        switch determinism {
            case .predetermined(let seed):
                self.init(using: LinearCongruentialRandomNumberGenerator(seed: seed), originalSeed: seed)
            case .random:
                let seed = UInt64(arc4random())
                self.init(using: LinearCongruentialRandomNumberGenerator(seed: seed), originalSeed: seed)
        }
    }
}
