struct GeneratorSequence<Source, Element>: Sequence, IteratorProtocol
    where Source: Generator, Source.T == Element {

    let generator: Source
    let randomSource: RandomSource

    public init(_ generator: Source, randomSource: RandomSource) {
        self.generator = generator
        self.randomSource = randomSource
    }

    public func next() -> Element? {
        generator.next(randomSource)
    }
}
