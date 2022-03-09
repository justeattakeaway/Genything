import Foundation

// MARK: Build

internal extension Gen {
    /// Returns: A generator produced by the factory which has been given a reference to the Context
    ///
    /// - Parameter factory: A factory which produces a Generator using the provided Context
    ///
    /// - Returns: The generator
    static func inContext(_ factory: @escaping (Context) throws -> Gen<T>) -> Gen<T> {
        var generator: Gen<T>!
        return Gen { ctx in
            if generator == nil {
                generator = try factory(ctx)
            }
            return generator.generate(context: ctx)
        }
    }
}
