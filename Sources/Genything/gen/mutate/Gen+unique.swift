import Foundation

// MARK: Mutate

/// A cache capable of storing the unique values created by a particular Generator's id for the lifetime of the `Context`
///
/// - SeeAlso: `Gen.unique()`
private class UniqueStorage {
    private var data: [UUID:[Any]] = [:]

    func contains<T: Equatable>(_ value: T, id: UUID) -> Bool {
        data[id]?.contains {
            ($0 as? T) == value
        } ?? false
    }

    func store<T: Equatable>(_ value: T, id: UUID) {
        if let existing = data[id] {
            data[id] = existing + [value]
        } else {
            data[id] = [value]
        }
    }
}

// TODO: Give context a DI engine to "resolve" the UniqueStore
// TODO: Check resolver which uses an int to represent the Type

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
        let id = UUID()
        return Gen<T> { ctx in
            // Initializes or fetches a `UniqueStorage` store for this generator's ID
            let store = ctx.services.service {
                UniqueStorage()
            }

            let value = (0...ctx.maxDepth).lazy.map { _ in
                generate(context: ctx)
            }.first { candidateValue in
                !store.contains(candidateValue, id: id)
            }

            guard let value = value else {
                throw GenError.maxDepthReached
            }

            // Saves this value to the store
            store.store(value, id: id)

            return value
        }
    }
}
