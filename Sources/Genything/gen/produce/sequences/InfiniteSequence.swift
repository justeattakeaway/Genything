public struct InfiniteSequence<Element>: Sequence, IteratorProtocol {
    let generator: () -> Element
    mutating public func next() -> Element? {
        generator()
    }
}
