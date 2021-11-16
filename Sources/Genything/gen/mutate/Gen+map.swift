import Foundation

public extension Gen {
    /// Returns: A generator that transforms the receivers' values into a value of type `R`
    ///
    /// - Parameters:
    ///   - transform: A function capable of transforming the receiver's values to type `R`
    ///
    /// - Returns: A `Gen` generator of values of type `R`
    func map<R>(_ transform: @escaping (T) -> R) -> Gen<R> {
        Gen<R> { ctx -> R in
            transform(generate(using: ctx))
        }
    }
}
