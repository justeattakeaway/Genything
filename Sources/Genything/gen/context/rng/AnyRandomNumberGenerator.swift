import Foundation

/// A Type Erased `RandomNumberGenerator`
public struct AnyRandomNumberGenerator: RandomNumberGenerator {
    var rng: RandomNumberGenerator
    public mutating func next() -> UInt64 {
        return rng.next()
    }
}
