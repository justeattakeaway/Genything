import Foundation

public extension Gen {
    /**
     * Returns an optionally sized sequence which generates values using the provided Context
     * A `nil` size parameter will return an infinite sequence.
     */
    func sequence(ofSize size: Int?,
                  context: Context = .default) -> GenSequence<T> {
        GenSequence(size: size) {
            generate(using: context)
        }
    }

    /**
     * Iterates (lazily) over the sequence of size `iterations` and executes a given predicate `body` . Using the provided Context.
     */
    func forEach(iterations: Int = GenConfig.iterations,
                 context: Context = .default,
                 _ body: (T) -> Void) {
        sequence(ofSize: iterations, context: context).forEach(body)
    }

    /**
     * Returns a Boolean value indicating whether every element of a sequence (of size `iterations`) satisfies a given predicate. Using the provided Context.
     */
    func allSatisfy(iterations: Int = GenConfig.iterations,
                    context: Context = .default,
                    _ predicate: (T) -> Bool) -> Bool {
        sequence(ofSize: iterations, context: context).allSatisfy(predicate)
    }

    /**
     * Returns a value from the generator using the provided Context
     */
    func generate(context: Context = .default) -> T {
        generate(using: context)
    }

    /**
     * Returns array of size `count` from the generator using the provided Context
     */
    func take(count: Int = GenConfig.iterations,
              context: Context = .default) -> [T] {
        (0..<count).map { _ in
            generate(using: context)
        }
    }
}
