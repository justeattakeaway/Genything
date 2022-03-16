import Foundation

// MARK: Build

public extension Gen {
    /// The composer class which passes in the context and allows us to generate more complex data with ease
    struct Composer {
        /// Forwards the `Context` to be used by the generators
        fileprivate var context: Context

        /// Generates a value using the provided `Gen<T>`
        ///
        /// - Parameters:
        ///   - gen: A generator capable of producing vlaues of type `T`
        ///
        /// - Returns: A value of type `T`
        public func callAsFunction<T>(_ gen: Gen<T>) -> T {
            gen.generate(context: context)
        }

        /// Generates a value using the provided `Gen<T>`
        ///
        /// - Parameters:
        ///   - gen: A generator capable of producing vlaues of type `T`
        ///
        /// - Returns: A value of type `T`
        public func generate<T>(_ gen: Gen<T>) -> T {
            gen.generate(context: context)
        }

        /// Generates an arbitrary value of type `T` where `T` conforms to `Arbitrary`
        ///
        /// - Returns: An arbitrary value of type `T`
        public func arbitrary<T>() -> T where T: Arbitrary {
            generate(T.arbitrary.start())
        }

        /// Generates an arbitrary value of type `T` where `T` conforms to `CaseIterable`
        ///
        /// - Returns: An arbitrary value of type `T`
        public func ofCases<T>() -> T where T: CaseIterable {
            generate(Generatables.Cases<T>().start())
        }
    }

    /// Allows easy composition of various generators to create a complex model
    ///
    /// - Parameters:
    ///   - build: A callback which will produce the model of type `T`
    ///
    /// - Returns: A generator which produces values of type `T`
    static func compose(build: @escaping (Composer) -> T) -> Gen<T> {
        Gen { ctx in
            build(Composer(context: ctx))
        }
    }
}
