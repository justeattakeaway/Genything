/// Indicates a type which can be converted to a StatefulGen
public protocol StatefulGenConvertible {
    associatedtype T
    func asStatefulGen() -> StatefulGen<T>
}

extension Gen: StatefulGenConvertible {
    public func asStatefulGen() -> StatefulGen<T> {
        StatefulGen {
            self
        }
    }
}
