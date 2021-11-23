import Foundation

// MARK: Mutate

public extension Gen where T: Equatable {
    /// Returns: A generator that only produces unique values
    ///
    /// - Warning: If the unique'd Generator is small enough this function will throw `UniqueError.maxDepthReached`
    ///
    /// Therefore if the Context's `maxDepth` is reached before producing a value the generator will throw
    ///
    /// - Warning: The unique cache will persist between uses with the same `Context`, leading to a higher chance of exhausting the generator
    ///
    /// The `Context`'s unique cache may be cleared by calling `Context.clearCache()`
    ///
    /// - Parameters:
    ///   - maxDepth: The maximum amount of times we will attempt to create a distinct unique value before throwing
    ///
    /// - Returns: A `Gen` generator.
    func unique() -> Gen<T> {
        return Gen<T> { ctx in
            let value = (0...ctx.maxDepth).lazy.map { _ in
                generate(context: ctx)
            }.first { candidateValue in
                let exists = ctx.uniqueCache[id]?.contains {
                    ($0 as? T) == candidateValue
                } ?? false

                return !exists
            }

            guard let value = value else {
                throw GenError.maxDepthReached
            }

            if let cache = ctx.uniqueCache[id] {
                ctx.uniqueCache[id] = cache + [value]
            } else {
                ctx.uniqueCache[id] = [value]
            }

            return value
        }
    }
}
