extension Generator where T: Sequence {
    /// Flattens a generator of sequences into a generator of the sequence's elements.
    /// The sequence will be iterated in-order and when exhausted a new sequence will be generated.
    ///
    /// - Returns: A generator which generates individual elements from this generator's sequences
    public func flatten() -> AnyGenerator<T.Element> {
        Generators.Flatten(source: self).eraseToAnyGenerator()
    }
}

extension Generator where T: Generator {
    /// Flattens a generator of generators into a generator of the nested generator's elements.
    ///
    /// - Returns: A generator which generates it's elements from the nested generator's elements.
    public func flatten() -> AnyGenerator<T.T> {
        Generators.FlatMap(source: self) { $0 }
            .eraseToAnyGenerator()
    }
}

extension Generators {
    class Flatten<Source>: Generator where Source: Generator, Source.T: Sequence {

        init(source: Source) {
            self.source = source
        }

        let source: Source
        var iterator: Source.T.Iterator!


        func next(_ randomSource: RandomSource) -> Source.T.Element {
            if
                iterator != nil,
                let next = iterator!.next() {
                return next
            } else {
                iterator = source.next(randomSource).makeIterator()
                return next(randomSource)
            }
        }
    }
}
