import Foundation

// MARK: Combine

public extension Gen {
    /// Returns: A generator which produces values randomly selected from one of the provided generators
    ///
    /// - Parameters:
    ///    - generators: The generators which can be selected from to produce a value
    ///
    /// - Returns: The generator
    static func one<T>(of generators: [Gen<T>]) -> AnyGeneratable<T> {
        assert(!generators.isEmpty, "List of generators cannot be empty")

        return Gen<Int>
            .from(0..<generators.count)
            .flatMap {
                generators[$0]
            }
            .eraseToAnyGeneratable()
    }
}
