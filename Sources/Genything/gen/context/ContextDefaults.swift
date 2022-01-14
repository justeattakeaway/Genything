import Foundation

/// Global mutable defaults which will be used when initializing a `Context`
///
/// - SeeAlso: `Context`
public enum ContextDefaults {
    /// The default iterations that will be used for operations which consume a generator's values
    ///
    /// - SeeAlso: `Gen.take(count:context:)`
    /// - SeeAlso: `Gen.forEach(iterations:context:)`
    /// - SeeAlso: `Gen.allSatisfy(iterations:context:)`

    public static var maxIterations: Int = 1000
    /// The default maximum depth that a generator which rejects values can reach before failing
    ///
    /// - SeeAlso: `Gen.filter(isIncluded:)`
    /// - SeeAlso: `Gen.unique()`
    public static var maxDepth: Int = 100

    /// The default probability to generate edge cases included by `withEdgecases(edgeCases:)`
    ///
    /// - Note: The included Arbitrary generators will contain edge cases by default
    ///
    /// - SeeAlso: `Gen.withEdgecases(edgeCases:)`
    public static var edgeCaseProbability: Double = 0.05

    /// Stores a factory capable of creating the `Context` which will be used by default
    private(set) public static var defaultContextFactory: () -> Context = {
        Context(determinism: .predetermined(seed: 2022))
    }

    /// Registers a function capable of creating the `Context` which will be used by default
    public static func registerDefaultContext(_ factory: @escaping () -> Context) {
        defaultContextFactory = factory
    }
}
