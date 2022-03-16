// MARK: Build

public extension Generatables {
    /// A generatable that **constantly** produces the provided value
    struct Constant<T>: Generatable {
        /// The one value which will constantly be produced
        public let value: T

        /// Initializes the Generatable that **constantly** produces the provided value
        ///
        /// - Parameter value: The value which will constantly be provided
        public init(_ value: T) {
            self.value = value
        }

        public func start() -> Gen<T> {
            Gen { value }
        }
    }
}
