import Foundation

// MARK: - RandomSource

/// A RandomSource holds a reference to a RandomNumberGenerator. Allowing for a session of deterministic random state to passed around to generators which can be restarted or replayed at any time.
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

    /// The original seed used to begin random number generation
    ///
    /// To be used for debugging purposes and to "replay" a generation event
    public let originalSeed: UInt64?

    /// A type-erased `RandomNumberGenerator`
    public var rng: AnyRandomNumberGenerator
    
    /// Controls the maximum size for unbounded arbitrary collections (such as Dictionaries or Arrays) of arbitrary values
    /// Due to the fact that these collections contain other arbitary values, which may themselves contain further collections this parameter may need to be tweaked for performance reasons.
    public var maxRecursiveArbitraryCollectionSize: Int = 33
    
    /// Controls the maximum size for unbounded arbitrary collections such as Strings
    public var maxArbitraryCollectionSize: Int = 100
}

// MARK: Convenience RandomSource Creators

extension RandomSource {

    /// Returns: The system’s default source of random data which is neither independent nor deterministic.
    public static var system: RandomSource = .init(using: SystemRandomNumberGenerator(), originalSeed: nil)

    /// Returns: An new, independent `RandomSource` initialized by default with a common seed for all Genything users
    public static func predetermined(seed: UInt64 = 2022) -> RandomSource {
        .init(using: LinearCongruentialRandomNumberGenerator(seed: seed), originalSeed: seed)
    }

    /// Returns: An new, independent `RandomSource` which can be used to replay a previous deterministic random execution
    /// - Note: Named to help with discoverability
    public static func replay(seed: UInt64) -> RandomSource {
        predetermined(seed: seed)
    }

    /// Returns: An new, independent `RandomSource` initialized from a nondeterministic seed
    public static func random() -> RandomSource {
        let seed = UInt64(arc4random())
        return .init(using: LinearCongruentialRandomNumberGenerator(seed: seed), originalSeed: seed)
    }
}
