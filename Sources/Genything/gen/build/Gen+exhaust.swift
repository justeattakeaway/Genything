import Foundation

/// Storage required in order to index all exhaustive values before moving on to the  `then` generator
/// Bounded by the lifetime of the `Context`
///
/// - SeeAlso: `Gen.exhaust(values:then:)`
private class ExhaustiveStorage {
    /// Map of generator identifier to Index
    private var data: [UUID:Int] = [:]

    /// Returns: The current exhaustive index for the provided generator's ID
    func index(_ id: UUID) -> Int {
        data[id] ?? 0
    }

    /// Increments the index for the provided generator's ID
    func incrementIndex(_ id: UUID) {
        data[id] = index(id) + 1
    }
}

public extension Gen {
    /// Returns: A generator which produces (in-order) all of the values from the provided list, then randomly from the provided generator
    ///
    /// - Parameters:
    ///   - values: A list of values we will always draw from first
    ///   - then: A generator to produce values after we have exhausted the `values` list
    ///
    /// - Returns: The generator
    static func exhaust(_ values: [T], then: Gen<T>) -> Gen<T> {
        let id = UUID()
        return Gen<T> { ctx in
            let store = ctx.services.service {
                ExhaustiveStorage()
            }
            let i = store.index(id)
            if i < values.count {
                store.incrementIndex(id)
                return values[i]
            } else {
                return then.generate(context: ctx)
            }
        }
    }
}
