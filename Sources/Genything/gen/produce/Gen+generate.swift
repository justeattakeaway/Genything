import Foundation

public extension Gen {
    /// Returns: A single value produced by the generator using the provided Context
    ///
    /// - Parameters:
    ///   - context: The context to be used for generation
    ///
    /// - Returns: A value of type `T`
    func generate(context: Context = .default) -> T {
        generate(using: context)
    }
}
