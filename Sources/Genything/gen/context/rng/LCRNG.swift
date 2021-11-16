import Foundation

/// https://en.wikipedia.org/wiki/Linear_congruential_generator
public struct LCRNG: RandomNumberGenerator {
    private var seed: UInt64

    public init(seed: Int) {
        self.seed = UInt64(truncatingIfNeeded: seed)
    }

    /// https://nuclear.llnl.gov/CNP/rng/rngman/node4.html
    /// The values of the multiplier are hardwired into the implementation and are known to produce a good random number list
    private let a: UInt64 = 2862933555777941757
    private let b: UInt64 = 3037000493

    public mutating func next() -> UInt64 {
        seed = a &* seed &+ b
        return seed
    }
}
