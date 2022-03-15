import Foundation

// MARK: Mutate

public extension Gen {
    /// Returns: A generator that only produces values which pass the test `isIncluded`
    ///
    /// - Warning: If the filtered condition is rare enough this function can become infinitely complex
    /// e.g. `Int.arbitrary.filter { $0 == 0 }` has a `$1/Int.max$` probability of occuring and will be nearly infinite
    ///
    /// Therefore if the Context's `maxDepth` is reached before producing a value the generator will throw
    ///
    /// - Parameters:
    ///   - isIncluded: A function which returns true if the value should be included
    ///
    /// - Returns: A `Gen` generator.
    func filter(_ isIncluded: @escaping (T) -> Bool) -> Generatables.Filter<T> {
        Generatables.Filter(source: self, isIncluded: isIncluded)
    }
}

extension Generatables {
    public struct Filter<T>: Generatable {
        let source: Gen<T>
        let isIncluded: (T) -> Bool

        public func start() -> Gen<T> {
            let sourceGen = source.start()
            return Gen<T> { ctx in
                let value = (0...ctx.maxDepth).lazy.map { _ in
                    sourceGen.generate(context: ctx)
                }.first {
                    isIncluded($0)
                }

                guard let value = value else {
                    throw GenError.maxDepthReached
                }
                return value
            }
        }
    }
}
