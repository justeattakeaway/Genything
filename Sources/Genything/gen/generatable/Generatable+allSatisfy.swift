import Foundation

// MARK: Produce

public extension SafeGen {
    /// Returns: A Boolean value indicating whether every element of a collection satisfies a given predicate
    ///
    /// Will run n times, where n is the provided `iterations` or the context's value
    ///
    /// - Parameters:
    ///   - iterations: The amount of times the collection should iterate, default's to the context's `maxIterations` value
    ///   - context: The context to be used for generation
    ///   - predicate: A closure that takes an element of the collection as its argument and returns a Boolean value that indicates whether the passed element satisfies a condition.
    ///
    /// - Returns: The Boolean result
    func allSatisfy(iterations: Int? = nil,
                    context: Context = .default,
                    _ predicate: (T) throws -> Bool) throws -> Bool {

        let iterations = iterations ?? context.maxIterations

        for _ in 0..<iterations {
            if !(try predicate(generate(context: context))) {
                return false
            }
        }

        return true
    }
}

public extension Generatable {
    /// Returns: A Boolean value indicating whether every element of a collection satisfies a given predicate
    ///
    /// Will run n times, where n is the provided `iterations` or the context's value
    ///
    /// - Parameters:
    ///   - iterations: The amount of times the collection should iterate, default's to the context's `maxIterations` value
    ///   - context: The context to be used for generation
    ///   - predicate: A closure that takes an element of the collection as its argument and returns a Boolean value that indicates whether the passed element satisfies a condition.
    ///
    /// - Returns: The Boolean result
    func allSatisfy(iterations: Int? = nil,
                    context: Context = .default,
                    _ predicate: (T) throws -> Bool) rethrows -> Bool {
        try! start().safe.allSatisfy(iterations: iterations, context: context, predicate)
    }
}
