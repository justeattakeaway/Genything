import Foundation

// MARK: Mutate

public extension Generator {
    /// Returns: A generator that transforms the receiver into a generator of type `R`
    ///
    /// - Parameters:
    ///   - transform: A function capable of transforming the receiver to a generator of values of type `R`
    ///
    /// - Returns: A `Gen` generator of values of type `R`
    func flatMap<G: Generator>(_ transform: @escaping (T) -> G) -> Generators.FlatMap<Self, G> {
        Generators.FlatMap(source: self, transform: transform)
    }
}

extension Generators {
    public struct FlatMap<Source, Output>: Generator where Source: Generator, Output: Generator {
        let source: Source
        let transform: (Source.T) -> Output

        public func next(_ context: Context) -> Output.T {
            transform(source.next(context)).next(context)
        }
    }
}
