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
        Compose(compose).eraseToAnyGenerator()
    }


    struct Compose<T>: Generator {
        let compose: (Composer) -> T

        public init(_ compose: @escaping (Composer) -> T) {
            self.compose = compose
        }

        public func next(_ randomSource: RandomSource) -> T {
            compose(Composer(randomSource: randomSource))
        }
    }

}
