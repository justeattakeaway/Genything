import Foundation

public extension Gen {
    /**
     * Adapts a value of T into a generator Gen which will always generate the pure value T
     */
    static func constant(_ value: T) -> Gen<T> {
        Gen<T> { _ in
            value
        }
    }
}
