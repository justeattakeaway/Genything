extension Generators {
    /// Returns: A Generator that constantly produces the provided value
    /// - Parameter value: The value which will constantly be generated
    public static func constant<T>(_ value: T) -> AnyGenerator<T> {
        Constant(value).eraseToAnyGenerator()
    }

    /// A Generator that **constantly** produces the provided value
    struct Constant<T>: Generator {
        /// The one value which will constantly be produced
        public let value: T

        /// Initializes the Generator that constantly produces the provided value
        ///
        /// - Parameter value: The value which will constantly be generated
        public init(_ value: T) {
            self.value = value
        }

        public func next(_: RandomSource) -> T {
            value
        }
    }
}
