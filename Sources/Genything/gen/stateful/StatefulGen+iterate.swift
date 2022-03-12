import Foundation

// MARK: Build

public extension StatefulGen {
    /// Returns: A generator which produces elements by iterating over the provided sequence
    ///
    /// - Parameters:
    ///    - sequence: Sequence which will be iterated over to produce elements
    ///
    /// - Returns: The generator
    static func iterate<S: Sequence>(_ sequence: S) -> StatefulGen<T?> where S.Element == T {
        StatefulGen<T?> {
            var iterator = sequence.makeIterator()
            return Gen { _ in
                iterator.next()
            }
        }
    }
}
