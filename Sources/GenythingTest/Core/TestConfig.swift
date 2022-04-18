import Genything

// MARK: - TestConfig

/// Configuration that will be used for Genything tests
///
/// - SeeAlso: `XCTestCase+testAll`
/// - SeeAlso: `XCTestCase+testAllSatisfy`
public struct TestConfig {
    /// The maximum iterations that can be run by a test function
    public var maxIterations: Int

    /// The random source to be used by testing functions
    public var randomSource: RandomSource
}

extension TestConfig {

    /// Registers a function capable of creating a `TestConfig` which will be used by default
    public static func registerDefault(_ factory: @escaping () -> TestConfig) {
        defaultFactory = factory
    }

    /// Produces a new instance of the default test config
    ///
    /// Can be overriden globally by calling to `TestConfig.registerDefault(factory:)`
    ///
    /// By default returns a configuration with `maxIterations = 1000` and a random source which is both deterministic (the order of values produced is predictible and repeatable) and independent (each test will have no affect on any other test)
    public static func `default`() -> TestConfig {
        defaultFactory()
    }

    /// Storage for the factory capable of creating a `TestConfig` which will be used by default
    private static var `defaultFactory`: () -> TestConfig = {
        TestConfig(
            maxIterations: 1000,
            randomSource: RandomSource()
        )
    }

}
