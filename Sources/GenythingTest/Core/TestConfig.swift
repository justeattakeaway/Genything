import Genything

// MARK: - GenythingTestConfig

/// Configuration that will be used for Genything tests
///
/// - SeeAlso: `XCTestCase+testAll`
/// - SeeAlso: `XCTestCase+testAllSatisfy`
public struct GenythingTestConfig {
    /// The maximum iterations that can be run by a test function
    public var maxIterations: Int

    /// The random source to be used by testing functions
    public var randomSource: RandomSource
}

extension GenythingTestConfig {

    // MARK: Public

    /// Registers a function capable of creating a `GenythingTestConfig` which will be used by default
    public static func registerDefault(_ factory: @escaping () -> GenythingTestConfig) {
        defaultFactory = factory
    }

    /// Produces a new instance of the default test config
    ///
    /// Can be overriden globally by calling to `GenythingTestConfig.registerDefault(factory:)`
    ///
    /// By default returns a configuration with `maxIterations = 1000` and a random source which is both deterministic (the order of values produced is predictible and repeatable) and independent (each test will have no affect on any other test)
    public static func `default`() -> GenythingTestConfig {
        defaultFactory()
    }

    // MARK: Private

    /// Storage for the factory capable of creating a `GenythingTestConfig` which will be used by default
    private static var `defaultFactory`: () -> GenythingTestConfig = {
        GenythingTestConfig(
            maxIterations: 1000,
            randomSource: RandomSource()
        )
    }

}
