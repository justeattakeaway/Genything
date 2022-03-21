import Foundation

// MARK: Mutate

public extension Generator {
    /// Returns: The receiver's generator expanded to generate an array of the receiver's values
    ///
    /// The generated arrays will be of size `size`
    ///
    /// - Parameters:
    ///   - size: The size of the generated arrays
    ///
    /// - Returns: A `Gen` generator
    func expand(toSize size: Int) -> AnyGenerator<[T]> {
        Expand(source: self, size: size).eraseToAnyGenerator()
    }

    /// Returns: The receiver's generator expanded to generate an array of the receiver's values
    ///
    /// The generated arrays will be of random sizes in `range`
    ///
    /// - Parameters:
    ///   - range: A `Range` of values which will randomly determine the size of the generated arrays
    ///
    /// - Returns: A `Gen` generator
    func expand(toSizeInRange range: Range<Int>) -> AnyGenerator<[T]> {
        range.arbitrary.flatMap {
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
    func expand(toSizeInRange range: ClosedRange<Int>) -> AnyGenerator<[T]> {
        range.arbitrary.flatMap {
            expand(toSize: $0)
        }
    }
}

private struct Expand<Source>: Generator where Source: Generator {
    let source: Source
    let size: Int

    public func next(_ context: Context) -> [Source.T] {
        Array(repeating: source, count: size).map {
            $0.next(context)
        }
    }
}
