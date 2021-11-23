import Foundation

// MARK: Gen Typeclass

/// A type class capable of generating a value of type `T` from a given `Context`
public struct Gen<T>: Identifiable {
    /// A stable identity for this generator
    public let id = UUID()

    /// A callback capable of generating a new value using the provided `Context`
    private let generator: (Context) throws -> T

    /// Initialize a new generator
    ///
    /// - Parameters:
    ///   - generator: The `generator` capable of generating a new value using the provided `Context`
    public init(generator: @escaping (Context) throws -> T) {
        self.generator = generator
    }
}

// MARK: Generation

public extension Gen {
    /// Returns: A single value produced by the generator using the provided Context
    ///
    /// - Parameters:
    ///   - context: The context to be used for generation
    ///
    /// - Returns: A value of type `T`
    func generate(context: Context = .default) -> T {
        try! generator(context)
    }
}
