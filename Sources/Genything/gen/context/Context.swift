import Foundation

/// The context will be passed through all generators
///
/// It's main purpose is to hold onto the Random Number Generator `rng`, so that as generations occur the RNG's state changes are propogated to each generator
///
/// - Note: The context can be held onto by a user to keep track of `rng`'s state between generations
///
public class Context {

    // MARK: Randomness

    /// A type-erased random number generator conformed to `RandomNumberGenerator`
    internal var rng: AnyRandomNumberGenerator

    /// The original seed used to begin random number generation, if available
    ///
    /// To be used for debugging purposes and to "replay" a generation event
    public let originalSeed: Int?

    // MARK: Mutate

    /// The maximum depth that a `filter` operation may experience before failing
    ///
    /// - SeeAlso: `Gen.filter(isIncluded:)`
    public var maxFilterDepth: Int = ContextDefaults.maxFilterDepth

    // MARK: Produce

    /// The maximum iterations that producers should run for
    ///
    /// - SeeAlso: `Gen.take(count:context:)`
    /// - SeeAlso: `Gen.forEach(iterations:context:)`
    /// - SeeAlso: `Gen.allSatisfy(iterations:context:)`
    public var maxIterations: Int = ContextDefaults.maxIterations

    // MARK: Init

    /// Creates a `Context`
    ///
    /// - Parameters:
    ///   - rng: The Random Number Generator to be used to produce values
    ///   - originalSeed: The original seed (start position) of `rng`, if possible
    ///
    public init(using rng: RandomNumberGenerator, originalSeed: Int? = nil) {
        self.rng = AnyRandomNumberGenerator(rng: rng)
        self.originalSeed = originalSeed
    }
}

// MARK: Convenience Context creators

public extension Context {
    /// Creates a `Context` initialized to default values, with random `Determinism`
    static var random: Context { .init(determinism: .random) }

    /// Creates a  default`Context`
    static var `default`: Context { ContextDefaults.defaultContextFactory() }
}
