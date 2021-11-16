import Foundation

internal struct GenSequence<T>: Sequence, IteratorProtocol {
    private let generator: () -> T
    private let size: Int?

    private var index = 0

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
