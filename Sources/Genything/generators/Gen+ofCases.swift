import Foundation

public extension Generators {
    static func ofCases<T: CaseIterable>() -> AnyGenerator<T> {
        OfCases().eraseToAnyGenerator()
    }
}

private struct OfCases<T>: Generator where T: CaseIterable {
    public init() {
        assert(!T.allCases.isEmpty, "`Generators.Cases()` created with empty CaseIterable.")
    }

    public func next(_ context: Context) -> T {
        T.allCases.randomElement(using: &context.rng)!
    }
}
