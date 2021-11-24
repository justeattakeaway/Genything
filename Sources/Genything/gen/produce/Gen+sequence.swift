import Foundation

internal struct GenSequence<T>: Sequence, IteratorProtocol {
    private let generator: () -> T
    private let size: Int?

    private(set) var index = 0

    public init(size: Int? = nil, _ generator: @escaping () -> T) {
        self.size = size
        self.generator = generator
    }

    public typealias Element = T

    mutating public func next() -> T? {
        guard size == nil || index < size! else {
            return nil
        }

        index += 1

        return generator()
    }
}

internal extension Gen {
    /// Returns: An optionally sized sequence capable of generating the generators' values
    ///
    /// - Warning: When the sequence reaches the end, it will no longer generate values ever again
    ///
    /// - Parameters:
    ///   - size: The amount of times the sequence can iterate before returning nil, default's to the context's `iterations` value
    ///   - context: The context to be used for generation
    ///
    /// - Returns: A sequence that generates this generator's values
    func sequence(ofSize size: Int? = nil,
                  context: Context = .default) -> GenSequence<T> {
        GenSequence(size: size ?? context.maxIterations) {
            generate(context: context)
        }
    }
}
