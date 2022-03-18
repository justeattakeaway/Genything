import Foundation

// MARK: Build

public extension Generators {
    /// Returns: A generator which randomly produces values form the provided list
    ///
    /// - Warning: The values list must not be empty
    ///
    /// - Parameter values: The values which this generator will randomly select from
    ///
    /// - Returns: The generator
    static func of<T>(_ values: [T]) -> AnyGenerator<T> {
        Of(values).eraseToAnyGenerator()
    }
}

private struct Of<T>: Generator {
    let values: [T]

    init(_ values: [T]) {
        assert(!values.isEmpty, "`Gen.of(values:)` was invoked with an empty list of values")
        self.values = values
    }

    func next(_ context: Context) -> T {
        values.randomElement(using: &context.rng)!
    }
}
