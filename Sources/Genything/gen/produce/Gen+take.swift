import Foundation

// MARK: Produce

public extension SafeGen {
    /// Returns: An array of values from the generator
    ///
    /// - Parameters:
    ///   - count: The amount of values to generate, default's to the context's `iterations` value
    ///   - context: The context to be used for generation
    ///
    /// - Returns: An array of generated values
    func take(_ count: Int? = nil,
              context: Context = .default) throws -> [T] {
        try (0..<(count ?? context.maxIterations)).map { _ in
            try generate(context: context)
        }
    }
}

public extension Gen {
    /// Returns: An array of values from the generator
    ///
    /// - Parameters:
    ///   - count: The amount of values to generate, default's to the context's `iterations` value
    ///   - context: The context to be used for generation
    ///
    /// - Returns: An array of generated values
    func take(_ count: Int? = nil,
              context: Context = .default) -> [T] {
        try! safe.take(count, context: context)
    }
}
