import Foundation

// MARK: Build

public extension Gen {
    static func looping<R>(
        _ next: @escaping @autoclosure () -> Gen<R?>
    ) -> Gen<R> where T == R? {
        next().switchTo(next()) { $0 == nil }.map { $0! }
    }
}

public extension Gen where T: Comparable {

    /// Returns: A generator which produces values from the collection in sequential order.
    /// If the collection is exhausted it will be restarted.
    ///
    /// e.g. `Gen.looping(["a", "b"])` will always output "abababababab"...
    /// e.g. `Gen.looping(0...1)` will always output "0101010101"...
    ///
    /// - Parameters:
    ///    - collection: Collection of values which will be produced in order. Looping if necessary.
    ///
    /// - Returns: The generator
    static func looping<C: Collection>(
        _ collection: @escaping @autoclosure () -> C
    ) -> Gen<T> where C.Element == T {
        iterate(collection()).switchUnwrap(iterate(collection()))
    }
//
//    /// Returns: A generator which combines the output of a sequence of generators into a single generator.
//    ///
//    /// Maintains sequential execution without interleaving emissions
//    ///
//    /// e.g. `Gen.looping([Gen.constant("a"), Gen.constant("b")])` will always output "abababababab"...
//    ///
//    /// - Parameters:
//    ///    - sequence: Sequence of generators from which values will be selected from (in-order)
//    ///
//    /// - Returns: The generator
//    static func looping<S: Collection>(_ sequence: S) -> Gen where S.Element == Gen<T> {
//        assertSequenceNotEmpty(sequence)
//
//        var i = sequence.startIndex
//        return Gen { ctx in
//            defer {
//                sequence.formIndex(after: &i)
//            }
//            if i >= sequence.endIndex {
//                i = sequence.startIndex
//            }
//            return sequence[i].generate(context: ctx)
//        }
//    }
}
