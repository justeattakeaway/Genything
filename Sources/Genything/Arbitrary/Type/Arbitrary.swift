import Foundation

/// A type that conforms to the Arbitrary protocol can be used to randomly generate _any_ discrete value from the conforming type's range of possible values
public protocol Arbitrary {
    /// Returns a generator capable of randomly generating every possible value for the conforming type
    static var arbitrary: AnyGenerator<Self> { get }
}
