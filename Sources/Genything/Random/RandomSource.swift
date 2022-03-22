import Foundation

// MARK: - RandomSource

/// The randomSource will be passed through all generators
///
/// It's main purpose is to hold onto the Random Number Generator `rng`, so that as generations occur the RNG's state changes are propogated to each generator
///
/// - Note: The source can be held onto by a user to keep track of `rng`'s state between generations
public class RandomSource {

    // MARK: Lifecycle

    // MARK: Init

    /// Creates a `RandomSource`
    ///
    /// - Parameters:
    ///   - rng: The Random Number Generator to be used to produce values
    ///   - originalSeed: The original seed (start position) of `rng`
    ///
    public init(using rng: RandomNumberGenerator, originalSeed: UInt64) {
        self.rng = AnyRandomNumberGenerator(rng: rng)
        self.originalSeed = originalSeed
    }

    // MARK: Public

    /// The original seed used to begin random number generation
    ///
    /// To be used for debugging purposes and to "replay" a generation event
    public let originalSeed: UInt64

    // MARK: Internal

    // MARK: Randomness

    /// A type-erased random number generator conformed to `RandomNumberGenerator`
    internal var rng: AnyRandomNumberGenerator

}

// MARK: Convenience RandomSource Creators

extension RandomSource {
    /// Creates a `RandomSource` initialized to default values, with random `Determinism`
    public class var random: RandomSource { .init(determinism: .random) }

    /// Creates a  default`RandomSource`
    public class var `default`: RandomSource { ContextDefaults.defaultContextFactory() }
}
