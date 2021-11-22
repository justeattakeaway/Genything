import Foundation

// MARK: Build

public extension Gen {
    /// The composer class which passes in the context and allows us to generate more complex data with ease
    struct GenComposer {
        fileprivate var context: Context

        public func generate<T>(_ gen: Gen<T>) -> T {
            gen.generate(context: context)
        }

        public func generate<T>() -> T where T: Arbitrary {
            generate(T.arbitrary)
        }
    }

    /// Allows easy composition of various generators to create a complex model
    ///
    /// - Parameters:
    ///   - build: A callback which will produce the model of type `T`
    ///
    /// - Returns: A generator which produces values of type `T`
    static func compose(build: @escaping (GenComposer) -> T) -> Gen<T> {
        Gen { ctx in
            build(GenComposer(context: ctx))
        }
    }
}
