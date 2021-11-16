import Foundation

public extension Gen {
    /// Returns: An array of values from the generator
    ///
    /// - Parameters:
    ///   - count: The amount of values to generate, default's to the context's `iterations` value
    ///   - context: The context to be used for generation
    ///
    /// - Returns: An array of generated values
    func take(count: Int? = nil,
              context: Context = .default) -> [T] {
        (0..<(count ?? context.iterations)).map { _ in
            generate(context: context)
        }
    }
}
