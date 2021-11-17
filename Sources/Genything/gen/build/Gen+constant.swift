import Foundation

public extension Gen {
    /// Returns: A generator which **constantly** produces the provided value
    ///
    /// - Parameter value: The value which this generator will constantly create
    ///
    /// - Returns: The generator
    static func constant(_ value: T) -> Gen<T> {
        Gen<T> { _ in
            value
        }
    }
}
