import Foundation

// MARK: Build

public extension Generators {
    struct Composer<T>: Generator {
        let compose: (ComposerContext) -> T

        public init(_ compose: @escaping (ComposerContext) -> T) {
            self.compose = compose
        }

        /// The composer class which passes in the context and allows us to generate more complex data with ease
        public struct ComposerContext {
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

        public func next(_ context: Context) -> T {
            compose(ComposerContext(context: context))
        }
    }
}
