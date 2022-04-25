import XCTest
@testable import Genything

final class Generators_LazyTests: XCTestCase {
    func test_a_shared_generator_is_not_independent() {
        let iterator = Generators.iterate(0 ... 10)

        XCTAssertNotEqual(
            iterator.take(5, randomSource: .predetermined()),
            iterator.take(5, randomSource: .predetermined())
        )
    }

    func test_that_each_lazy_started_generator_is_independent() {
        let lazyIterator = LazyGenerator {
            Generators.iterate(0 ... 10)
        }

        XCTAssertEqual(
            lazyIterator.start().take(5, randomSource: .predetermined()),
            lazyIterator.start().take(5, randomSource: .predetermined())
        )
    }
}
