import Foundation

public extension Gen {
    /// Returns: A Boolean value indicating whether every element of a sequence satisfies a given predicate
    ///
    /// Will run n times, where n is the provided `iterations` or the context's value
    ///
    /// - Parameters:
    ///   - iterations: The amount of times the sequence should iterate, default's to the context's `iterations` value
    ///   - context: The context to be used for generation
    ///
    /// - Returns: The Boolean result
    func allSatisfy(iterations: Int? = nil,
                    context: Context = .default,
                    _ predicate: (T) -> Bool) -> Bool {
        sequence(ofSize: iterations, context: context).allSatisfy(predicate)
    }
}
