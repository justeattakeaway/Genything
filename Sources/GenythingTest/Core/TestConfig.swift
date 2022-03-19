/// Global mutable defaults which will be used when initializing a `TestConfig`
///
/// - SeeAlso: `TestConfig`
public enum TestConfig {
    /// The default iterations that will be used for operations which consume a generator's values
    ///
    /// - SeeAlso: `Gen.take(count:context:)`
    /// - SeeAlso: `Gen.forEach(iterations:context:)`
    /// - SeeAlso: `Gen.allSatisfy(iterations:context:)`

    public static var maxIterations: Int = 1000

    /// The default probability to generate edge cases included by `withEdgecases(edgeCases:)`
    ///
    /// - Note: The included ArbitraryGeneratable generators will contain edge cases by default
    ///
    /// - SeeAlso: `Gen.withEdgecases(edgeCases:)`
    public static var edgeCaseProbability: Double = 0.05
}
