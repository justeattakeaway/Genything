import Foundation

public extension Generators {
    static func ofCases<T: CaseIterable>() -> AnyGenerator<T> {
        T.arbitrary
    }
}
