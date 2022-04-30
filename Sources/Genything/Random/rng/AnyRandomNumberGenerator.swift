import Foundation

/// A type-erased `RandomNumberGenerator`
public struct AnyRandomNumberGenerator: RandomNumberGenerator {
    var wrapped: RandomNumberGenerator
    public mutating func next() -> UInt64 {
        wrapped.next()
    }
}
