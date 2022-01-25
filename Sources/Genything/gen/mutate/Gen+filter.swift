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
    func filter(_ isIncluded: @escaping (T) -> Bool) -> Gen<T> {
        Gen<T> { ctx in
            let value = (0...ctx.maxDepth).lazy.map { _ in
                generate(context: ctx)
            }.first {
                isIncluded($0)
            }

            guard let value = value else {
                throw GenError.maxDepthReached
            }
            return value
        }
    }

    /// Returns: A generator that only produces values which pass the test `isIncluded`
    ///
    /// - Warning: If the filtered condition is rare enough this function will become infinitely complex and will run forever
    /// e.g. `Int.arbitrary.filter { $0 == 999 }` has a `$1/Int.max$` probability of occuring and will be nearly infinite
    ///
    /// - Parameters:
    ///   - isIncluded: A function which returns true if the value should be included
    ///
    /// - Returns: A `Gen` generator.
    func filterForever(_ isIncluded: @escaping (T) -> Bool) -> Gen<T> {
        Gen<T> { ctx in
            while(true) {
                let value = generate(context: ctx)
                if isIncluded(value) {
                    return value
                }
            }
        }
    }
}
