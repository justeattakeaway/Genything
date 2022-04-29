// MARK: Combine

extension Generators {
    /// Returns: A generator which produces results by looping over the provided generators in order
    ///
    /// # Example
    /// 
    /// ```swift
    /// let genA = Generators.constant("A")
    /// let genB = Generators.constant("B")
    ///
    /// Generators.merge([genA, genB]) // Produces values ABABABABABAB...
    /// ```
    ///
    /// - Returns: The generator
    public static func merge<G>(_ generators: [G]) -> AnyGenerator<G.T> where G: Generator {
        Merge(generators).eraseToAnyGenerator()
    }
}

class Merge<Source>: Generator where Source: Generator {
    private let loop: Loop<[Source]>

    init(_ sources: [Source]) {
        self.loop = Loop(sources)
    }

    func next(_ randomSource: RandomSource) -> Source.T {
        loop.next(randomSource).next(randomSource)
    }
}
