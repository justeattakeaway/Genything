import XCTest
@testable import Genything

final internal class GenContextTests: XCTestCase {
    func test_using_a_context() {
        // A new context is created each execution
        XCTAssertEqual(
            Int.arbitrary.generate(),
            Int.arbitrary.generate()
        )

        // To introduce randomness we need to track our context
        let context = Context(determinism: .predetermined(seed: 0))

        XCTAssertNotEqual(
            Int.arbitrary.generate(context: context),
            Int.arbitrary.generate(context: context)
        )
    }

    func test_generate_one_with_same_seed_produces_same() {
        let calls = (1...100).map { _ in
            Gen.from(1...100).generate()
        }

        let allCallsAreSame = calls.allSatisfy {
            $0 == calls[0]
        }

        XCTAssertTrue(allCallsAreSame)
    }

    func test_generate_one_with_propogated_rng_produces_differently() {
        let ctx = Context(determinism: .predetermined(seed: 0))

        let calls = (0..<100).map { _ in
            Gen.from(1...100).generate(context: ctx)
        }

        let distribution = calls.reduce(into: [Int:Int]()) { (acc, curr) in
            acc[curr] = (acc[curr] ?? 0) + 1
        }

        XCTAssertTrue(distribution.count > 10)
    }

    func test_multiple_takes_with_propagated_rng_produce_differently() {
        let ctx = Context(determinism: .predetermined(seed: 0))

        let first = Gen.from(1...100).take(count: 100, context: ctx)
        let second = Gen.from(1...100).take(count: 100, context: ctx)

        XCTAssertNotEqual(first, second)
    }

    func test_multiple_calls_with_same_seed_produce_same() {
        let first = Gen.from(1...100).take()
        let second = Gen.from(1...100).take()

        XCTAssertEqual(first, second)
    }

    func test_zipped_generators_draw_from_the_same_rng_and_produce_differently() {
        let result = Gen.zip(
            Gen.from(1...100),
            Gen.from(1...100)
        ).take()

        XCTAssertNotEqual(
            result.map { $0.0 },
            result.map { $0.1 }
        )
    }

    func test_byDefault_forEach_iterationCountIsBasedOnConfig() {
        var iterationCount = 0

        Gen.from(1...100).forEach { _ in
            iterationCount += 1
        }

        XCTAssertEqual(iterationCount, ContextDefaults.iterations)
    }
}
