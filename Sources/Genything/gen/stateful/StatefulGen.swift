public struct StatefulGen<T> {
    private let builder: () -> Gen<T>

    public init(_ builder: @escaping () -> Gen<T>) {
        self.builder = builder
    }

    public func start() -> Gen<T> {
        builder()
    }
}


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
