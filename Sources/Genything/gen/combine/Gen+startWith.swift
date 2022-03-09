import Foundation

// MARK: Combine

public extension Gen {
    /// Returns: A generator which iterates the elements of `sequence`. When exhausted the generator will switch to producing values from the receiving generator.
    ///
    /// - Parameters:
    ///    - values: Array of values which will be produced in order before the receiver takes over
    ///
    /// - Returns: The generator
    func startWith<S: Sequence>(_ sequence: S) -> Gen<T> where S.Element == T {
        Gen.iterate(sequence).switchUnwrap(self)
    }
}
