import Foundation

// MARK: Mutate

public extension Generatable {
    /// Returns: A generator that transforms the receiver into a generator of type `R`
    ///
    /// - Parameters:
    ///   - transform: A function capable of transforming the receiver to a generator of values of type `R`
    ///
    /// - Returns: A `Gen` generator of values of type `R`
    func flatMap<R, G: Generatable>(_ transform: @escaping (T) -> G) -> Generatables.FlatMap<T, G> where G.T == R {
        Generatables.FlatMap(startSource: start, transform: transform)
    }
}

extension Generatables {
    public struct FlatMap<SourceType, OutputGeneratable: Generatable>: Generatable {
        let startSource: () -> Gen<SourceType>
        let transform: (SourceType) throws -> OutputGeneratable

        public func start() -> Gen<OutputGeneratable.T> {
            let source = startSource()
            return Gen { ctx in
                try transform(source.generate(context: ctx)).start().generate(context: ctx)
            }
        }
    }
}
