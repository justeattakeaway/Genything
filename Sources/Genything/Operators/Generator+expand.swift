import Foundation

// MARK: Mutate

extension Generator {
    /// Returns: The receiver's generator expanded to generate an array of the receiver's values
    ///
    /// The generated arrays will be of size `size`
    ///
    /// - Parameters:
    ///   - size: The size of the generated arrays
    ///
    /// - Returns: A `Gen` generator
    public func expand(toSize size: Int) -> AnyGenerator<[T]> {
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
    public func expand(toSizeInRange range: Range<Int>) -> AnyGenerator<[T]> {
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
    public func expand(toSizeInRange range: ClosedRange<Int>) -> AnyGenerator<[T]> {
        range.arbitrary.flatMap {
            expand(toSize: $0)
        }
    }
}

// MARK: - Expand

private struct Expand<Source>: Generator where Source: Generator {
    let source: Source
    let size: Int

    public func next(_ randomSource: RandomSource) -> [Source.T] {
        Array(repeating: source, count: size).map {
            $0.next(randomSource)
        }
    }
}
