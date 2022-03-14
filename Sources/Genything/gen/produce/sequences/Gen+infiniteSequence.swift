import Foundation

// MARK: Produce

extension Gen {
    /// Returns: An infinite sequence of this generator's values
    ///
    /// - Warning: The resulting sequence is infinite
    ///
    /// - Parameters:
    ///   - context: The context to be used for generation
    ///
    /// - Returns: The Sequence
    func infiniteSequence(context: Context = .default) -> InfiniteSequence<T> {
        InfiniteSequence {
            generate(context: context)
        }
    }
}
