import Foundation

// MARK: Combine

extension Generators {
    /// Easily draw values from various generators to create a generator which will execute the compose block for each generation.
    ///
    /// - Attention: The composition block is executed for each generated value, only truly arbitrary generators should be created in this block. If a generator which relies on it's own state is created in this block it will be recreated for each generated value. If a stateful generator is desired to be used you must hold the reference outside the block.
    ///
    /// - Parameters:
    ///   - build: A block which produces elements of type `T`
    ///
    /// - Returns: A generator which produces values of type `T`
    public static func compose<T>(_ compose: @escaping (Composer) -> T) -> AnyGenerator<T> {
        ComposingGenerator(compose).eraseToAnyGenerator()
    }
}

// MARK: - Composer

/// The composer class which passes in the randomSource and allows us to generate more complex data with ease
public struct Composer {

    // MARK: Public

    /// Generates a value using the provided `Generator`
    ///
    /// - Parameters:
    ///   - gen: A generator capable of producing vlaues of type `T`
    ///
    /// - Returns: A value of type `T`
    public func callAsFunction<G>(_ gen: G) -> G.T where G: Generator {
        gen.next(randomSource)
    }

    /// Generates a value using the provided `Gen<T>`
    ///
    /// - Parameters:
    ///   - gen: A generator capable of producing vlaues of type `T`
    ///
    /// - Returns: A value of type `T`
    public func generate<G>(_ gen: G) -> G.T where G: Generator {
        gen.next(randomSource)
    }

    /// Generates an arbitrary value of type `T` where `T` conforms to `Arbitrary`
    ///
    /// - Returns: An arbitrary value of type `T`
    public func arbitrary<T>() -> T where T: Arbitrary {
        generate(T.arbitrary)
    }

    /// Generates an arbitrary value of type `T` where `T` conforms to `Arbitrary`
    ///
    /// - Note: Duplicates `arbitrary()`
    ///
    /// - Returns: An arbitrary value of type `T`
    public func callAsFunction<T>() -> T where T: Arbitrary {
        generate(T.arbitrary)
    }

    /// Generates an arbitrary value of type `T` where `T` conforms to `CaseIterable`
    ///
    /// - Returns: An arbitrary value of type `T`
    public func arbitraryCase<T>() -> T where T: CaseIterable {
        generate(T.arbitrary)
    }

    /// Generates an arbitrary value of type `T` where `T` conforms to `CaseIterable`
    ///
    /// - Note: Duplicates `arbitraryCase()`
    ///
    /// - Returns: An arbitrary value of type `T`
    public func callAsFunction<T>() -> T where T: CaseIterable {
        generate(T.arbitrary)
    }

    // MARK: Internal

    /// Forwards the `RandomSource` to be used by the generators
    var randomSource: RandomSource

}

// MARK: - ComposingGenerator

private struct ComposingGenerator<T>: Generator {
    let compose: (Composer) -> T

    public init(_ compose: @escaping (Composer) -> T) {
        self.compose = compose
    }

    public func next(_ randomSource: RandomSource) -> T {
        compose(Composer(randomSource: randomSource))
    }
}
