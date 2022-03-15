import Foundation

// MARK: Combine

public extension Gen {
    /// Collects and combines the values from the `generators` maintaining the order
    ///
    /// - Parameters:
    ///    - generators: Generators to select values from in-order
    ///
    /// - Returns: The generator of Arrays containing values selected in order from the provided generators
    static func collect(_ generators: [Gen<T>]) -> AnyGeneratable<[T]> {
        collect(generators) { $0 }
    }

    /// Collects and combines the values from the `generators` maintaining the order
    ///
    /// - Parameters:
    ///    - generators: Generators to select values from in-order
    ///    - transform: Transformation to be applied to each value
    ///
    /// - Returns: The generator of Arrays containing values selected in order from the provided generators
    static func collect<R>(_ generators: [Gen<T>], _ transform: @escaping (T) -> R) -> AnyGeneratable<[R]> {
        Gen<[R]> { ctx in
            generators.map {
                $0.generate(context: ctx)
            }.map(transform)
        }.eraseToAnyGeneratable()
    }
}
