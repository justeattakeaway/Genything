import Foundation

// MARK: Combine

public extension Generators {
    /// Returns: A generator which produces values randomly selected from one of the provided generators
    ///
    /// - Parameters:
    ///    - generators: The generators which can be selected from to produce a value
    ///
    /// - Returns: The generator
    static func one<G>(of generators: [G]) -> AnyGenerator<G.T> where G: Generator {
        assert(!generators.isEmpty, "List of generators cannot be empty")

        return Generators
            .from(0..<generators.count)
            .flatMap {
                generators[$0]
            }
            .eraseToAnyGenerator()
    }
}
