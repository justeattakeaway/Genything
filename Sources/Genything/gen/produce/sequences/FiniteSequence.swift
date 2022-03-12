public struct FiniteSequence<Element>: Sequence, IteratorProtocol {
    private let generator: () -> Element
    private let size: Int

    private var index = 0

    public init(size: Int, _ generator: @escaping () -> Element) {
        self.size = size
        self.generator = generator
    }

    mutating public func next() -> Element? {
        guard index < size else { return nil }

        index += 1

        return generator()
    }
}
