import Foundation

// MARK: Build

public extension Gen {
    /// Returns: A generator which produces values from the collection in sequential order.
    /// If the collection is exhausted it will be restarted.
    ///
    /// e.g. `Gen.looping(["a", "b"])` will always output "abababababab"...
    /// e.g. `Gen.looping(0...1)` will always output "0101010101"...
    ///
    /// - Parameters:
    ///    - sequence: Collection of values which will be produced in order. Looping if necessary.
    ///
    /// - Returns: The generator
    static func looping<S: Sequence>(
        _ sequence: S
    ) -> Gen<T> where S.Element == T {
        iterate(sequence).switchUnwrap(iterate(sequence))
    }
}

extension Gen {
    /// Returns: A generator which loops a Generator of optional elements. Calling again to refresh the generator when nil is produced.
    ///
    /// - Warning: Can lead to infinite loops. Internal.
    ///
    /// - Parameters:
    ///    - refresh: Autoclosure capable of refreshing the loop with a new generator after the previous has been exhausted
    ///
    /// - Returns: The generator
    static func looping<R>(
        _ refresh: @escaping @autoclosure () -> Gen<R?>
    ) -> Gen<R> where T == R? {
        refresh().switchTo(refresh()) { $0 == nil }.map { $0! }
    }
}
