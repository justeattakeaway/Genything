// MARK: Build

public extension Generators {
    /// A Generator that **constantly** produces the provided value
    struct Constant<T>: Generator {
        /// The one value which will constantly be produced
        public let value: T

        /// Initializes the Generator that **constantly** produces the provided value
        ///
        /// - Parameter value: The value which will constantly be provided
        public init(_ value: T) {
            self.value = value
        }

        public func next(_ randomSource: RandomSource) -> T {
            value
        }
    }
}
