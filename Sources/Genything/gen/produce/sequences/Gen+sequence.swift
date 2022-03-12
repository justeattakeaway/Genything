import Foundation

// MARK: Produce

public extension Gen {
    func sequence(_ size: Int, context: Context = .default) -> FiniteSequence<T> {
        FiniteSequence(size: size) {
            generate(context: context)
        }
    }
}
