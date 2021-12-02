import Foundation

// MARK: Produce

public extension SafeGen {
    /// Returns: Non-deterministic random samples of the generator's values
    ///
    /// - Warning: Recommended to be used **only** to evaluate or demonstrate the generator
    ///
    /// - Parameters:
    ///   - count: The amount of values to be returned as samples
    ///
    /// - Returns: An array of sample values
    func samples(count: Int = 20) throws -> [T] {
        try take(count: count, context: .random)
    }

    /// Returns: A single non-deterministic random sample of the generator's values
    ///
    /// - Warning: Recommended to be used **only** to evaluate or demonstrate the generator
    ///
    /// - Returns: A sample value
    func sample() throws -> T {
        try generate(context: .random)
    }
}

public extension Gen {
    /// Returns: Non-deterministic random samples of the generator's values
    ///
    /// - Warning: Recommended to be used **only** to evaluate or demonstrate the generator
    ///
    /// - Parameters:
    ///   - count: The amount of values to be returned as samples
    ///
    /// - Returns: An array of sample values
    func samples(count: Int = 20) -> [T] {
        try! safe.samples(count: count)
    }

    /// Returns: A single non-deterministic random sample of the generator's values
    ///
    /// - Warning: Recommended to be used **only** to evaluate or demonstrate the generator
    ///
    /// - Returns: A sample value
    func sample() -> T {
        try! safe.sample()
    }
}
