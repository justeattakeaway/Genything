import Foundation

public extension Gen {
    /// Returns: A generator which generates an array of the receiver's values
    ///
    /// The generated arrays will be of size `size`
    ///
    /// - Parameters:
    ///   - size: The size of the generated arrays
    ///
    /// - Returns: A `Gen` generator
    func proliferate(withSize size: Int) -> Gen<[T]> {
        Gen<[T]> { ctx in
            Array<Gen<T>>(repeating: self, count: size).map {
                $0.generate(using: ctx)
            }
        }
    }

    /// Returns: A generator which generates an array of the receiver's values
    ///
    /// The generated arrays will be of any size in `range`
    ///
    /// - Parameters:
    ///   - range: The `Range` which will be used to size the generated arrays
    ///
    /// - Returns: A `Gen` generator
    func proliferate(withSizeRange range: Range<Int>) -> Gen<[T]> {
        Gen<Int>.from(range).flatMap {
            proliferate(withSize: $0)
        }
    }

    /// Returns: A generator which generates an array of the receiver's values
    ///
    /// The generated arrays will be of any size in `range`
    ///
    /// - Parameters:
    ///   - range: The `Range` which will be used to size the generated arrays
    ///
    /// - Returns: A `Gen` generator
    func proliferate(in range: ClosedRange<Int>) -> Gen<[T]> {
        Gen<Int>.from(range).flatMap {
            proliferate(withSize: $0)
        }
    }
}
