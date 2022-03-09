import Foundation

// MARK: Mutate

public extension Gen where T: Equatable {

    /// Returns: A generator that only produces unique values
    ///
    /// - Warning: If the unique'd Generator is small enough this function will throw `UniqueError.maxDepthReached`
    ///
    /// Therefore if the Context's `maxDepth` is reached before producing a value the generator will throw
    ///
    /// - Parameters:
    ///   - maxDepth: The maximum amount of times we will attempt to create a distinct unique value before throwing
    ///
    /// - Returns: A `Gen` generator.
    func unique() -> Gen<T> {
        var history = [T]()
        return Gen<T> { ctx in
            let value = (0...ctx.maxDepth).lazy.map { _ in
                generate(context: ctx)
            }.first { candidateValue in
                !history.contains(candidateValue)
            }

            guard let value = value else {
                throw GenError.maxDepthReached
            }
            history.append(value)

            return value
        }
    }
}
