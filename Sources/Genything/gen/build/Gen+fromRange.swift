import Foundation

// MARK: Build

public extension Gen where T: RandomInRangeable {
    /// Returns: A generator which produces elements in the provided range
    ///
    /// - Parameter range: The range in which the generator will randomly select values
    ///
    /// - Returns: The generator
    static func from(_ range: Range<T>) -> Gen {
        assert(!range.isEmpty, "`Gen.from(range:)` was invoked with an empty interval")

        return Gen<T> {
            .random(in: range, using: &$0.rng)
        }
    }

    /// Returns: A generator which produces elements in the provided range
    ///
    /// - Parameter range: The range in which the generator will randomly select values
    ///
    /// - Returns: The generator
    static func from(_ range: ClosedRange<T>) -> Gen {
        assert(!range.isEmpty, "`Gen.from(range:)` was invoked with an empty interval")

        return Gen<T> {
            .random(in: range, using: &$0.rng)
        }
    }
}

// - MARK: RandomInRangeable

/// Indicates a type which can provide random values within a Range
///
/// - Note: Many existing Swift classes support this format despite not deriving from a protocol
public protocol RandomInRangeable: Comparable {
    /// Returns a random value within the specified range.
    ///
    /// - Parameter range: The range in which to create a random value. range must not be empty.
    ///
    /// - Returns: A random value within the bounds of range.
    static func random<RNG>(in range: ClosedRange<Self>, using generator: inout RNG) -> Self where RNG: RandomNumberGenerator

    /// Returns a random value within the specified range.
    ///
    /// - Parameter range: The range in which to create a random value. range must not be empty.
    ///
    /// - Returns: A random value within the bounds of range.
    static func random<RNG>(in range: Range<Self>, using generator: inout RNG) -> Self where RNG: RandomNumberGenerator
}

// - MARK: RandomInRangeable Extensions

extension Int: RandomInRangeable {}
extension Int32: RandomInRangeable {}
extension UInt: RandomInRangeable {}
extension UInt32: RandomInRangeable {}
extension Int64: RandomInRangeable {}
extension Double: RandomInRangeable {}
extension Float: RandomInRangeable {}

extension Character: RandomInRangeable {
    public static func random<RNG>(in range: ClosedRange<Character>, using generator: inout RNG) -> Character where RNG : RandomNumberGenerator {
        Character(
            UnicodeScalar.random(in: range.mapBound {
                $0.unicodeScalars.first!
            }, using: &generator)
        )
    }

    public static func random<RNG>(in range: Range<Self>, using generator: inout RNG) -> Self where RNG: RandomNumberGenerator {
        Character(
            UnicodeScalar.random(in: range.mapBound {
                $0.unicodeScalars.first!
            }, using: &generator)
        )
    }
}

extension UnicodeScalar: RandomInRangeable {
    public static func random<RNG>(in range: ClosedRange<Unicode.Scalar>, using generator: inout RNG) -> Unicode.Scalar where RNG : RandomNumberGenerator {
        Unicode.Scalar(UInt32.random(in: range.mapBound {
            $0.value
        }))!
    }

    public static func random<RNG>(in range: Range<Self>, using generator: inout RNG) -> Self where RNG: RandomNumberGenerator {
        Unicode.Scalar(UInt32.random(in: range.mapBound {
            $0.value
        }))!
    }
}

// - MARK: Helper Range Extensions

private extension Range {
    func mapBound<T>(_ fn: (Bound) -> T) -> Range<T> {
        let min = fn(lowerBound)
        let max = fn(upperBound)

        return min..<max
    }
}

private extension ClosedRange {
    func mapBound<T>(using fn: (Bound) -> T) -> ClosedRange<T> {
        let min = fn(lowerBound)
        let max = fn(upperBound)

        return min...max
    }
}

extension Range where Bound: RandomInRangeable {
    var generatable: AnyGeneratable<Bound> {
        Gen { ctx in
            Bound.random(in: self, using: &ctx.rng)
        }.eraseToAnyGeneratable()
    }
}
