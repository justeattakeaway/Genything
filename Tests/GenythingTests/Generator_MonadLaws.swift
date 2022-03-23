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
        // given any modifier (avoiding divide by zero and integer overflows)
        let modifier = (-50...(-1)).arbitrary.or((1...50).arbitrary)

        // and any 2 functions which apply the modifier and wrap the result in a generator
        let twoApplyingFunctions = [
            { (modifier: Int) in { (value: Int) in Generators.constant(value + modifier) }},
            { (modifier: Int) in { (value: Int) in Generators.constant(value - modifier) }},
            { (modifier: Int) in { (value: Int) in Generators.constant(value * modifier) }},
            { (modifier: Int) in { (value: Int) in Generators.constant(value / modifier) }},
        ]
        .arbitrary
        .zip(modifier) { fn, modifier in
            fn(modifier)
        }
        .expand(toSize: 2)

        // the associativity law is satisfied
        testAllSatisfy((-50...50).arbitrary, twoApplyingFunctions) { value, functions in
            let generator = Generators.constant(value)

            let chained = generator.flatMap(functions[0]).flatMap(functions[1])
            let nested = generator.flatMap {
                functions[0]($0).flatMap(functions[1])
            }

            return chained.next(RandomSource()) == nested.next(RandomSource())
        }
    }
}
