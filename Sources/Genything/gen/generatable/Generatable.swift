/// Represents a type which can be generated from
public protocol Generatable {
    associatedtype T
    func start() -> Gen<T>
}

/// A type-erased generatable
public struct AnyGeneratable<T>: Generatable {
    private let _start: () -> Gen<T>

    /// Creates a type-erasing generatable to wrap the provided generatable
    ///
    /// - Parameter generatable: A generatable to wrap with a type-eraser.
    public init<G>(_ generatable: G) where T == G.T, G : Generatable {
        self._start = generatable.start
    }

    /// Starts a Gen instance
    public func start() -> Gen<T> {
        _start()
    }
}

public extension Generatable {
    func eraseToAnyGeneratable() -> AnyGeneratable<T> {
        AnyGeneratable(self)
    }
}
