import Foundation

// MARK: Build

public extension Gen {
    /// Returns: A generator which produces elements by iterating over the provided sequence
    ///
    /// - Parameters:
    ///    - sequence: Sequence which will be iterated over to produce elements
    ///
    /// - Returns: The generator
    static func iterate<S: Sequence>(_ sequence: S) -> Gen<T?> where S.Element == T {
        var iterator = sequence.makeIterator()

        return Gen<T?> { _ in
            iterator.next()
        }
    }
}
