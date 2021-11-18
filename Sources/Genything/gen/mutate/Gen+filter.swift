import Foundation

// MARK: Mutate

public extension Gen {
    /// An Error representing the scenarios in which filtering a Generator may fail
    enum FilterError: Error {
        case maxDepthReached
    }

    /// Returns: A generator that only produces values which pass the test `isIncluded`
    ///
    /// - Warning: If the filtered condition is rare enough this function can become infinitely complex
    /// e.g. `Int.arbitrary.filter { $0 == 0 }` has a `$1/Int.max$` probability of occuring and will be nearly infinite
    ///
    /// Therefore if the Context's `maxFilterDepth` is reached before producing a value the generator will throw
    ///
    /// - Parameters:
    ///   - isIncluded: A function which returns true if the value should be included
    ///   - maxDepth: The maximum amount of times `isIncluded` may return false in succession
    ///
    /// - Returns: A `Gen` generator.
    func filter(_ isIncluded: @escaping (T) -> Bool) -> Gen<T> {
        Gen<T> { ctx in
            let value = (0...ctx.maxFilterDepth).lazy.map { _ in
                generate(context: ctx)
            }.first {
                isIncluded($0)
            }

            guard let value = value else {
                throw FilterError.maxDepthReached
            }
            return value
        }
    }
}
