import Foundation

// MARK: Build

internal extension Gen {
    /// Returns: A generator produced by the factory which has been given a reference to the Context
    ///
    /// - Parameter factory: A factory which produces a Generator using the provided Context
    ///
    /// - Returns: The generator
    static func inContext(_ factory: @escaping (Context) throws -> Gen<T>) -> Gen<T> {
        self.init { ctx in
            try factory(ctx).generate(context: ctx)
        }
    }
}
