import Foundation

// MARK: Mutate

public extension Generatable {
    /// Returns: A generator that transforms the receivers' values into a value of type `R`
    ///
    /// - Parameters:
    ///   - transform: A function capable of transforming the receiver's values to type `R`
    ///
    /// - Returns: A `Gen` generator of values of type `R`
    func map<R>(_ transform: @escaping (T) throws -> R) -> Generatables.Map<Self.T, R> {
        Generatables.Map(source: self.start(), transform: transform)
    }
}

extension Generatables {
    public struct Map<SourceType, OutputType>: Generatable {
        let source: Gen<SourceType>
        let transform: (SourceType) throws -> OutputType

        public func start() -> Gen<OutputType> {
            Gen<OutputType> { ctx -> OutputType in
                try transform(source.generate(context: ctx))
            }
        }
    }
}
