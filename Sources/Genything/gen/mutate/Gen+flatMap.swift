import Foundation

// MARK: Mutate

public extension Gen {
    /// Returns: A generator that transforms the receiver into a generator of type `R`
    ///
    /// - Parameters:
    ///   - transform: A function capable of transforming the receiver to a generator of values of type `R`
    ///
    /// - Returns: A `Gen` generator of values of type `R`
    func flatMap<R>(_ transform: @escaping (T) -> Gen<R>) -> Gen<R> {
        Gen<R> { ctx -> R in
            transform(generate(context: ctx)).generate(context: ctx)
        }
    }
}
