import Foundation

/**
 * Holder class to pass along rng
 */
public struct GenComposer {
    fileprivate var context: Context

    public func generate<T>(using gen: Gen<T>) -> T {
        gen.generate(using: context)
    }

    public func generate<T>() -> T where T: Arbitrary {
        generate(using: T.arbitrary)
    }
}

/**
 * Construct a Generator by composing generation of arbitrary values.
 * Suitable for creation of more complex data types.
 */
extension Gen {
    public static func compose(build: @escaping (GenComposer) -> T) -> Gen<T> {
        Gen { ctx in
            build(GenComposer(context: ctx))
        }
    }
}
