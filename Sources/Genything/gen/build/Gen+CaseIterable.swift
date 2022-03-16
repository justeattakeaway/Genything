import Foundation

public extension Generatables {
    struct Cases<T>: Generatable where T: CaseIterable {
        public init() {
            assert(!T.allCases.isEmpty, "`Generatables.Cases()` created with empty CaseIterable.")
        }

        public func start() -> Gen<T> {
            Gen {
                T.allCases.randomElement(using: &$0.rng)!
            }
        }
    }
}
