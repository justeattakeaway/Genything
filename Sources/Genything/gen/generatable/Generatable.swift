/// Represents a type which can be generated from
public protocol Generatable {
    associatedtype T
    func start() -> Gen<T>
}
