import Foundation

// MARK: Produce

public extension Generator {
    /// Iterates (lazily) over a sequence of generated values and executes a given predicate `body`
    ///
    /// Will run n times, where n is the provided `iterations` or the context's value
    ///
    /// - Parameters:
    ///   - iterations: The amount of times the sequence should iterate, default's to the context's `maxIterations` value
    ///   - context: The context to be used for generation
    func forEach(size: Int,
                 context: Context = .default,
                 _ body: (T) -> Void) {
        asSequence(size: size, context: context).forEach(body)
    }
}
