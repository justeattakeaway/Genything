import Foundation

public extension Gen where T: CaseIterable {
    /**
     * Adapts a type conforming to CaseIterable into a generator which produces any of it's cases
     */
    static func ofCases() -> Gen<T> {
        assert(!T.allCases.isEmpty, "`Gen.ofCases()` called for empty CaseIterable.")
        return Gen<T> {
            T.allCases.randomElement(using: &$0.rng)!
        }
    }
}
