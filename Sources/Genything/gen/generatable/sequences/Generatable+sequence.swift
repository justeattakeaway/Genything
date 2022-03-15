import Foundation

// MARK: Produce

public extension Generatable {
    /// Returns: A sequence of this generator's values which will produce `nil` after `size` iterations
    ///
    /// - Warning: The sequence is destructively consumed by iteration.
    ///     Repeated access will continue at the existing iteration. As a consequence, don't assume
    ///     that multiple for-in loops will restart from the beginning.
    ///
    /// - SeeAlso: https://developer.apple.com/documentation/swift/sequence
    ///
    /// - Parameters:
    ///   - size: The amount of iterations before this sequence will begin to return `nil`
    ///   - context: The context to be used for generation
    ///
    /// - Returns: The Sequence
    func asSequence(size: Int, context: Context = .default) -> FiniteSequence<T> {
        let gen = start()
        return FiniteSequence(size: size) {
            gen.generate(context: context)
        }
    }
}
