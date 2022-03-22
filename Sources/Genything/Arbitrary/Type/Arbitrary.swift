import Foundation

/// A type conforming to the Arbitrary protocol can be used to generate arbitrary (random) values
public protocol Arbitrary {
    /// Returns a generator capable of randomly generating every possible value for the conforming type
    static var arbitrary: AnyGenerator<Self> { get }
}
