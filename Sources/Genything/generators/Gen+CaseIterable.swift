import Foundation

public extension Generator where T: CaseIterable {
    static func ofCases() -> AnyGenerator<T> {
        Cases().eraseToAnyGenerator()
    }
}

private struct Cases<T>: Generator where T: CaseIterable {
    public init() {
        assert(!T.allCases.isEmpty, "`Generators.Cases()` created with empty CaseIterable.")
    }

    public func next(_ context: Context) -> T {
        T.allCases.randomElement(using: &context.rng)!
    }
}
