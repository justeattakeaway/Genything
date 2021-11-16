import Foundation

public extension Gen {
    /**
     * Adapts an array of n generators into a single generator which produces an n sized array
     */
    static func traverse(_ parts: [Gen<T>]) -> Gen<[T]> {
        traverse(parts) { $0 }
    }

    /**
     * Adapts an array of n generators into a single generator which produces an n sized array
     * Mapping the given closure over the generators' elements.
     */
    static func traverse<R>(_ parts: [Gen<T>], transform: @escaping (T) -> R) -> Gen<[R]> {
        Gen<[R]> { ctx in
            parts.map { part in
                part.generate(using: ctx)
            }.map(transform)
        }
    }
}
