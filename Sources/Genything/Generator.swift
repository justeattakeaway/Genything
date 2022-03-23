/// Represents a type which can be generated from
public protocol Generator {
    associatedtype T
    func next(_ randomSource: RandomSource) -> T
}
