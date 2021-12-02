import Foundation

// MARK: Mutate

public extension Gen {
    /// Returns: A generator resulting from combining generated elements from the generators sequence using the given closure
    ///
    /// - Parameters:
    ///   - generators: A sequence of generators to be reduced into a single generator instance
    ///   - initialResult: The value to use as the initial accumulating value. initialResult is passed to nextPartialResult the first time the closure is executed.
    ///   - nextPartialResult: A closure that combines an accumulating value and an element of the sequence into a new accumulating value, to be used in the next call of the nextPartialResult closure or returned to the caller.
    ///
    /// - Returns: A `Gen` generator producing the final accumulated value. If the sequence has no elements, the result will be initialResult.
    static func reduce<R>(_ generators: [Gen<T>],
                          _ initialResult: R,
                          _ nextPartialResult: @escaping (R, T) throws -> R) rethrows -> Gen<R> {
        try collect(generators).map { try $0.reduce(initialResult, nextPartialResult) }
    }
}
