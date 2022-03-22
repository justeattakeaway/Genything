/// Global mutable defaults which will be used when initializing a `TestConfig`
///
/// - SeeAlso: `TestConfig`
public enum TestConfig {
    /// The default iterations that will be used for operations which consume a generator's values
    ///
    /// - SeeAlso: `Gen.take(count:randomSource:)`
    /// - SeeAlso: `Gen.forEach(iterations:randomSource:)`
    /// - SeeAlso: `Gen.allSatisfy(iterations:randomSource:)`

    public static var maxIterations: Int = 1000

    /// The default probability to generate edge cases included by `withEdgecases(edgeCases:)`
    ///
    /// - Note: The included Arbitrary generators will contain edge cases by default
    ///
    /// - SeeAlso: `Gen.withEdgecases(edgeCases:)`
    public static var edgeCaseProbability: Double = 0.05
}
