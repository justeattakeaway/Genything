public struct RandomizedGeneratorSequence<G>: Sequence, IteratorProtocol
    where G: Generator {

    let generator: RandomizedGenerator<G>

    public init(_ generator: RandomizedGenerator<G>) {
        self.generator = generator
    }

    public func next() -> G.T? {
        generator.next()
    }
}
