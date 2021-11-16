import Foundation

public extension Gen {
    /**
     * Adapts an array into a generator which produces any of the values in the array
     */
    static func of(_ values: [T]) -> Gen<T> {
        Gen<T> {
            values.randomElement(using: &$0.rng)!
        }
    }
}
