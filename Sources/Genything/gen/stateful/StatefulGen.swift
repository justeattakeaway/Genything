public struct StatefulGen<T> {
    private let builder: () -> Gen<T>

    public init(_ builder: @escaping () -> Gen<T>) {
        self.builder = builder
    }
}

extension StatefulGen: Generatable {
    public func start() -> Gen<T> {
        builder()
    }
}
