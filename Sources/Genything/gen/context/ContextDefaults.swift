import Foundation

public enum ContextDefaults {
    public static var iterations: Int = 1000
    public static var maxFilterDepth: Int = 1000

    private(set) public static var defaultContextFactory: () -> Context = {
        Context(determinism: .predetermined(seed: 0))
    }
    public static func registerDefaultContext(_ factory: @escaping () -> Context) {
        defaultContextFactory = factory
    }
}
