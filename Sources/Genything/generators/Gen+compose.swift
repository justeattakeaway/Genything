import Foundation

// MARK: Build

/// The composer class which passes in the context and allows us to generate more complex data with ease
public struct Composer {
    /// Forwards the `Context` to be used by the generators
    fileprivate var context: Context

    /// Generates a value using the provided `Generator`
    ///
    /// - Parameters:
    ///   - gen: A generator capable of producing vlaues of type `T`
    ///
    /// - Returns: A value of type `T`
    public func callAsFunction<G>(_ gen: G) -> G.T where G: Generator {
        gen.next(context)
    }

    /// Generates a value using the provided `Gen<T>`
    ///
    /// - Parameters:
    ///   - gen: A generator capable of producing vlaues of type `T`
    ///
    /// - Returns: A value of type `T`
    public func generate<G>(_ gen: G) -> G.T where G: Generator {
        gen.next(context)
    }

    /// Generates an arbitrary value of type `T` where `T` conforms to `Arbitrary`
    ///
    /// - Returns: An arbitrary value of type `T`
    public func arbitrary<T>() -> T where T: Arbitrary {
        generate(T.arbitrary)
    }

    /// Generates an arbitrary value of type `T` where `T` conforms to `CaseIterable`
    ///
    /// - Returns: An arbitrary value of type `T`
    public func ofCases<T>() -> T where T: CaseIterable {
        generate(Generators.Cases<T>())
    }
}

extension Generators {
    /// Allows easy composition of various generators to create a complex model
    ///
    /// - Parameters:
    ///   - build: A callback which will produce the model of type `T`
    ///
    /// - Returns: A generator which produces values of type `T`
    static func compose<T>(build: @escaping (Composer) -> T) -> AnyGenerator<T> {
        AnyGenerator { ctx in
            build(Composer(context: ctx))
        }
    }
}
