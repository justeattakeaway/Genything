import Foundation

// MARK: Produce

public extension Gen {
    /// Iterates (lazily) over a sequence and executes a given predicate `body`
    ///
    /// Will run n times, where n is the provided `iterations` or the context's value
    ///
    /// - Parameters:
    ///   - iterations: The amount of times the sequence should iterate, default's to the context's `maxIterations` value
    ///   - context: The context to be used for generation
    func forEach(iterations: Int? = nil,
                 context: Context = .default,
                 _ body: (T) -> Void) {
        sequence(ofSize: iterations, context: context).forEach(body)
    }
}
