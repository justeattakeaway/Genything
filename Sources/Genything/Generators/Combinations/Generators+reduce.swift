import Foundation

// MARK: Build

extension Generators {
    /// Returns: A generator resulting from combining generated elements from the generators collection using the given closure
    ///
    /// - Parameters:
    ///   - generators: A collection of generators to be reduced into a single generator instance
    ///   - initialResult: The value to use as the initial accumulating value. initialResult is passed to nextPartialResult the first time the closure is executed.
    ///   - nextPartialResult: A closure that combines an accumulating value and an element of the collection into a new accumulating value, to be used in the next call of the nextPartialResult closure or returned to the caller.
    ///
    /// - Returns: A `Gen` generator producing the final accumulated value. If the collection has no elements, the result will be initialResult.
    public static func reduce<G, R>(
        _ generators: [G],
        _ initialResult: R,
        _ nextPartialResult: @escaping (R, G.T) -> R
    ) -> AnyGenerator<R> where G: Generator {
        collect(generators)
            .map { $0.reduce(initialResult, nextPartialResult) }
    }
}
