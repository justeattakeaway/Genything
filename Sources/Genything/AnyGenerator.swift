/// A type-erased `Generator`
public struct AnyGenerator<T>: Generator {
    /// Creates a type-erasing Generator to wrap the provided Generator
    ///
    /// - Parameter Generator: A Generator to wrap with a type-eraser.
    public init<G>(_ generator: G) where T == G.T, G: Generator {
        wrappedNext = generator.next
    }

    /// Creates an `AnyGenerator` which generates elements via the provided block
    ///
    /// - Parameter next: A block which returns the next element
    public init(_ next: @escaping (RandomSource) -> T) {
        wrappedNext = next
    }

    /// Creates an `AnyGenerator` which generates elements via the provided autoclosure
    ///
    /// - Parameter next: A block which returns the next element
    public init(_ next: @autoclosure @escaping () -> T) {
        wrappedNext = { _ in next() }
    }

    /// Produces the next element from this generator using the provided random source
    ///
    /// - Parameter randomSource: A source of random to be used by upstream generators
    public func next(_ randomSource: RandomSource) -> T {
        wrappedNext(randomSource)
    }

    private let wrappedNext: (RandomSource) -> T

}

extension Generator {
    /// Erases types conforming to the abstract protocol Generator to the concrete struct AnyGenerator
    public func eraseToAnyGenerator() -> AnyGenerator<T> {
        AnyGenerator(self)
    }
}
