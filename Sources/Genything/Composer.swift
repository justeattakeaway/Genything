/// The composer class which passes in the randomSource and allows us to generate more complex data with ease
public struct Composer {

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

    /// Forwards the `RandomSource` to be used by the generators
    var randomSource: RandomSource

}
