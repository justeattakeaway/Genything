// MARK: Mutate

public extension StatefulGen {
    /// Returns: A generator that transforms the receivers' values into a value of type `R`
    ///
    /// - Parameters:
    ///   - transform: A function capable of transforming the receiver's values to type `R`
    ///
    /// - Returns: A `Gen` generator of values of type `R`
    func map<R>(_ transform: @escaping (T) throws -> R) -> StatefulGen<R> {
        StatefulGen<R> { start().map(transform) }
    }
}
