import Genything
import GenythingTest
import XCTest

final class Generator_ObeysMonadLaws: XCTestCase {
    func test_left_identity() {
        let value = 10
        let generator = Generators.constant(value)

        func increment(value: Int) -> AnyGenerator<Int> {
            Generators.constant(value + 1)
        }

        let flatMapResult = generator.flatMap(increment)
        let normalResult = increment(value: value)

        XCTAssertEqual(
            flatMapResult.next(.init()),
            normalResult.next(.init())
        )
    }

    func test_right_identity() {
        let value = 10
        let generator = Generators.constant(value)

        func wrap(value: Int) -> AnyGenerator<Int> {
            Generators.constant(value)
        }

        let flatMapResult = generator.flatMap(wrap)
        let normalResult = wrap(value: value)

        XCTAssertEqual(
            flatMapResult.next(.init()),
            normalResult.next(.init())
        )
    }

    func test_associativity() {
        let value = 10
        let generator = Generators.constant(value)

        let addTen = { Generators.constant($0 + 10) }
        let subtractThree = { Generators.constant($0 - 3) }

        let chain = generator.flatMap(addTen).flatMap(subtractThree)
        let nest = generator.flatMap {
            addTen($0).flatMap(subtractThree)
        }

        XCTAssertEqual(
            chain.next(.init()),
            nest.next(.init())
        )
    }
}
