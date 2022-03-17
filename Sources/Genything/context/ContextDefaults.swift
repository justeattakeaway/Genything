import Foundation

/// Global mutable defaults which will be used when initializing a `Context`
///
/// - SeeAlso: `Context`
public enum ContextDefaults {
    /// Stores a factory capable of creating the `Context` which will be used by default
    private(set) public static var defaultContextFactory: () -> Context = {
        Context(determinism: .predetermined(seed: 2022))
    }

    /// Registers a function capable of creating the `Context` which will be used by default
    public static func registerDefaultContext(_ factory: @escaping () -> Context) {
        defaultContextFactory = factory
    }
}
