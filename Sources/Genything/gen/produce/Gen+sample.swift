import Foundation

public extension Gen {
    /**
     * Produces a non-deterministic random sample of the generator's values.
     * Recommended to be used **only** to evaluate or demonstrate the generator and not for real tests.
     */
    func samples(count: Int = 20) -> [T] {
        take(count: count, context: .random)
    }

    /**
     * Produces a single non-deterministic random value from the generator.
     * Recommendation to be used **only** to evaluate or demonstrate the generator and not for real tests.
     */
    func sample() -> T {
        generate(context: .random)
    }
}
