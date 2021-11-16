import Foundation

public enum Determinism {
    // Determistic random seeded by a provided value. Two Random Contexts with the same seed will always create random values in the same order.
    case predetermined(seed: Int)
    // Randomly seeded Linear Congruent pseudo-random
    // TODO: Create a mechanism to log `originalSeed` to allow for replay using .predetermined.
    case deterministic
    // Total randomness. No support for replay.
    case random
}

public extension Context {
    convenience init(determinism: Determinism) {
        switch determinism {
            case let .predetermined(seed):
                self.init(using: LCRNG(seed: seed), originalSeed: seed)
            case .deterministic:
                let seed = Int(arc4random())
                self.init(using: LCRNG(seed: seed), originalSeed: seed)
            case .random:
                self.init(using: SystemRandomNumberGenerator(), originalSeed: nil)
        }
    }
}
