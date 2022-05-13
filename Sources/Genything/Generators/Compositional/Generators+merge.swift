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
    public static func merge<G>(_ generators: G...) -> AnyGenerator<G.T> where G: Generator {
        merge(generators)
    }

    final class Merge<Source>: Generator where Source: Generator {
        init(_ sources: [Source]) {
            loop = Loop(sources).flatMap { $0 }
        }

        func next(_ randomSource: RandomSource) -> Source.T {
            loop.next(randomSource)
        }

        private let loop: AnyGenerator<Source.T>
    }
}
