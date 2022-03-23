/// Represents a type which can be generated from
public protocol Generator: Generatable {
    associatedtype T
    func next(_ randomSource: RandomSource) -> T
}

extension Generator {
    public func start() -> Self {
        self
    }
}
