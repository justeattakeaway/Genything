import Foundation

// MARK: Build

public extension Generators {
    /// Returns: A generator which produces the result of shuffling the provided list
    ///
    /// - Warning: The values list must not be empty
    ///
    /// - Parameter values: The values which this generator will shuffle
    ///
    /// - Returns: The generator
    static func shuffled<T>(_ values: [T]) -> AnyGenerator<[T]> {
        Shuffled(values).eraseToAnyGenerator()
    }
}

private struct Shuffled<T>: Generator {
    let values: [T]

    init(_ values: [T]) {
        assert(!values.isEmpty, "`Gen.shuffled(values:)` was invoked with an empty list of values")
        self.values = values
    }

    func next(_ randomSource: RandomSource) -> [T] {
        values.shuffled(using: &randomSource.rng)
    }
}
