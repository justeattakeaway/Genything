import Foundation

// MARK: Combine

public extension Gen {
    /// Returns: A generator which produces values by the provided collection. When exhausted the generator will switch to producing values from the receiving generator.
    ///
    /// - Parameters:
    ///    - values: Array of values which will be produced in order before the receiver takes over
    ///
    /// - Returns: The generator
    func startWith<C: Collection>(_ collection: C) -> Gen<T> where C.Element == T {
        Gen.iterate(collection).flatMap {
            if let value = $0 {
                return Gen.constant(value)
            } else {
                return self
            }
        }
    }
}
