import Foundation

public class Context {

    // MARK: Randomness

    internal var rng: AnyRandomNumberGenerator
    public let originalSeed: Int?

    // MARK: Mutate

    public var maxFilterDepth: Int = ContextDefaults.maxFilterDepth

    // MARK: Produce

    public var iterations: Int = ContextDefaults.iterations
    public var maxCollectionSize: Int = ContextDefaults.maxCollectionSize

    // MARK: Init

    public init(using rng: RandomNumberGenerator, originalSeed: Int? = nil) {
        self.rng = AnyRandomNumberGenerator(rng: rng)
        self.originalSeed = originalSeed
    }
}

// MARK: Convenience Context creators

public extension Context {
    static var random: Context { .init(determinism: .random) }
    static var `default`: Context { ContextDefaults.defaultContextFactory() }
}
