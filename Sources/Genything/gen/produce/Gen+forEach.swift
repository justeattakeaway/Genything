import Foundation

// MARK: Produce

public extension SafeGen {
    /// Iterates (lazily) over a sequence and executes a given predicate `body`
    ///
    /// Will run n times, where n is the provided `iterations` or the context's value
    ///
    /// - Parameters:
    ///   - iterations: The amount of times the sequence should iterate, default's to the context's `maxIterations` value
    ///   - context: The context to be used for generation
    func forEach(iterations: Int? = nil,
                 context: Context = .default,
                 _ body: (T) throws -> Void) throws {
        let iterations = iterations ?? context.maxIterations

        for _ in 0..<iterations {
            try body(generate(context: context))
        }
    }
}

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
                 _ body: (T) throws -> Void) rethrows {
        try! safe.forEach(iterations: iterations, context: context, body)
    }
}
