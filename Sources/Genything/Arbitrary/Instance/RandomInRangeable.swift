// - MARK: RandomInRangeable

// MARK: - RandomInRangeable

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

// MARK: - Int + RandomInRangeable

// - MARK: RandomInRangeable Extensions

extension Int: RandomInRangeable {}

// MARK: - Int32 + RandomInRangeable

extension Int32: RandomInRangeable {}

// MARK: - UInt + RandomInRangeable

extension UInt: RandomInRangeable {}

// MARK: - UInt32 + RandomInRangeable

extension UInt32: RandomInRangeable {}

// MARK: - Int64 + RandomInRangeable

extension Int64: RandomInRangeable {}

// MARK: - Double + RandomInRangeable

extension Double: RandomInRangeable {}

// MARK: - Float + RandomInRangeable

extension Float: RandomInRangeable {}

// MARK: - Character + RandomInRangeable

extension Character: RandomInRangeable {
    public static func random<RNG>(in range: ClosedRange<Character>, using generator: inout RNG) -> Character
        where RNG: RandomNumberGenerator {
        Character(
            UnicodeScalar.random(in: range.mapBound {
                $0.unicodeScalars.first!
            }, using: &generator))
    }

    public static func random<RNG>(in range: Range<Self>, using generator: inout RNG) -> Self where RNG: RandomNumberGenerator {
        Character(
            UnicodeScalar.random(in: range.mapBound {
                $0.unicodeScalars.first!
            }, using: &generator))
    }
}

// MARK: - UnicodeScalar + RandomInRangeable

extension UnicodeScalar: RandomInRangeable {
    public static func random<RNG>(in range: ClosedRange<Unicode.Scalar>, using _: inout RNG) -> Unicode.Scalar
        where RNG: RandomNumberGenerator {
        Unicode.Scalar(UInt32.random(in: range.mapBound {
            $0.value
        }))!
    }

    public static func random<RNG>(in range: Range<Self>, using _: inout RNG) -> Self where RNG: RandomNumberGenerator {
        Unicode.Scalar(UInt32.random(in: range.mapBound {
            $0.value
        }))!
    }
}

// - MARK: Helper Range Extensions

extension Range {
    fileprivate func mapBound<T>(_ fn: (Bound) -> T) -> Range<T> {
        let min = fn(lowerBound)
        let max = fn(upperBound)

        return min ..< max
    }
}

extension ClosedRange {
    fileprivate func mapBound<T>(using fn: (Bound) -> T) -> ClosedRange<T> {
        let min = fn(lowerBound)
        let max = fn(upperBound)

        return min ... max
    }
}
