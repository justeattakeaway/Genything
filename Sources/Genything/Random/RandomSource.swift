import Foundation

// MARK: - RandomSource

/// The randomSource will be passed through all generators
///
/// It's main purpose is to hold onto the Random Number Generator `rng`, so that as generations occur the RNG's state changes are propogated to each generator
///
/// - Note: The source can be held onto by a user to keep track of `rng`'s state between generations
public class RandomSource {

    /// Initializes a `RandomSource` from a `RandomNumberGenerator`
    ///
    /// - Parameters:
    ///   - rng: The Random Number Generator to be used to produce values
    ///   - originalSeed: The original seed (start position) of `rng`
    ///
    public init(using rng: RandomNumberGenerator, originalSeed: UInt64?) {
        self.rng = AnyRandomNumberGenerator(wrapped: rng)
        self.originalSeed = originalSeed
    }

    /// Initializes a `RandomSource` from a predetermined shared seed
    ///
    /// - Returns: A new, independent random source.
    public convenience init() {
        self.init(determinism: .predetermined(seed: 2022))
    }

    /// The original seed used to begin random number generation
    ///
    /// To be used for debugging purposes and to "replay" a generation event
    public let originalSeed: UInt64?

    /// A type-erased random number generator conformed to `RandomNumberGenerator`
    public var rng: AnyRandomNumberGenerator
}

// MARK: Convenience RandomSource Creators

extension RandomSource {
    /// Returns: An independent `RandomSource` initialized from a nondeterministic seed
    public static func random() -> RandomSource {
        .init(determinism: .random)
    }
}
