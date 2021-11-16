import Foundation

// MARK: Typeclass

public struct Gen<T> {
    /**
     * Generates a new value using provided RNG
     */
    private let generator: (Context) throws -> T

    /**
     * Constructor allowing default empty constants
     */
    public init(generator: @escaping (Context) throws -> T) {
        self.generator = generator
    }
}

// MARK: Generating using inout Any RNG

public extension Gen {
    /**
     * Generate a random instance of type T, that is compatible with the constraints of this generator
     */
    func generate(using context: Context) -> T {
        try! generator(context)
    }
}
