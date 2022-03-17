import Foundation

// MARK: Produce

public extension Generator {
    /// Returns: An array of values from the generator
    ///
    /// - Parameters:
    ///   - count: The amount of values to generate, default's to the context's `iterations` value
    ///   - context: The context to be used for generation
    ///
    /// - Returns: An array of generated values
    func take(_ count: Int,
              context: Context = .default) -> [T] {
        Array(asSequence(size: count, context: context))
    }
}
