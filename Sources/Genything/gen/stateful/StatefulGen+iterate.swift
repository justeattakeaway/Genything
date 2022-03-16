import Foundation

// MARK: Build

extension Generatables {
    /// A generatable that generates a given sequence of elements.
    ///
    /// When the generator exhausts the elements in the sequence, it will begin to return nil.
    public struct Sequence<T, Elements>: Generatable where Elements: Swift.Sequence, Elements.Element == T {
        public let sequence: Elements

        /// Creates a generatables for a sequence of elements.
        ///
        /// - Parameter sequence: The sequence of elements to generate.
        public init(sequence: Elements) {
            self.sequence = sequence
        }

        public func start() -> Gen<T?> {
            var iterator = sequence.makeIterator()
            return Gen { _ in
                iterator.next()
            }
        }
    }
}
