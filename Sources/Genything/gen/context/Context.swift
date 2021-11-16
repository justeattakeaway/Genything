import Foundation

public class Context {

    // MARK: Random Properties

    internal var rng: AnyRandomNumberGenerator
    public let originalSeed: Int?

    // MARK: Defaults

    private static var defaultFactory: () -> Context = {
        Context(determinism: .predetermined(seed: 0))
    }
    public static func registerDefault(_ factory: @escaping () -> Context) {
        defaultFactory = factory
    }

    // MARK: Init

    public init(using rng: RandomNumberGenerator, originalSeed: Int? = nil) {
        self.rng = AnyRandomNumberGenerator(rng: rng)
        self.originalSeed = originalSeed
    }
}

// MARK: Convenience creators

public extension Context {
    static var random: Context { .init(determinism: .random) }
    static var `default`: Context { defaultFactory() }
}
