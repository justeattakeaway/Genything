// MARK: - Generator

/// Represents a type which can be generated from
public protocol Generator {
    associatedtype T
    func next(_ randomSource: RandomSource) -> T
}

// MARK: - AnyGenerator

/// A type-erased Generator
public struct AnyGenerator<T>: Generator {
    private let wrappedNext: (RandomSource) -> T

    /// Creates a type-erasing Generator to wrap the provided Generator
    ///
    /// - Parameter Generator: A Generator to wrap with a type-eraser.
    public init<G>(_ generator: G) where T == G.T, G: Generator {
        wrappedNext = generator.next
    }

    public init(_ next: @escaping (RandomSource) -> T) {
        wrappedNext = next
    }

    public func next(_ randomSource: RandomSource) -> T {
        wrappedNext(randomSource)
    }
}

extension Generator {
    public func eraseToAnyGenerator() -> AnyGenerator<T> {
        AnyGenerator(self)
    }
}
