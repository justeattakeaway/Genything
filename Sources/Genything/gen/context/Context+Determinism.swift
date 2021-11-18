import Foundation

/// The `Determinism` affects the relative randomness of value generation
public enum Determinism {
    /// A random `Determinism` seeded by `seed`
    /// Subsequent runs using the same `Context` are guaranteed to produce values in the same order
    case predetermined(seed: Int)

    // TODO: Create a mechanism to log `originalSeed` to allow for replay using .predetermined.

    /// A random `Determinism` seeded by a random value
    /// Subsequent runs using the same `Context` will generate completely different random values
    case random
}

public extension Context {
    /// Initializes a `Context` with a `Determinism`
    convenience init(determinism: Determinism) {
        switch determinism {
            case let .predetermined(seed):
                self.init(using: LCRNG(seed: seed), originalSeed: seed)
            case .random:
                let seed = Int(arc4random())
                self.init(using: LCRNG(seed: seed), originalSeed: seed)
        }
    }
}
