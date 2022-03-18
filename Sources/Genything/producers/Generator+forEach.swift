import Foundation

// MARK: Produce

public extension Generator {
    /// Iterates over a sequence of generated values and executes a given predicate `body`
    ///
    /// Will run n times, where n is the provided `iterations` or the context's value
    ///
    /// - Parameters:
    ///   - iterations: The amount of times the sequence should iterate, default's to the context's `maxIterations` value
    ///   - context: The context to be used for generation
    func forEach(iterations: Int,
                 context: Context = .default,
                 _ body: (T) throws -> Void) rethrows {
        try asSequence(size: iterations, context: context).forEach(body)
    }
}
