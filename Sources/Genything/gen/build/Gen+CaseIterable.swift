import Foundation

public extension Gen where T: CaseIterable {
    /// Adapts a type conforming to CaseIterable into a generator which produces values of any case
    ///
    /// - Precondition: The receiver's `allCases` property must not return empty
    ///
    /// - Returns: A generator capable of generating any of the receiver's cases
    static func ofCases() -> Gen<T> {
        assert(!T.allCases.isEmpty, "`Gen.ofCases()` called for empty CaseIterable.")
        return Gen<T> {
            T.allCases.randomElement(using: &$0.rng)!
        }
    }
}
