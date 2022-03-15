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

extension Generatables {
    public struct Iterate<T, S: Sequence>: Generatable where S.Element == T {
        let sequence: S

        public func start() -> Gen<T?> {
            var iterator = sequence.makeIterator()
            return Gen { _ in
                iterator.next()
            }
        }
    }
}
