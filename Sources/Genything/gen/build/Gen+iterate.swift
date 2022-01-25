import Foundation

// MARK: Build

public extension Gen {
    /// Returns: A generator which produces values from the provided sequence (in order) or `nil` if the sequence becomes exhausted
    ///
    /// - Parameters:
    ///    - sequence: Sequence of values which will be produced in order
    ///
    /// - Returns: The generator
    static func iterate<S: Sequence>(_ sequence: S) -> Gen<T?> where S.Element == T {
        var iterator = sequence.makeIterator()

        return Gen<T?> { _ in
            iterator.next()
        }
    }
}
