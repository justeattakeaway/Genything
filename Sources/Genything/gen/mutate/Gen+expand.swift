import Foundation

public extension Gen {
    /// Returns: The receiver's generator expanded to generate an array of the receiver's values
    ///
    /// The generated arrays will be of size `size`
    ///
    /// - Parameters:
    ///   - size: The size of the generated arrays
    ///
    /// - Returns: A `Gen` generator
    func expand(toSize size: Int) -> Gen<[T]> {
        Gen<[T]> { ctx in
            Array<Gen<T>>(repeating: self, count: size).map {
                $0.generate(context: ctx)
            }
        }
    }

    /// Returns: The receiver's generator expanded to generate an array of the receiver's values
    ///
    /// The generated arrays will be of random sizes in `range`
    ///
    /// - Parameters:
    ///   - range: A `Range` of values which will randomly determine the size of the generated arrays
    ///
    /// - Returns: A `Gen` generator
    func expand(toSizeInRange range: Range<Int>) -> Gen<[T]> {
        Gen<Int>.from(range).flatMap {
            expand(toSize: $0)
        }
    }

    /// Returns: The receiver's generator expanded to generate an array of the receiver's values
    ///
    /// The generated arrays will be of random sizes in `range`
    ///
    /// - Parameters:
    ///   - range: A `Range` of values which will randomly determine the size of the generated arrays
    ///
    /// - Returns: A `Gen` generator
    func expand(toSizeInRange range: ClosedRange<Int>) -> Gen<[T]> {
        Gen<Int>.from(range).flatMap {
            expand(toSize: $0)
        }
    }
}
