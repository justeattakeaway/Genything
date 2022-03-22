// MARK: - Generator

/// Represents a type which can be generated from
public protocol Generator {
    associatedtype T
    func next(_ randomSource: RandomSource) -> T
}

// MARK: - AnyGenerator

/// A type-erased Generator
public struct AnyGenerator<T>: Generator {
    private let _next: (RandomSource) -> T

    /// Creates a type-erasing Generator to wrap the provided Generator
    ///
    /// - Parameter Generator: A Generator to wrap with a type-eraser.
    public init<G>(_ generator: G) where T == G.T, G: Generator {
        _next = generator.next
    }

    public init(_ next: @escaping (RandomSource) -> T) {
        _next = next
    }

    public func next(_ randomSource: RandomSource) -> T {
        _next(randomSource)
    }
}

extension Generator {
    public func eraseToAnyGenerator() -> AnyGenerator<T> {
        AnyGenerator(self)
    }
}
