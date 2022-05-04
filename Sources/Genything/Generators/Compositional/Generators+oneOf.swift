// MARK: Combine

extension Generators {
    /// Returns: A generator which produces values randomly selected from one of the provided generators
    ///
    /// - Parameters:
    ///    - generators: The generators which can be selected from to produce a value
    ///
    /// - Returns: The generator
    public static func one<G>(of generators: [G]) -> AnyGenerator<G.T> where G: Generator {
        generators.arbitrary.flatMap { $0 }
    }

    /// Returns: A generator which produces values randomly selected from one of the provided generators
    ///
    /// - Parameters:
    ///    - generators: The generators which can be selected from to produce a value
    ///
    /// - Returns: The generator
    public static func one<G>(of generators: G...) -> AnyGenerator<G.T> where G: Generator {
        one(of: generators)
    }
}
