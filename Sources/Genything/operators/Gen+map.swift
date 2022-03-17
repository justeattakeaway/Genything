import Foundation

// MARK: Mutate

public extension Generator {
    /// Returns: A generator that transforms the receivers' values into a value of type `R`
    ///
    /// - Parameters:
    ///   - transform: A function capable of transforming the receiver's values to type `R`
    ///
    /// - Returns: A `Gen` generator of values of type `R`
    func map<R>(_ transform: @escaping (T) -> R) -> Generators.Map<Self, R> {
        Generators.Map(source: self, transform: transform)
    }
}

extension Generators {
    public struct Map<Source, T>: Generator where Source: Generator {
        let source: Source
        let transform: (Source.T) -> T

        public func next(_ context: Context) -> T {
            transform(source.next(context))
        }
    }
}
