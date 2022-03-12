import Foundation

// MARK: Produce

public extension Gen {
    func infiniteSequence(context: Context = .default) -> InfiniteSequence<T> {
        InfiniteSequence {
            generate(context: context)
        }
    }
}
