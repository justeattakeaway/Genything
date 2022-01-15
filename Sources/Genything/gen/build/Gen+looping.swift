import Foundation

// MARK: Build

public extension Gen where T: Comparable {
    /// Returns: A generator which produces values from the sequence in sequential order.
    /// If the sequence is exhausted it will be restarted.
    ///
    /// e.g. `Gen.looping(["a", "b"])` will always output "abababababab"...
    /// e.g. `Gen.looping(0...1)` will always output "0101010101"...
    ///
    /// - Parameters:
    ///    - sequence: Sequence of values which will be produced in order. Looping if necessary.
    ///
    /// - Returns: The generator
    static func looping<S: Sequence>(_ sequence: S) -> Gen where S.Element == T {
        var iterator = sequence.makeIterator()
        var next = iterator.next()

        assert(next != nil, "`Gen.looping(sequence:)` was invoked with an empty sequence")

        return Gen<T> { _ in
            next = iterator.next()

            if let next = next {
                return next
            } else {
                iterator = sequence.makeIterator()
                next = iterator.next()
                return next!
            }
        }
    }

    /// Returns: A generator which combines the output of a sequence of generators into a single generator.
    ///
    /// Maintains sequential execution without interleaving emissions
    ///
    /// e.g. `Gen.looping([Gen.constant("a"), Gen.constant("b")])` will always output "abababababab"...
    ///
    /// - Parameters:
    ///    - sequence: Sequence of generators from which values will be selected from (in-order)
    ///
    /// - Returns: The generator
    static func looping<S: Sequence>(_ sequence: S) -> Gen where S.Element == Gen<T> {
        var iterator = sequence.makeIterator()
        var next = iterator.next()

        assert(next != nil, "`Gen.looping(sequence:)` was invoked with an empty sequence")

        return Gen<T> { ctx in
            next = iterator.next()

            if let next = next {
                return next.generate(context: ctx)
            } else {
                iterator = sequence.makeIterator()
                next = iterator.next()
                return next!.generate(context: ctx)
            }
        }
    }
}
