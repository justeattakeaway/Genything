import Foundation

/// Global mutable defaults which will be used when initializing a `RandomSource`
///
/// - SeeAlso: `RandomSource`
public enum ContextDefaults {
    /// Stores a factory capable of creating the `RandomSource` which will be used by default
    public private(set) static var defaultContextFactory: () -> RandomSource = {
        RandomSource(determinism: .predetermined(seed: 2022))
    }

    /// Registers a function capable of creating the `RandomSource` which will be used by default
    public static func registerDefaultContext(_ factory: @escaping () -> RandomSource) {
        defaultContextFactory = factory
    }
}
