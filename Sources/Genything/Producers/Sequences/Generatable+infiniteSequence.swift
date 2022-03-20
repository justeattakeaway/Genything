import Foundation

// MARK: Produce

extension Generator {
    /// Returns: An infinite sequence of this generator's values
    ///
    /// - Warning: The resulting sequence is infinite
    ///
    /// - Parameters:
    ///   - context: The context to be used for generation
    ///
    /// - Returns: The Sequence
    func asInfiniteSequence(context: Context = .default) -> InfiniteSequence<T> {
        InfiniteSequence {
            next(context)
        }
    }
}
