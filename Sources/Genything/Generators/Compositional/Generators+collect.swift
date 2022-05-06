// MARK: Combine

extension Generators {
    /// Collects and combines the values from the `generators` maintaining the order
    ///
    /// - Parameters:
    ///    - generators: Generators to select values from in-order
    ///
    /// - Returns: The generator of Arrays containing values selected in order from the provided generators
    public static func collect<G>(_ generators: [G]) -> AnyGenerator<[G.T]> where G: Generator {
        collect(generators) { $0 }
    }

    /// Collects and combines the values from the `generators` maintaining the order
    ///
    /// - Parameters:
    ///    - generators: Generators to select values from in-order
    ///
    /// - Returns: The generator of Arrays containing values selected in order from the provided generators
    public static func collect<G>(_ generators: G...) -> AnyGenerator<[G.T]> where G: Generator {
        collect(generators)
    }

    /// Collects and combines the values from the `generators` maintaining the order
    ///
    /// - Parameters:
    ///    - generators: Generators to select values from in-order
    ///    - transform: Transformation to be applied to each value
    ///
    /// - Returns: The generator of Arrays containing values selected in order from the provided generators
    public static func collect<G, R>(_ generators: [G], transform: @escaping (G.T) -> R) -> AnyGenerator<[R]>
        where G: Generator {
        Collect(sources: generators, transform: transform).eraseToAnyGenerator()
    }

    /// Collects and combines the values from the `generators` maintaining the order
    ///
    /// - Parameters:
    ///    - generators: Generators to select values from in-order
    ///    - transform: Transformation to be applied to each value
    ///
    /// - Returns: The generator of Arrays containing values selected in order from the provided generators
    public static func collect<G, R>(_ generators: G..., transform: @escaping (G.T) -> R) -> AnyGenerator<[R]>
        where G: Generator {
        collect(generators, transform: transform)
    }

    struct Collect<Source, T>: Generator where Source: Generator {
        let sources: [Source]
        let transform: (Source.T) -> T

        func next(_ randomSource: RandomSource) -> [T] {
            sources.map {
                $0.next(randomSource)
            }.map(transform)
        }
    }
}
