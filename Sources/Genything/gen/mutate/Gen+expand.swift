import Foundation

// MARK: Mutate

public extension Generatable {
    /// Returns: The receiver's generator expanded to generate an array of the receiver's values
    ///
    /// The generated arrays will be of size `size`
    ///
    /// - Parameters:
    ///   - size: The size of the generated arrays
    ///
    /// - Returns: A `Gen` generator
    func expand(toSize size: Int) -> Generatables.Expand<T> {
        Generatables.Expand(source: start, size: size)
    }

    /// Returns: The receiver's generator expanded to generate an array of the receiver's values
    ///
    /// The generated arrays will be of random sizes in `range`
    ///
    /// - Parameters:
    ///   - range: A `Range` of values which will randomly determine the size of the generated arrays
    ///
    /// - Returns: A `Gen` generator
    func expand(toSizeInRange range: Range<Int>) -> AnyGeneratable<[T]> {
        Gen<Int>.from(range).flatMap {
            expand(toSize: $0)
        }.eraseToAnyGeneratable()
    }

    /// Returns: The receiver's generator expanded to generate an array of the receiver's values
    ///
    /// The generated arrays will be of random sizes in `range`
    ///
    /// - Parameters:
    ///   - range: A `Range` of values which will randomly determine the size of the generated arrays
    ///
    /// - Returns: A `Gen` generator
    func expand(toSizeInRange range: ClosedRange<Int>) -> AnyGeneratable<[T]> {
        Gen<Int>.from(range).flatMap {
            expand(toSize: $0)
        }.eraseToAnyGeneratable()
    }
}

extension Generatables {
    public struct Expand<SourceType>: Generatable {
        let source: () -> Gen<SourceType>
        let size: Int

        public func start() -> Gen<[SourceType]> {
            let sourceGen = source()
            return Gen<[SourceType]> { ctx in
                Array<Gen<SourceType>>(repeating: sourceGen, count: size).map {
                    $0.generate(context: ctx)
                }
            }
        }
    }
}
