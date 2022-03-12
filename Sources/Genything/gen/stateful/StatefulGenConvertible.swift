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
