import Foundation

// MARK: Build

public extension Generators {
    static func compose<T>(_ compose: @escaping (Composer) -> T) -> AnyGenerator<T> {
        ComposingGenerator(compose).eraseToAnyGenerator()
    }
}

/// The composer class which passes in the randomSource and allows us to generate more complex data with ease
public struct Composer {
    /// Forwards the `RandomSource` to be used by the generators
    var randomSource: RandomSource

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

    /// Generates an arbitrary value of type `T` where `T` conforms to `ArbitraryGeneratable`
    ///
    /// - Returns: An arbitrary value of type `T`
    public func arbitrary<T>() -> T where T: ArbitraryGeneratable {
        generate(T.arbitrary)
    }

    /// Generates an arbitrary value of type `T` where `T` conforms to `ArbitraryGeneratable`
    ///
    /// - Note: Duplicates `arbitrary()`
    ///
    /// - Returns: An arbitrary value of type `T`
    public func callAsFunction<T>() -> T where T: ArbitraryGeneratable {
        generate(T.arbitrary)
    }

    /// Generates an arbitrary value of type `T` where `T` conforms to `CaseIterable`
    ///
    /// - Returns: An arbitrary value of type `T`
    public func ofCases<T>() -> T where T: CaseIterable {
        generate(T.arbitrary)
    }

    /// Generates an arbitrary value of type `T` where `T` conforms to `CaseIterable`
    ///
    /// - Note: Duplicates `ofCases()`
    ///
    /// - Returns: An arbitrary value of type `T`
    public func callAsFunction<T>() -> T where T: CaseIterable {
        generate(T.arbitrary)
    }
}

private struct ComposingGenerator<T>: Generator {
    let compose: (Composer) -> T

    public init(_ compose: @escaping (Composer) -> T) {
        self.compose = compose
    }

    public func next(_ randomSource: RandomSource) -> T {
        compose(Composer(randomSource: randomSource))
    }
}
